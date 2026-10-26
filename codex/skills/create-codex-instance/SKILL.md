---
name: create-codex-instance
description: Create a separate Codex desktop instance on Windows, asking for its name and icon color, then configuring an isolated profile, elevated launcher, per-instance tray icon, and shortcut pinned to Start. Use for requests to create a new Codex instance or profile, not a new chat or Git worktree.
---

# Create a Codex instance

Create a fresh Windows Codex profile using only this skill's bundled assets and the installed OpenAI.Codex application. This workflow is self-contained: do not inspect or copy another instance, and do not depend on any previously configured profile.

## Collect the two choices

Use the user's language. Ask one question at a time, in this order:

1. “What will be the name of the new Codex instance?”
2. “What color should the icon be?”

Wait for each answer. Skip any choice already supplied. A color name or hex value is sufficient; do not restrict the user to the bundled colors. After both answers, create the configuration without requesting another confirmation. Ask again only for a concrete blocker such as an invalid or already-used destination name.

## Prepare the paths

Run on Windows with Windows PowerShell 5.1, the OpenAI.Codex Store package, and `Invoke-CommandInDesktopPackage`. Inspect the installed package and manifest, never a hardcoded package version. If prerequisites are missing, explain what is missing; do not install unrelated software.

Trim the display name. Accept 1–48 characters consisting of Unicode letters, digits, spaces, hyphens, and underscores; require the first and last characters to be letters or digits. Reject names that do not meet these rules rather than silently renaming the user's instance. Derive a lowercase ASCII slug by removing combining accents and replacing runs of spaces/underscores with `-`. If the result contains other characters or is empty, ask for a compatible name.

Derive paths from the current Windows user's known folders, not from `CODEX_HOME` (which might belong to the running instance):

| Purpose | Path |
| --- | --- |
| Profile root | `<UserProfile>/.codex-<slug>` |
| Launcher files | `<profileRoot>/launcher` |
| Desktop data | `<ApplicationData>/Codex <displayName>` |
| Electron data | `<desktopRoot>/web/Codex` |
| Start menu application-list shortcut | `<Programs>/Codex <displayName>.lnk` |
| Local shortcut | `<launcherRoot>/Codex <displayName>.lnk` |

Use `[Environment]::GetFolderPath(...)` for `UserProfile`, `ApplicationData`, and `Programs`. Verify that the computed paths stay within their intended parent directories. Check only these exact destinations for collisions; do not enumerate other instances. If any destination already exists, stop and ask for another name. Never overwrite or merge an existing profile, data directory, or shortcut.

For the Start menu destination, also check the real `Programs` folder in Windows File Explorer using the computer-use skill before installation. A shell running under the Codex Store package can see a redirected AppData view: a write to `Programs` may land under `<LocalApplicationData>/Packages/<PackageFamilyName>/LocalCache/Roaming/Microsoft/Windows/Start Menu/Programs`. Even `Test-Path`, directory listings, and shortcut readback from that shell can succeed while Explorer and Start cannot see the shortcut. The known-folder path alone does not prevent this redirection.

## Prepare the icon

The bundled [icons](assets/icons/) contain `purple.ico`, `blue.ico`, and `green.ico`. Copy the matching asset when its color satisfies the request.

For another color, use the available `imagegen` skill and built-in image generation tool with [reference.png](assets/icons/reference.png). Inspect the reference, then recolor it to the requested color while preserving its silhouette, proportions, and transparent background. Do not request an API key for the built-in tool. Inspect the result before using it. Convert the generated PNG to a multi-size ICO with Pillow, preserving alpha and including sizes 16, 24, 32, 48, 64, 128, and 256 pixels. Format conversion is separate from the image edit. If the required generation tool is unavailable, report that blocker and let the user choose a supplied icon or bundled color; never silently substitute a different color.

Keep generated working files in a temporary workspace until ready. The installed icon is always named `codex.ico`.

## Build and install

Prepare and validate all output in a temporary staging directory before creating the final profile. Read the bundled assets, not another instance's files:

