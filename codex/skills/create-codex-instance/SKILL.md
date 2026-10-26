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

For the Start menu destination, run the bundled [shortcut helper](scripts/install-shortcuts.ps1) with `-CheckOnly` before installation, as described below. A shell running under the Codex Store package can see a redirected AppData view: a write to `Programs` may land under `<LocalApplicationData>/Packages/<PackageFamilyName>/LocalCache/Roaming/Microsoft/Windows/Start Menu/Programs`. Even `Test-Path`, directory listings, and shortcut readback from that shell can succeed while Explorer and Start cannot see the shortcut. The known-folder path alone does not prevent this redirection.

## Prepare the icon

The bundled [icons](assets/icons/) contain `purple.ico`, `blue.ico`, and `green.ico`. Copy the matching asset when its color satisfies the request.

For another color, use the available `imagegen` skill and built-in image generation tool with [reference.png](assets/icons/reference.png). Inspect the reference, then recolor it to the requested color while preserving its silhouette, proportions, and transparent background. Do not request an API key for the built-in tool. Inspect the result before using it. Convert the generated PNG to a multi-size ICO with Pillow, preserving alpha and including sizes 16, 24, 32, 48, 64, 128, and 256 pixels. Format conversion is separate from the image edit. If the required generation tool is unavailable, report that blocker and let the user choose a supplied icon or bundled color; never silently substitute a different color.

Keep generated working files in a temporary workspace until ready. The installed icon is always named `codex.ico`.

## Build and install

Prepare and validate all output in a temporary staging directory before creating the final profile. Read the bundled assets, not another instance's files:

- [PowerShell launcher template](assets/codex-elevated-restart.ps1.template): replace every literal `__INSTANCE_NAME__` with the validated display name and save as `codex-elevated-restart.ps1` using UTF-8 **with BOM** for Windows PowerShell 5.1.
- [Tray controller](assets/CodexTray.cs): copy unchanged as `CodexTray.cs`.
- Chosen icon: copy as `codex.ico`.
- [Launcher README template](assets/README.md.template): replace `__INSTANCE_NAME__`, `__PROFILE_ROOT__`, and `__DESKTOP_ROOT__` with their concrete values; save as `README.md` in English.

Use literal string replacement, not interpolation into executable shell text. The name validation excludes quotes and shell syntax. Parse the generated PowerShell through `System.Management.Automation.Language.Parser`; require zero errors and no unresolved template tokens. Compile the C# in a separate Windows PowerShell process with:

```powershell
Add-Type -Path $stagedCsPath -ReferencedAssemblies System.Windows.Forms, System.Drawing, System.Management, System.Core
```

Validate the ICO can be loaded with `System.Drawing.Icon`. Recheck collisions immediately before installing. Create the new profile and launcher directories; copy only the prepared output. Create a minimal `config.toml` containing a comment such as `# Fresh Codex instance; preferences are configured in the app.` The application creates its databases and authentication state on first launch. Do not copy credentials, conversations, settings, plugins, or skills from any other profile.

## Create and verify shortcuts outside the package

Use the bundled [shortcut helper](scripts/install-shortcuts.ps1) for both the local and Start menu shortcuts. Do not use computer use, Explorer, or direct writes to `Programs` from the packaged shell for this step.

Before creating the profile, check for shortcut collisions:

```powershell
$check = & $shortcutHelperPath -DisplayName $displayName -LauncherRoot $launcherRoot -CheckOnly
```

Set `shortcutHelperPath` to this skill's absolute `scripts/install-shortcuts.ps1` path. After installing and validating the launcher files and icon, run the helper again without `-CheckOnly`:

```powershell
$installed = & $shortcutHelperPath -DisplayName $displayName -LauncherRoot $launcherRoot
```

The helper stages its worker and JSON exchange files in a unique temporary directory directly under the current user's profile, outside virtualized AppData. It starts hidden Windows PowerShell 5.1 through local WMI/CIM `Win32_Process.Create`. The worker requires `GetCurrentPackageFullName` to return `APPMODEL_ERROR_NO_PACKAGE` and checks that its Windows user SID matches the caller before resolving the `Programs` known folder. Starting another PowerShell or elevating a process without these checks does not establish that redirection was avoided.

In check mode, the worker rejects an existing local or Start menu shortcut without creating either. In install mode, it rechecks collisions, creates a staged `.lnk` with `WScript.Shell.CreateShortcut`, then copies it to both final destinations without overwrite. Both shortcuts target Windows PowerShell's `powershell.exe` with `-NoProfile -NonInteractive -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File` and the quoted `codex-elevated-restart.ps1` path. Their working directory is `launcherRoot`, icon is `codex.ico`, and window style is minimized (`7`). No VBS file or custom launcher executable is used.

