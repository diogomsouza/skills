# Agent Hive Progress Template

Use this file as resumable execution state, not as a ceremonial report. A continuation must be able to read the populated progress file plus the repository and know what to do next without relying on chat history.

Keep the current snapshot concise and the progress log append-only. Record only phase transitions, material decisions, agent results, ownership changes, validation, requested commits, blockers, and final accounting when reliable data exists. Do not copy raw command output or routine narration.

Required sections:

- `Objective`: exact request, scope, non-scope, and success definition.
- `Current State`: current phase, working set, active agent IDs and ownership, assumptions, decisions, and durable plan-changing findings.
- `Execution Plan`: authoritative phase status, owner, dependencies, and combined completion criteria.
- `Progress Log`: durable evidence and decisions at meaningful checkpoints.
- `Next Actions`: at most three concrete actions required to resume.
- `Blockers And Risks`: unresolved blockers and current or accepted risks.

```markdown
# Agent Hive Progress: {context-id}

Goal: {goal-id or objective} - {goal-status}
Task: {task}
Created: {timestamp}
Updated: {timestamp}
Status: `Pending`, `In Progress`, `Blocked`, or `Ready For Final`

## Objective

- Request: `{original user request}`
- In scope: Pending definition.
- Out of scope: Pending definition.
- Done when: Pending success definition.

## Current State

- Current phase: Pending selection.
- Working set: Pending files, modules, systems, data sources, and relevant workspace state.
- Active agents and ownership: `None`, or `{agent-id}: {role}, {owned scope}, {status}`.
- Assumptions: Pending review, or `None`.
- Decisions and durable findings: Pending review, or `None`.

## Execution Plan

| Phase | Status | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- |
| 1. Define executable phases | Pending | Agent Hive | Objective | Plan is specific enough to resume without chat context. |

Statuses: `Pending`, `In Progress`, `Done`, `Accepted`, `Blocked`, `Not Applicable`.
Use `Done` when execution is complete but its acceptance gate is pending. Use `Accepted` only when the `Done When` criteria and required coordinator or independent-verifier acceptance gate have passed. After failed acceptance, return the phase to `Pending` or `In Progress` and record the reason in `Progress Log`.

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialization | Progress file created and initial state captured. |

## Next Actions

1. `{owner}`: {next action}; depends on {dependency}; complete when {stop condition}.

Keep only the next one to three real actions. Use `None` when no action remains.

## Blockers And Risks

- Blockers: `None`, or `{blocker and required resolution}`.
- Risks: `None`, or `{current, accepted, or residual risk}`.
```