- [PowerShell launcher template](assets/codex-elevated-restart.ps1.template): replace every literal `__INSTANCE_NAME__` with the validated display name and save as `codex-elevated-restart.ps1` using UTF-8 **with BOM** for Windows PowerShell 5.1.
- [Tray controller](assets/CodexTray.cs): copy unchanged as `CodexTray.cs`.
- [Hidden script entry point](assets/codex-hidden.vbs): copy unchanged as `codex-hidden.vbs`. It uses Windows Script Host to start PowerShell with its window hidden from creation. Verify that Windows Script Host and VBScript are available; do not compile a custom launcher executable.
- Chosen icon: copy as `codex.ico`.
- [Launcher README template](assets/README.md.template): replace `__INSTANCE_NAME__`, `__PROFILE_ROOT__`, and `__DESKTOP_ROOT__` with their concrete values; save as `README.md` in English.

Use literal string replacement, not interpolation into executable shell text. The name validation excludes quotes and shell syntax. Parse the generated PowerShell through `System.Management.Automation.Language.Parser`; require zero errors and no unresolved template tokens. Compile the C# in a separate Windows PowerShell process with:

```powershell
Add-Type -Path $stagedCsPath -ReferencedAssemblies System.Windows.Forms, System.Drawing, System.Management, System.Core
```

Validate the ICO can be loaded with `System.Drawing.Icon`. Recheck collisions immediately before installing. Create the new profile and launcher directories; copy only the prepared output. Create a minimal `config.toml` containing a comment such as `# Fresh Codex instance; preferences are configured in the app.` The application creates its databases and authentication state on first launch. Do not copy credentials, conversations, settings, plugins, or skills from any other profile.

Create only the local shortcut at `<launcherRoot>/Codex <displayName>.lnk` with `WScript.Shell.CreateShortcut`, using these properties. Install its copy in the real Start menu folder through Explorer in the next section; do not call `CreateShortcut` or `Copy-Item` against `Programs` from the packaged process.

```powershell
$shortcut.TargetPath = Join-Path $env:SystemRoot 'System32\wscript.exe'
$shortcut.Arguments = '//nologo "' + (Join-Path $launcherRoot 'codex-hidden.vbs') + '"'
$shortcut.WorkingDirectory = $launcherRoot
$shortcut.IconLocation = $iconPath + ',0'
$shortcut.WindowStyle = 1
$shortcut.Description = 'Open Codex ' + $displayName
$shortcut.Save()
```

Read back the local shortcut's properties and verify the final files. Track files created during this invocation, including the Start menu copy installed through Explorer. If setup fails, report the partial state; clean up only files proven to have been created by this invocation. Never recursively delete a computed profile path without resolving it and verifying its scope. Do not launch an incomplete installation.

## Install the shortcut in the real Start menu folder

Use the Windows computer-use skill and tools to perform the copy in the user's File Explorer. This makes Explorer perform the filesystem operation rather than a child of the packaged Codex process. Read that skill before UI automation and use its supported APIs; do not use terminal commands in Explorer or the Run dialog.

1. Open the exact `launcherRoot` in Explorer and select the validated **Codex <displayName>** shortcut. Copy it using Explorer's Copy action or Ctrl+C; copy the `.lnk` itself, not its target, and do not use Paste shortcut.
2. Navigate Explorer to the exact `Programs` known-folder path. Recheck that **Codex <displayName>.lnk** is absent in this real folder, then paste with Explorer's Paste action or Ctrl+V. If Windows reports a name collision, cancel the copy without replacing anything and report the blocker.
3. Refresh the destination and visually verify the shortcut name and chosen icon color. Open its Properties in Explorer and verify its location is the real `Programs` folder, its target and arguments point to `wscript.exe` and this instance's `codex-hidden.vbs`, and its working directory and icon match the validated local shortcut. Do not accept a location under `Packages/.../LocalCache` as the Start menu destination.

