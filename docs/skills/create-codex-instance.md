# Create Codex Instance

**Create a separate Windows Codex profile with its own launcher, shortcuts, and colored tray icon.**

Create Codex Instance prepares a fresh desktop profile using the installed Codex application and assets bundled with the skill. It is useful when you want a distinct workspace of settings and app data, with a recognizable name and icon.

The workflow creates a separate profile and desktop data directories. It does not create a new chat or Git worktree. It also does not copy credentials, conversations, settings, plugins, or skills from another profile. You sign in and configure preferences when the new instance first opens.

## Start with a name and color

The skill collects two choices, one at a time: the instance name and the icon color. Choices already supplied in the request are reused.

Names accept 1–48 characters consisting of Unicode letters, digits, spaces, hyphens, and underscores, with a letter or digit at each end. A lowercase ASCII slug is derived for the profile path. Invalid or incompatible names require a correction instead of silent renaming.

Purple, blue, and green icons are bundled. For another color, the workflow uses the available image-generation tool with the supplied reference image and converts the result to a multi-size ICO. If generation is unavailable, it reports the limitation so you can select an available icon.

The color applies to the custom shortcuts and tray controller. The packaged application's native tray and taskbar icons remain controlled by Codex.

## Check the Windows prerequisites

The defined workflow uses Windows PowerShell 5.1, the installed `OpenAI.Codex` Store package, and `Invoke-CommandInDesktopPackage`. It inspects the installed package and manifest rather than storing a fixed package-version path.

The hidden entry point also requires Windows Script Host and VBScript. If VBScript is unavailable, the skill explains the limitation and offers a direct PowerShell launcher with possible console flashing. Enabling Windows components or introducing a different launcher is not an automatic fallback.

The launcher requests elevation. Windows still handles UAC consent, and separate data directories are not a Windows security boundary: the processes use the same Windows account.

## What gets created

Paths are derived from the current Windows user's known folders, independently of an existing instance's `CODEX_HOME`.

| Location | Purpose |
| --- | --- |
| `<UserProfile>/.codex-<slug>` | Fresh Codex profile and minimal configuration |
| `<profileRoot>/launcher` | Launcher scripts, tray-controller source, icon, local shortcut, and README |
| `<ApplicationData>/Codex <displayName>` | Separate desktop data |
| `<desktopRoot>/web/Codex` | Electron browser data |
| `<Programs>/Codex <displayName>.lnk` | Start menu shortcut |

The skill checks these exact destinations for collisions. An existing profile, data directory, or shortcut is not overwritten or merged; the user selects a different name.

The [launcher assets](../../codex/skills/create-codex-instance/assets/) include a PowerShell template, hidden VBScript entry point, C# tray controller, README template, and icons. Preparation happens in a staging directory before the final profile is created.

## From preparation to first launch

1. **Prepare the assets.** Substitute the validated name and paths in the templates, retain the supplied controller behavior, and prepare the selected icon.
2. **Validate before installing.** Parse the PowerShell, check unresolved template tokens, compile the C# source for validation, and confirm the ICO can be loaded.
3. **Install the prepared files.** Recheck collisions, create the profile and launcher directory, and write a minimal configuration.
4. **Create and inspect shortcuts.** Both shortcuts use the hidden script entry point and the custom icon.
5. **Launch and verify.** Unless configuration only was requested, start the local shortcut and check the main app process with the exact new browser-data path and its tray controller.

If setup fails, the handoff identifies partial state. Cleanup is limited to files established to have been created by that invocation. An incomplete installation is not launched.

## Use the instance

The launcher configures profile and desktop environment variables only for the child app, preserves Windows package identity, and keeps the profile's tray controller associated with the matching process. It does not change global environment variables or packaged app files.

The custom tray provides **Open** to restore the window and **Exit** to request normal shutdown while honoring application confirmations. Process checks and a mutex prevent the controller from attaching to the wrong instance or duplicating itself. It exits when its associated app process exits.

No Windows login autostart is added. Keep the launcher directory directly inside the profile root, because the launcher derives its profile location from that relationship.

## Example requests and expected handoff

```text
Use $create-codex-instance to create an instance named Research with a blue icon.
```

```text
Use $create-codex-instance to prepare a purple instance named Experiments.
Configure it only; do not launch it yet.
```

The result identifies the name, color, profile path, Start menu shortcut, and checks performed. Prepared files and a verified launch are reported separately. Pending UAC or login interaction remains explicit, and static inspection is not described as a completed test of tray interaction.

## Source and related guides

- [Skill definition](../../codex/skills/create-codex-instance/SKILL.md) — naming, prerequisites, installation, launch, and verification rules.
- [Bundled assets](../../codex/skills/create-codex-instance/assets/) — implementation templates and icons.
- [Generated README template](../../codex/skills/create-codex-instance/assets/README.md.template) — launch behavior and troubleshooting supplied with each instance.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->