The same unpackaged worker reads back both installed shortcuts and verifies their target, arguments, working directory, icon location, window style, and description. Require `Success`, `NoPackageIdentity`, and `SameUser` to be true; an installation also requires `Verified` to be true. Use the returned `ProgramsPath`, `LocalShortcut`, `StartMenuShortcut`, and `CreatedPaths` as the installation evidence. A packaged-shell `Test-Path` is not a substitute for the helper's result. This verifies the files and launch configuration; appearance in Start and pinning are separate checks.

If WMI/CIM, the identity checks, creation, or readback fail, report the concrete error and partial state. The helper's error includes any final shortcuts it created; do not remove pre-existing destinations. A 30-second timeout leaves the exchange directory and reports the worker PID: completion is unknown, so inspect that worker and its result before retrying or cleaning up. Do not launch an incomplete installation or silently fall back to computer use. If cleanup is needed, remove only paths proven to have been created by this invocation, accessing `Programs` from a verified unpackaged process. Never recursively delete a computed profile path without resolving it and verifying its scope.

## Pin the shortcut to Start

Creating the `.lnk` in `Programs` registers the shortcut in the Start application list; it does not establish that the icon appears in **Pinned**. Complete both steps by default unless the user asks to omit pinning.

After validating the installed shortcuts, use the available Windows computer-use skill and tools to find the exact **Codex <displayName>** entry in Start search or All apps. Inspect its context menu and choose **Pin to Start** (localized equivalent, such as **Fixar em Iniciar**). If it already offers **Unpin from Start**, leave it pinned. Select the custom instance shortcut, not the packaged Codex app or `powershell.exe` itself.

Reopen Start and visually verify the instance name and chosen icon color in the Pinned area, checking additional pinned pages or scrolling if needed. Preserve existing pins and their order; do not move the new pin to a particular position unless requested. A `.lnk` existence check, successful launch, or silent shell command is not proof of pinning.

If computer-use tools are unavailable, the entry cannot be identified, or Windows does not offer the pin action, keep the valid installation and report pinning as pending with the observed reason. Give the manual action: search for **Codex <displayName>**, right-click the matching shortcut, and choose **Pin to Start**. Do not replace the user's Start layout through policy/imports, edit Start's internal databases, or introduce a custom executable to force a pin.

Windows documents the user-facing pin action in [Customize the Windows Start Menu](https://support.microsoft.com/en-au/windows/experience/personalization/customize-the-windows-start-menu).

## Preserve the launcher behavior

The bundled launcher derives the profile root from the parent of its own `launcher` directory. It sets `CODEX_HOME`, `CODEX_SQLITE_HOME`, and `CODEX_ELECTRON_USER_DATA_PATH` only in the new app's process environment, with a separate `--user-data-dir`. It requests elevation, runs with `--do-not-de-elevate`, and starts the app within its Windows package identity. UAC consent is handled by Windows. Do not change global environment variables or packaged application files.

Shortcuts and elevation run `codex-elevated-restart.ps1` directly with Windows PowerShell 5.1, using `-NoProfile -NonInteractive -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File` and a quoted script path. Package activation runs the same PowerShell executable with `-EncodedCommand` for the prepared app-launch command; the independent tray controller runs the script with `-TrayOnly`. Do not create or use a VBScript wrapper or compile a custom launcher executable. The console is requested hidden, but a brief console flash can still occur with direct PowerShell launching.

The separate C# controller provides one colored tray icon for this profile. Open restores its window; Exit requests normal app shutdown and honors app confirmations. Process identity checks and a mutex prevent attaching to the wrong process or duplicating the controller. The controller ends when that app process exits. Keep the code intact, including these checks.

Do not add Windows login autostart. The icon color applies to the custom shortcuts and tray controller; the packaged app's own icon and native tray behavior are managed by Codex.

## Finish and verify

Start the installed launcher once through its local shortcut unless the user requested configuration only. Use a hidden window for any helper process. Check for the main `ChatGPT.exe` process with the exact new `--user-data-dir`; do not count Electron child processes. Verify the controller remains alive for that process. Do not close or restart any other instance, and do not force-kill the new app as a test. If UAC or login requires user interaction, report the pending step accurately.

Report the instance name, chosen color, profile path, Start menu shortcut, and checks actually performed. Report shortcut installation as verified by the unpackaged helper or pending, and Start pinning separately as visually verified in Start or pending; never infer either from a packaged-shell file check. Mention that the user signs in on first use. Distinguish prepared files from a verified launch; never claim tray interaction was tested if only static checks ran.
