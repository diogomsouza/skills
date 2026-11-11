---
name: code-formatter
description: Formats C#, C++, TypeScript/Angular, HTML and CSS/SCSS with the bundled executable when explicitly requested as code-formatter or $code-formatter.
---

Use this skill's `scripts/code-formatter.exe`. For general requests such as "format this project" or "format this solution", use the absolute root directory of the
project indicated by the user, otherwise the current workspace root. A root directory includes C#, C++ and TypeScript/Angular together. Do not infer a `.sln` or `.slnx`
target from the word "solution". Use a specific file only when the user explicitly names it or provides its path; explicit `.sln`, `.slnx` and `.csproj` targets cover C#
only. Respect requested scope and project exclusions.

Angular formatting (TypeScript, templates and styles) uses bundled Prettier and Node.js. The executable handles supported project configuration and ignore files; do not
install packages, invoke Prettier separately, or create configuration files.

Run once in the foreground: `code-formatter.exe format "<target>" --silent`. Never run `check`.

Await tool calls and expose their results (`text(await tools.exec_command(...))` inside `functions.exec`). If `functions.exec` returns a running cell ID, use
`functions.wait`; if the command returns a `session_id`, poll `write_stdin`. Follow both layers until the command's explicit `exit_code` is available. Silence, the
startup message, or completion of the wrapper alone is not completion of the command. Do not rerun a pending command.

Return only the captured final summary or error and exit code. Never claim completion without observing the command's exit. If its status cannot be recovered, report
completion as unconfirmed.
