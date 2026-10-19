---
name: code-formatter
description: Formats C# and C++ with the bundled executable when the user invokes /code-formatter.
disable-model-invocation: true
---

Use this skill's `scripts/code-formatter.exe`. For "format this project", use the current project's absolute root directory: the executable discovers C# and C++ together. For an explicit file, project, solution, or directory, use that absolute target.

Run once in the foreground: `code-formatter.exe format "<target>" --silent`. Never run `check`.

Run it in a single shell tool call with `timeout: 600000` and wait for that call to return the command's exit code. Do not rerun a pending or timed-out command.

Return only the captured final summary or error and exit code. Never claim completion without observing the command's exit. If its status cannot be recovered, report completion as unconfirmed.
