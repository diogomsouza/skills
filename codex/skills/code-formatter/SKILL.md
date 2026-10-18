---
name: code-formatter
description: Formats C# and C++ with the bundled executable when the user explicitly requests code-formatter, by name or as $code-formatter.
---

Use this skill's `scripts/code-formatter.exe`. For "format this project", use the current project's absolute root directory: the executable discovers C# and C++ together. For an explicit file, project, solution, or directory, use that absolute target.

Run once in the foreground: `code-formatter.exe format "<target>" --silent`. Never run `check`.

Await tool calls and expose their results (`text(await tools.exec_command(...))` inside `functions.exec`). If `functions.exec` returns a running cell ID, use `functions.wait`; if the command returns a `session_id`, poll `write_stdin`. Follow both layers until the command's explicit `exit_code` is available. Silence, the startup message, or completion of the wrapper alone is not completion of the command. Do not rerun a pending command.

Return only the captured final summary or error and exit code. Never claim completion without observing the command's exit. If its status cannot be recovered, report completion as unconfirmed.
