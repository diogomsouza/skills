Option Explicit

Dim shell, files, launcherRoot, powerShell, command, encodedPattern
Set shell = CreateObject("WScript.Shell")
Set files = CreateObject("Scripting.FileSystemObject")
launcherRoot = files.GetParentFolderName(WScript.ScriptFullName)
powerShell = shell.ExpandEnvironmentStrings("%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe")
command = Chr(34) & powerShell & Chr(34) & " -NoProfile -NonInteractive -STA -WindowStyle Hidden -ExecutionPolicy Bypass "

Select Case WScript.Arguments.Count
    Case 0, 1
        If WScript.Arguments.Count = 1 Then
            If WScript.Arguments(0) <> "-OpenWindowOnly" And WScript.Arguments(0) <> "-TrayOnly" Then
                Err.Raise 5, "Codex launcher", "Unsupported launcher arguments."
            End If
        End If
        If Not files.FileExists(files.BuildPath(launcherRoot, "codex-elevated-restart.ps1")) Then
            Err.Raise 53, "Codex launcher", "The adjacent PowerShell launcher was not found."
        End If
        command = command & "-File " & Chr(34) & files.BuildPath(launcherRoot, "codex-elevated-restart.ps1") & Chr(34)
        If WScript.Arguments.Count = 1 Then
            command = command & " " & WScript.Arguments(0)
        End If
    Case 2
        If WScript.Arguments(0) <> "-EncodedCommand" Then
            Err.Raise 5, "Codex launcher", "Unsupported launcher arguments."
        End If
        Set encodedPattern = New RegExp
        encodedPattern.Pattern = "^[A-Za-z0-9+/]+={0,2}$"
        If Not encodedPattern.Test(WScript.Arguments(1)) Then
            Err.Raise 5, "Codex launcher", "Invalid encoded launch command."
        End If
        command = command & "-EncodedCommand " & WScript.Arguments(1)
    Case Else
        Err.Raise 5, "Codex launcher", "Unsupported launcher arguments."
End Select

shell.CurrentDirectory = launcherRoot
shell.Run command, 0, False