Only this verification in Explorer establishes that the Start menu shortcut was installed. Launching `explorer.exe /select,...` without observing the result, starting another PowerShell process, or elevating a helper does not establish that package redirection was avoided. Keep the local shortcut in place after copying.

If Explorer automation is unavailable or the copy cannot be verified, report the Start menu installation as pending with the concrete reason. Give the manual copy steps from `launcherRoot` to `Programs`; do not silently fall back to the packaged shell or claim the shortcut is installed. Pinning is attempted only after the real-folder installation is verified.

## Pin the shortcut to Start

Creating the `.lnk` in `Programs` registers the shortcut in the Start application list; it does not establish that the icon appears in **Pinned**. Complete both steps by default unless the user asks to omit pinning.

After validating the installed shortcuts, use the available Windows computer-use skill and tools to find the exact **Codex <displayName>** entry in Start search or All apps. Inspect its context menu and choose **Pin to Start** (localized equivalent, such as **Fixar em Iniciar**). If it already offers **Unpin from Start**, leave it pinned. Select the custom instance shortcut, not the packaged Codex app or `wscript.exe` itself.

Reopen Start and visually verify the instance name and chosen icon color in the Pinned area, checking additional pinned pages or scrolling if needed. Preserve existing pins and their order; do not move the new pin to a particular position unless requested. A `.lnk` existence check, successful launch, or silent shell command is not proof of pinning.

If computer-use tools are unavailable, the entry cannot be identified, or Windows does not offer the pin action, keep the valid installation and report pinning as pending with the observed reason. Give the manual action: search for **Codex <displayName>**, right-click the matching shortcut, and choose **Pin to Start**. Do not replace the user's Start layout through policy/imports, edit Start's internal databases, or introduce a custom executable to force a pin.

Windows documents the user-facing pin action in [Customize the Windows Start Menu](https://support.microsoft.com/en-au/windows/experience/personalization/customize-the-windows-start-menu).

## Preserve the launcher behavior

The bundled launcher derives the profile root from the parent of its own `launcher` directory. It sets `CODEX_HOME`, `CODEX_SQLITE_HOME`, and `CODEX_ELECTRON_USER_DATA_PATH` only in the new app's process environment, with a separate `--user-data-dir`. It requests elevation, runs with `--do-not-de-elevate`, and starts the app within its Windows package identity. UAC consent is handled by Windows. Do not change global environment variables or packaged application files.

Shortcuts, elevation, and package activation use Windows `wscript.exe` with the bundled `codex-hidden.vbs`. Its `WScript.Shell.Run` call supplies window style `0` before PowerShell starts. A hidden console may exist; this does not use a custom executable. Direct PowerShell shortcuts with `-WindowStyle Hidden` alone can still flash a console. If VBScript is unavailable, explain the limitation and offer the direct PowerShell launch with possible flashing; do not introduce a compiled launcher or enable Windows components without user authorization.

The separate C# controller provides one colored tray icon for this profile. Open restores its window; Exit requests normal app shutdown and honors app confirmations. Process identity checks and a mutex prevent attaching to the wrong process or duplicating the controller. The controller ends when that app process exits. Keep the code intact, including these checks.

Do not add Windows login autostart. The icon color applies to the custom shortcuts and tray controller; the packaged app's own icon and native tray behavior are managed by Codex.

## Finish and verify

Start the installed launcher once through its local shortcut unless the user requested configuration only. Use a hidden window for any helper process. Check for the main `ChatGPT.exe` process with the exact new `--user-data-dir`; do not count Electron child processes. Verify the controller remains alive for that process. Do not close or restart any other instance, and do not force-kill the new app as a test. If UAC or login requires user interaction, report the pending step accurately.

Report the instance name, chosen color, profile path, Start menu shortcut, and checks actually performed. Report the real Start menu folder installation and Start pinning separately as verified in Explorer/Start or pending; never infer either from a packaged-shell file check. Mention that the user signs in on first use. Distinguish prepared files from a verified launch; never claim tray interaction was tested if only static checks ran.
