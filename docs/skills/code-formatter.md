# code-formatter

Code Formatter formats C# and C++ using the executable bundled with the skill. It activates when the user explicitly requests `code-formatter` by name or as `$code-formatter`.

It accepts an absolute file, project, solution, or directory path. For a request to format the current project, it uses the project's absolute root directory and lets the executable discover both languages.

The workflow runs `code-formatter.exe format "<target>" --silent` once in the foreground and follows the process until an explicit exit code is available. It does not run the executable's `check` command or restart a command that is still pending.

Its response contains only the captured final summary or error and the exit code. If the process status cannot be recovered, completion is reported as unconfirmed. The bundled Windows executable must be runnable in the target environment.

- [Source definition](../../codex/skills/code-formatter/SKILL.md)
- [Bundled executable](../../codex/skills/code-formatter/scripts/code-formatter.exe)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
