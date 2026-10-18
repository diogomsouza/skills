using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Management;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CodexPerfisTray
{
    public sealed class Profile
    {
        public string Name { get; private set; }
        public string BrowserDirectory { get; private set; }
        public string Launcher { get; private set; }
        public string IconPath { get; private set; }
        public bool IsDefault { get; private set; }

        public Profile(string name, string browserDirectory, string launcher, string iconPath, bool isDefault)
        {
            this.Name = name;
            this.BrowserDirectory = Path.GetFullPath(browserDirectory).TrimEnd('\\');
            this.Launcher = launcher;
            this.IconPath = iconPath;
            this.IsDefault = isDefault;
        }
    }

    public sealed class ProcessRecord
    {
        public int Id { get; private set; }
        public DateTime CreatedUtc { get; private set; }
        public string Executable { get; private set; }
        public string CommandLine { get; private set; }

        public ProcessRecord(int id, DateTime createdUtc, string executable, string commandLine)
        {
            this.Id = id;
            this.CreatedUtc = createdUtc;
            this.Executable = executable;
            this.CommandLine = commandLine;
        }

        public Process OpenVerified()
        {
            Process process = Process.GetProcessById(this.Id);
            try
            {
                // Pin the process identity with an open handle before any window action.
                IntPtr handle = process.Handle;
                if (process.HasExited || Math.Abs((process.StartTime.ToUniversalTime() - this.CreatedUtc).TotalMilliseconds) > 1)
                {
                    throw new InvalidOperationException("A instância mudou. Tente novamente pelo ícone do perfil.");
                }
                return process;
            }
            catch
            {
                process.Dispose();
                throw;
            }
        }
    }

    public sealed class ProfileLocator
    {
        private readonly Regex executablePattern;

        public ProfileLocator(string packageLocation)
        {
            string folder = Path.GetFileName(packageLocation.TrimEnd('\\'));
            int publisherIndex = folder.LastIndexOf("__", StringComparison.Ordinal);
            if (!folder.StartsWith("OpenAI.Codex_", StringComparison.OrdinalIgnoreCase) || publisherIndex < 0)
            {
                throw new ArgumentException("O diretório do pacote Codex não foi reconhecido.");
            }
            string parent = Path.GetDirectoryName(packageLocation.TrimEnd('\\'));
            string publisher = folder.Substring(publisherIndex);
            this.executablePattern = new Regex("^" + Regex.Escape(parent + "\\OpenAI.Codex_") +
                @"\d+\.\d+\.\d+\.\d+_(?:x64|arm64|x86|neutral)" + Regex.Escape(publisher + "\\app\\ChatGPT.exe") + "$",
                RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
        }

        public List<ProcessRecord> ReadProcesses()
        {
            List<ProcessRecord> processes = new List<ProcessRecord>();
            using (ManagementObjectSearcher searcher = new ManagementObjectSearcher(
                "SELECT ProcessId, CreationDate, ExecutablePath, CommandLine FROM Win32_Process WHERE Name = 'ChatGPT.exe'"))
            using (ManagementObjectCollection rows = searcher.Get())
            {
                foreach (ManagementObject row in rows)
                {
                    using (row)
                    {
                        string created = row["CreationDate"] as string;
                        if (created == null)
                        {
                            continue;
                        }
                        processes.Add(new ProcessRecord(Convert.ToInt32(row["ProcessId"]),
                            ManagementDateTimeConverter.ToDateTime(created).ToUniversalTime(),
                            row["ExecutablePath"] as string, row["CommandLine"] as string));
                    }
                }
            }
            return processes;
        }

        public bool Matches(Profile profile, ProcessRecord process)
        {
            if (String.IsNullOrWhiteSpace(process.Executable) || String.IsNullOrWhiteSpace(process.CommandLine) ||
                !this.executablePattern.IsMatch(process.Executable))
            {
                return false;
            }
            string[] arguments = NativeMethods.SplitCommandLine(process.CommandLine);
            string dataDirectory = null;
            for (int index = 1; index < arguments.Length; index++)
            {
                string argument = arguments[index];
                if (argument.Equals("--type", StringComparison.Ordinal) || argument.StartsWith("--type=", StringComparison.Ordinal))
                {
                    return false;
                }
                if (argument.Equals("--user-data-dir", StringComparison.Ordinal) || argument.StartsWith("--user-data-dir=", StringComparison.Ordinal))
                {
                    if (dataDirectory != null)
                    {
                        return false;
                    }
                    if (argument.Equals("--user-data-dir", StringComparison.Ordinal))
                    {
                        if (++index >= arguments.Length)
                        {
                            return false;
                        }
                        dataDirectory = arguments[index];
                    }
                    else
                    {
                        dataDirectory = argument.Substring("--user-data-dir=".Length);
                    }
                }
            }
            if (dataDirectory == null)
            {
                return profile.IsDefault;
            }
            if (String.IsNullOrWhiteSpace(dataDirectory))
            {
                return false;
            }
            try
            {
                if (!Path.IsPathRooted(dataDirectory) || Path.GetPathRoot(dataDirectory).Length < 3)
                {
                    return false;
                }
                return String.Equals(Path.GetFullPath(dataDirectory).TrimEnd('\\'), profile.BrowserDirectory, StringComparison.OrdinalIgnoreCase);
            }
            catch (ArgumentException)
            {
                return false;
            }
            catch (NotSupportedException)
            {
                return false;
            }
        }

        public ProcessRecord Find(Profile profile, IEnumerable<ProcessRecord> processes)
        {
            ProcessRecord[] matches = processes.Where(process => this.Matches(profile, process)).ToArray();
            if (matches.Length > 1)
            {
                throw new InvalidOperationException("Há mais de uma instância correspondente a " + profile.Name + ". Nenhuma foi fechada.");
            }
            return matches.SingleOrDefault();
        }
    }

    public static class NativeMethods
    {
        private delegate bool EnumWindowsCallback(IntPtr window, IntPtr parameter);

        [DllImport("shell32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        private static extern IntPtr CommandLineToArgvW(string commandLine, out int count);
        [DllImport("kernel32.dll")]
        private static extern IntPtr LocalFree(IntPtr memory);
        [DllImport("user32.dll")]
        private static extern bool EnumWindows(EnumWindowsCallback callback, IntPtr parameter);
        [DllImport("user32.dll")]
        private static extern uint GetWindowThreadProcessId(IntPtr window, out uint processId);
        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        private static extern int GetClassName(IntPtr window, StringBuilder name, int count);
        [DllImport("user32.dll")]
        private static extern bool IsWindowVisible(IntPtr window);
        [DllImport("user32.dll")]
        private static extern bool IsIconic(IntPtr window);
        [DllImport("user32.dll")]
        private static extern bool ShowWindow(IntPtr window, int command);
        [DllImport("user32.dll")]
        private static extern bool SetForegroundWindow(IntPtr window);
        [DllImport("user32.dll")]
        private static extern IntPtr GetForegroundWindow();
        [DllImport("user32.dll")]
        private static extern IntPtr GetWindow(IntPtr window, uint command);
        [DllImport("user32.dll")]
        private static extern short GetAsyncKeyState(int key);
        [DllImport("user32.dll", SetLastError = true)]
        private static extern uint SendInput(uint count, Input[] inputs, int size);

        [StructLayout(LayoutKind.Sequential)]
        private struct Input
        {
            public uint Type;
            public InputUnion Data;
        }
        [StructLayout(LayoutKind.Explicit)]
        private struct InputUnion
        {
            [FieldOffset(0)] public KeyboardInput Keyboard;
            [FieldOffset(0)] public MouseInput Mouse;
        }
        [StructLayout(LayoutKind.Sequential)]
        private struct KeyboardInput
        {
            public ushort Key;
            public ushort Scan;
            public uint Flags;
            public uint Time;
            public UIntPtr Extra;
        }
        [StructLayout(LayoutKind.Sequential)]
        private struct MouseInput
        {
            public int X;
            public int Y;
            public uint Data;
            public uint Flags;
            public uint Time;
            public UIntPtr Extra;
        }

        public static string[] SplitCommandLine(string commandLine)
        {
            int count;
            IntPtr memory = CommandLineToArgvW(commandLine, out count);
            if (memory == IntPtr.Zero)
            {
                throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
            }
            try
            {
                string[] arguments = new string[count];
                for (int index = 0; index < count; index++)
                {
                    arguments[index] = Marshal.PtrToStringUni(Marshal.ReadIntPtr(memory, index * IntPtr.Size));
                }
                return arguments;
            }
            finally
            {
                LocalFree(memory);
            }
        }

        public static IntPtr FindMainWindow(int processId)
        {
            IntPtr found = IntPtr.Zero;
            EnumWindows(delegate(IntPtr window, IntPtr parameter)
            {
                uint owner;
                GetWindowThreadProcessId(window, out owner);
                if (owner != processId || !IsWindowVisible(window) || GetWindow(window, 4) != IntPtr.Zero)
                {
                    return true;
                }
                StringBuilder className = new StringBuilder(256);
                GetClassName(window, className, className.Capacity);
                if (className.ToString() == "Chrome_WidgetWin_1")
                {
                    found = window;
                    return false;
                }
                return true;
            }, IntPtr.Zero);
            return found;
        }

        public static async Task ShowOrQuitAsync(Process process, IntPtr window, bool quit)
        {
            uint owner;
            GetWindowThreadProcessId(window, out owner);
            if (process.HasExited || owner != process.Id)
            {
                throw new InvalidOperationException("A janela do perfil não está mais disponível.");
            }
            ShowWindow(window, IsIconic(window) ? 9 : 5);
            SetForegroundWindow(window);
            await Task.Delay(200);
            if (!quit)
            {
                return;
            }
            // Never send a shortcut to whichever application happens to be focused.
            // The native Codex Quit command preserves its own active-task confirmation.
            IntPtr foreground = GetForegroundWindow();
            GetWindowThreadProcessId(foreground, out owner);
            if (process.HasExited || foreground != window || owner != process.Id)
            {
                throw new InvalidOperationException("Não foi possível ativar a janela correta. Nenhum comando de fechar foi enviado. Feche eventuais diálogos e tente novamente.");
            }
            foreach (int key in new int[] { 0x10, 0x11, 0x12, 0x5B, 0x5C })
            {
                if ((GetAsyncKeyState(key) & 0x8000) != 0)
                {
                    throw new InvalidOperationException("Solte as teclas Ctrl, Alt, Shift e Windows e tente novamente.");
                }
            }
            Input[] inputs = new Input[4];
            ushort[] keys = new ushort[] { 0x11, 0x51, 0x51, 0x11 };
            for (int index = 0; index < inputs.Length; index++)
            {
                inputs[index].Type = 1;
                inputs[index].Data.Keyboard.Key = keys[index];
                inputs[index].Data.Keyboard.Flags = index >= 2 ? 2U : 0U;
            }
            if (GetForegroundWindow() != window)
            {
                throw new InvalidOperationException("O foco mudou antes do comando. Nenhum comando de fechar foi enviado.");
            }
            if (SendInput(4, inputs, Marshal.SizeOf(typeof(Input))) != 4)
            {
                // Release only the injected keys if Windows accepted a partial batch.
                Input[] releases = new Input[] { inputs[2], inputs[3] };
                SendInput(2, releases, Marshal.SizeOf(typeof(Input)));
                throw new InvalidOperationException("O Windows não aceitou o comando de saída. Nenhum processo foi encerrado à força.");
            }
        }
    }


    public sealed class TrayContext : ApplicationContext
    {
        private readonly Profile profile;
        private readonly Process process;
        private readonly string powerShell;
        private readonly NotifyIcon icon;
        private readonly Icon image;
        private readonly ContextMenuStrip menu;
        private readonly System.Windows.Forms.Timer timer;
        private bool acting;
        private bool disposed;

        public TrayContext(Profile profile, Process process, string powerShell)
        {
            this.profile = profile;
            this.process = process;
            this.powerShell = powerShell;
            this.image = new Icon(profile.IconPath, 32, 32);
            this.menu = new ContextMenuStrip();
            this.menu.Items.Add("Codex " + profile.Name).Enabled = false;
            this.menu.Items.Add(new ToolStripSeparator());
            this.menu.Items.Add("Open", null, async delegate { await this.ActAsync(false); });
            this.menu.Items.Add("Exit", null, async delegate { await this.ActAsync(true); });
            this.icon = new NotifyIcon();
            this.icon.Icon = this.image;
            this.icon.Text = "Codex " + profile.Name;
            this.icon.ContextMenuStrip = this.menu;
            this.icon.MouseClick += async delegate(object sender, MouseEventArgs args)
            {
                if (args.Button == MouseButtons.Left)
                {
                    await this.ActAsync(false);
                }
            };
            this.icon.Visible = true;
            this.timer = new System.Windows.Forms.Timer();
            this.timer.Interval = 1000;
            this.timer.Tick += delegate { this.CheckProcess(); };
            this.timer.Start();
        }

        private void CheckProcess()
        {
            if (!this.disposed && this.process.HasExited)
            {
                this.ExitThread();
            }
        }

        private async Task ActAsync(bool quit)
        {
            if (this.acting || this.disposed)
            {
                return;
            }
            this.acting = true;
            try
            {
                await Task.Delay(150);
                if (this.disposed)
                {
                    return;
                }
                if (this.process.HasExited)
                {
                    this.ExitThread();
                    return;
                }
                IntPtr window = NativeMethods.FindMainWindow(this.process.Id);
                if (window == IntPtr.Zero)
                {
                    // Recover this instance's window without starting another tray controller.
                    ProcessStartInfo start = new ProcessStartInfo(this.powerShell);
                    start.Arguments = "-NoProfile -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File \"" + this.profile.Launcher + "\" -OpenWindowOnly";
                    start.UseShellExecute = false;
                    start.CreateNoWindow = true;
                    start.WorkingDirectory = Path.GetDirectoryName(this.profile.Launcher);
                    using (Process launcher = Process.Start(start)) { }
                    for (int attempt = 0; attempt < 40 && window == IntPtr.Zero && !this.disposed && !this.process.HasExited; attempt++)
                    {
                        await Task.Delay(250);
                        if (!this.disposed && !this.process.HasExited)
                        {
                            window = NativeMethods.FindMainWindow(this.process.Id);
                        }
                    }
                }
                if (this.disposed)
                {
                    return;
                }
                if (this.process.HasExited)
                {
                    this.ExitThread();
                    return;
                }
                if (window == IntPtr.Zero)
                {
                    throw new InvalidOperationException("Não foi possível localizar a janela deste perfil. Nenhum comando de fechar foi enviado.");
                }
                await NativeMethods.ShowOrQuitAsync(this.process, window, quit);
            }
            catch (Exception error)
            {
                if (!this.disposed)
                {
                    MessageBox.Show(error.Message, "Codex — " + this.profile.Name, MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            finally
            {
                this.acting = false;
            }
            this.CheckProcess();
        }

        protected override void ExitThreadCore()
        {
            this.Dispose();
            base.ExitThreadCore();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && !this.disposed)
            {
                this.disposed = true;
                this.timer.Stop();
                this.timer.Dispose();
                this.icon.Visible = false;
                this.icon.Dispose();
                this.menu.Dispose();
                this.image.Dispose();
            }
            base.Dispose(disposing);
        }
    }

    public static class TrayApplication
    {
        public static void Run(Profile profile, string powerShell, string packageLocation)
        {
            ProfileLocator locator = new ProfileLocator(packageLocation);
            ProcessRecord record = null;
            Stopwatch timeout = Stopwatch.StartNew();
            while (record == null && timeout.Elapsed < TimeSpan.FromSeconds(30))
            {
                record = locator.Find(profile, locator.ReadProcesses());
                if (record == null)
                {
                    Thread.Sleep(250);
                }
            }
            if (record == null)
            {
                throw new InvalidOperationException("O Codex " + profile.Name + " não iniciou dentro do prazo. Tente novamente pelo atalho.");
            }
            using (Process process = record.OpenVerified())
            {
                // Bind both the controller and its mutex to this exact process lifetime.
                string name = @"Local\CodexProfileTray-" + WindowsIdentity.GetCurrent().User.Value + "-" + record.Id + "-" + record.CreatedUtc.Ticks;
                bool created;
                using (Mutex mutex = new Mutex(true, name, out created))
                {
                    if (!created)
                    {
                        return;
                    }
                    try
                    {
                        if (process.HasExited)
                        {
                            return;
                        }
                        Application.EnableVisualStyles();
                        Application.SetCompatibleTextRenderingDefault(false);
                        using (TrayContext context = new TrayContext(profile, process, powerShell))
                        {
                            Application.Run(context);
                        }
                    }
                    finally
                    {
                        mutex.ReleaseMutex();
                    }
                }
            }
        }
    }
}