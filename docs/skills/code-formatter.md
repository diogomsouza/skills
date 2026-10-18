# Code Formatter

**Apply the bundled C# and C++ formatter to an explicit target.**

Code Formatter provides a focused workflow for running the repository's formatting executable. You identify the code to format; the skill resolves the target, runs the tool once, and reports its actual result.

The skill is deliberately narrow. It does not choose an alternative formatter, invent formatting rules, or treat the absence of console output as proof that formatting finished. The executable owns formatting behavior, while the skill owns invocation and completion tracking.

## Choose the target

Use this skill when you explicitly want `code-formatter`, either by name or as `$code-formatter`. Its [metadata](../../codex/skills/code-formatter/agents/openai.yaml) disables implicit invocation.

| Request | Target passed to the executable |
| --- | --- |
| Format this project | The current project's absolute root directory |
| Format a particular directory | That directory's absolute path |
| Format a file, project, or solution | The explicitly identified target's absolute path |

For a project root, the executable discovers C# and C++ together. You do not need separate requests for the two languages. The skill definition does not enumerate every transformation the executable performs, so the resulting diff remains the concrete record of what changed.

## From request to result

The workflow uses [scripts/code-formatter.exe](../../codex/skills/code-formatter/scripts/code-formatter.exe) from the skill directory:

```text
code-formatter.exe format "<target>" --silent
```

The command runs once in the foreground. The skill waits for the command's explicit exit code, following any running tool or process session until it completes. A startup message, a silent interval, or completion of an outer tool wrapper is insufficient evidence.

A pending command is not started again. This matters when a large project takes time to process: a second invocation could overlap the first while the original result remains unknown. The workflow never uses the executable's `check` command.

## What you receive

The response contains the captured final summary or error and the exit code. It does not replace the executable's output with an unsupported claim that every file was formatted successfully.

If the process status cannot be recovered, completion is reported as unconfirmed. The bundled Windows executable must be runnable in the current environment; this repository does not define a fallback implementation for other environments.

## Example requests

For the active project:

```text
Use $code-formatter to format this project.
```

For a narrower change:

```text
Use $code-formatter on D:\Projects\Sample\src\Services.
```

These examples invoke formatting. For investigation of dead code, responsibilities, or maintainability, use [Code Quality Review](code-quality-review.md). For a substantive correctness review of a change, use the [Reviewer](../agents/reviewer.md) role.

## Source and related guides

- [Skill definition](../../codex/skills/code-formatter/SKILL.md) — invocation, process tracking, and response rules.
- [Bundled executable](../../codex/skills/code-formatter/scripts/code-formatter.exe) — the formatter used by the workflow.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->