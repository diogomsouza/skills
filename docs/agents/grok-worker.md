# Grok Worker

**Coordinate a bounded implementation by Grok through the official Cursor CLI.**

Grok Worker is a Codex agent that hands implementation to an external Cursor executor, follows its observable progress, and checks the resulting work. It is not a native Grok session inside Codex.

The repository configuration selects `gpt-5.6-luna` with medium reasoning for coordination. It requires Grok 4.7 with High reasoning and Fast disabled for implementation. These are the role's configured choices, not a promise that every local account or installation provides those models.

## Understand the execution components

| Component | Responsibility |
| --- | --- |
| Codex coordinator | Establish scope, pass the assignment, follow the session, inspect results, and report evidence |
| Cursor ACP executor | Connect to the official Cursor CLI and transport the task and tool interactions |
| Grok implementation session | Inspect the assigned workspace, make authorized changes, and perform required validation |

The coordinator must not silently implement the task itself and attribute that work to Grok. It must also not substitute another model, enable Fast, switch to API keys, or alter billing endpoints to make a blocked launch proceed.

Coordination consumes Codex usage; Grok execution follows the authenticated Cursor account's usage rules. The configuration does not establish available allowance or guarantee no extra charges.

## Prepare the runtime and assignment

The role requires Python 3, the official Cursor CLI, a valid Cursor login, and the executor at:

```text
<active Codex configuration directory>/tools/cursor-acp/cursor_acp_executor.py
```

The active directory is resolved from `CODEX_HOME` when set, otherwise the user's `~/.codex` directory. The executor is an external prerequisite and is not included in this repository.

The executor uses the CLI's existing login. A missing or expired login is reported with a request to run `agent login` on that machine; credentials are not extracted or replaced with API keys.

A useful assignment states the exact workspace, objective, owned files, constraints, repository guidance, and required validation. Grok is told that it shares the workspace and must preserve concurrent changes. The full assignment is passed explicitly rather than inferred from unrelated session history.

## Launch within the authorized scope

The configuration defines a fixed transport. On Windows, it uses non-interactive PowerShell with the full prompt serialized as JSON and sent through standard input to the executor. Other platforms use a programmatic subprocess with UTF-8 input.

The normal implementation mode is `agent`. Authorized implementation passes `--approve-tools` to allow individual tool requests for that run without installing a persistent allow-all setting. This does not expand the task's authority or provide a sandbox.

The executor trusts the explicitly selected workspace. If the caller prohibits that trust, execution must not begin. Transport details, required arguments, and quoting rules remain in the [agent configuration](../../codex/agents/grok-worker.toml) so that a manually improvised launcher does not replace the defined protocol.

## Follow useful progress

The executor streams session identity, public text, tool events, permissions, activity, and terminal results. The coordinator keeps the Cursor session ID separate from the host shell process or session ID.

Progress reports distinguish inspection from editing, planned changes from saved changes, and a started test from a passing test. A recent protocol signal proves responsiveness, not useful task progress. The latest tool phase also does not describe the entire implementation state.

There is no implicit wall-clock cutoff for the prompt. A positive timeout is used only for an explicitly supplied runtime budget. Relevant completed searches and reads count as active exploration even before a patch exists.

Repeated unproductive operations, errors, or prolonged loss of signals require concrete investigation and coordination. Silence, elapsed time, or the absence of an edit alone does not justify declaring a hang or starting a second writer.

## Resume or recover deliberately

A known session can be resumed for the same task and workspace. The coordinator must not guess a session ID, resume unrelated work, or start a competing writer.

After failure or interruption, it checks possible partial edits before retrying. The executor normally cancels work and terminates its process tree on error, timeout, or interruption; a hard kill of the host may prevent cleanup, so the old process must be accounted for before another run.

| Executor result | What it establishes |
| --- | --- |
| Exit 0 with `result.success=true` | The turn completed; diffs and required validation still need inspection |
| Exit 2 | Caller input is needed, such as a decision, question response, or unapproved tool |
| Exit 1 | An error or incomplete run occurred |
| Exit 130 | The run was interrupted |

An uncertain partial effect remains visible. The coordinator does not turn an executor success flag into a claim that every requested behavior is correct.

## Example assignment and handoff

```text
Use grok-worker to implement the approved CSV export change in this workspace.
Limit ownership to the export service and its existing integration points.
Preserve concurrent edits, follow the repository instructions, and run the
specified validation. Report the Cursor session and any unfinished obligations.
```

This role is intended for implementation assignments, rather than standalone analysis or review. Its handoff identifies the model, Cursor session ID, changed paths, checks actually performed, and limitations. Implementation is explicitly attributed to Grok.

## Source and related guides

- [Agent configuration](../../codex/agents/grok-worker.toml) — runtime dependencies, transport, progress, resumption, and result handling.
- [Reviewer](reviewer.md) — independent assessment of the resulting implementation.
- [Code Craft](../skills/code-craft.md) — coordination of bounded implementation assignments.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
