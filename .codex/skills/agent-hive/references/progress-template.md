# Agent Hive Progress Template

Use this file as resumable execution state, not as a ceremonial report. A continuation should be able to read this progress file plus the repository and know what to do next without relying on chat history.

Required sections:

- `Source Request And Scope`: original request, scope, non-scope, and success definition.
- `Current State`: durable snapshot of assumptions, tools, agents, decisions, and active status.
- `Execution Plan`: authoritative phase list, status, owners, dependencies, acceptance criteria, validation, and verifier.
- `Findings`: only plan-changing exploration or verifier findings; use `Not Applicable` when none exist.
- `Progress`: append-only evidence log for completed work, commands, validation, commits, final accounting, and decisions.
- `Next Actions`: concrete pending actions, not a fixed generic queue.
- `Blockers And Risks`: unresolved blockers, accepted risks, and residual risks.

When copying the template, replace `{progress-file-path}` with the actual file path. Record checkpoint commit attempts, runtime notes, and final accounting in `Progress` only when relevant. Keep `Next Actions` limited to real pending work; remove generic placeholders after startup.

```markdown
# Agent Plan Progress: {context-id}

Task: {task}
Generated: {timestamp}

## Source Request And Scope

- User request:
  - `{original user request}`
- Prior user-approved plan or requested plan:
  - Pending capture, no prior detailed plan, or `{plan item}`.
- In scope:
  - Pending scope confirmation.
- Out of scope:
  - Pending scope confirmation.
- Success definition:
  - Pending success definition.

## Current State

- Status:
  - `Pending`, `In Progress`, `Blocked`, or `Ready For Final`.
- Systems and files:
  - Pending inventory.
- Available agents/tools:
  - Pending discovery.
- Delegation plan:
  - Pending batching plan, or `Not Applicable`.
- Assumptions:
  - Pending assumption review.
- Decisions:
  - Pending decisions.
- Progress file:
  - `{progress-file-path}`

## Execution Plan

| Phase | Status | Scope | Owner | Dependencies | Acceptance Criteria | Validation | Verifier | Stop Condition |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Pending | Define concrete phases | Agent Hive | Source request | Plan is specific enough to resume without chat context | Progress file review | Agent Hive | `Execution Plan` and `Next Actions` are actionable. |

Statuses: `Pending`, `In Progress`, `Done`, `Accepted`, `Rejected`, `Retry Required`, `Blocked`, `Not Applicable`.
Use `Done` when work is complete but no required verifier/acceptance gate has passed. Use `Accepted` only after the required verifier or coordinator acceptance gate has passed and the evidence is recorded in `Progress`.

## Findings

| Time | Source | Scope | Finding | Plan Impact |
| --- | --- | --- | --- | --- |
| Pending | TBD | TBD | Pending exploration, verification, or `Not Applicable`. | Pending. |

## Progress

| Time | Phase/Area | Agent/Tool | Evidence | Result |
| --- | --- | --- | --- | --- |
| {timestamp} | Initialization | Agent Hive | Progress file created. | Initial state captured. |

## Next Actions

| Status | Action | Owner | Depends On | Stop Condition |
| --- | --- | --- | --- | --- |
| Pending | Define the next concrete action. | Agent Hive | Current state | Action is clear enough to execute or delegate. |

## Blockers And Risks

- Blockers:
  - Pending blocker review, or `None`.
- Risks:
  - Pending risk review, or `None`.
- Residual risks:
  - Pending final review, or `None`.
```
