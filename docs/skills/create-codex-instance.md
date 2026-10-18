# create-codex-instance

Create Codex Instance creates a fresh, separate Codex desktop profile on Windows. It collects an instance name and icon color, then prepares an isolated profile, an elevated launcher, a dedicated tray controller, and local and Start menu shortcuts.

The workflow uses its bundled assets and the installed `OpenAI.Codex` Store package. It requires Windows PowerShell 5.1 and package activation support. The hidden launcher uses Windows Script Host and VBScript; if those are unavailable, the skill explains the limitation and offers a direct PowerShell launch with possible console flashing.

Bundled icons cover purple, blue, and green. Other colors use image generation when available. The custom color applies to the shortcuts and tray controller. The profile starts without copying another instance's credentials, conversations, settings, plugins, or skills, and the user signs in on first use.

The skill checks destination collisions, validates staged files, installs them, and launches the instance unless configuration only was requested. Its handoff reports the chosen name and color, paths, checks performed, and any pending UAC or login interaction.

- [Source definition](../../codex/skills/create-codex-instance/SKILL.md)
- [Bundled assets](../../codex/skills/create-codex-instance/assets/)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
