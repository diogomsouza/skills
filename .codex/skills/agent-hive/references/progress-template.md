# Agent Hive Progress Template

Use this file as resumable execution state, not as a ceremonial report. A continuation must be able to read the populated progress file plus the repository and know what to do next without relying on chat history.

Keep the current snapshot concise and the progress log append-only. Record only phase transitions, material decisions, agent selections, assignment-bound spawns, replacements, handbacks and closures, agent results, ownership changes, validation, requested commits, blockers, and final accounting when reliable data exists. Do not copy raw command output, routine narration, or complete subagent reports. Completeness means enough durable state and evidence to resume safely, not an exhaustive transcript.

The populated file must preserve the template structure exactly: one document `#` heading followed by exactly these seven `##` sections, once each and in this order. Do not add other headings at any level. Use bullets and table rows inside the required sections; never create per-item or per-event headings such as `Historical Item Scope`, `Accepted Item Record`, `Current Follow-Up Scope`, `Committed Follow-Up Record`, exploration, retry, runtime, agent-inventory, or agent-report sections.

Required sections:

- `Objective`: exact request, scope, non-scope, and success definition.
- `Current State`: current phase, working set, active assignment-to-agent bindings and ownership, assumptions, decisions, and durable plan-changing findings.
- `Agent Selection`: one current row per material delegated assignment with only relevant candidates, the selected role, decision status, and concise rationale.
- `Execution Plan`: short phase ID, descriptive scope, authoritative status, owner, dependencies, and combined completion criteria.
- `Progress Log`: durable evidence and decisions at meaningful checkpoints.
- `Next Actions`: at most three concrete actions required to resume.
- `Blockers And Risks`: unresolved blockers and current or accepted risks.

Route current facts and active ownership to `Current State`, current role-selection decisions to `Agent Selection`, phase status and scope to `Execution Plan`, and each material historical result or superseded selection to one concise `Progress Log` row. Put immediate work in `Next Actions` and unresolved or accepted risks in `Blockers And Risks`. Reference commits, files, and evidence artifacts instead of duplicating their full contents.

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
- Active agents and ownership: `None`, or `{assignment-id} -> {agent-id}: {role}, {owned scope}, {status}`. Bind each agent ID to exactly one assignment for its lifetime.
- Assumptions: Pending review, or `None`.
- Decisions and durable findings: Pending review, or `None`.

## Agent Selection

- Discovery snapshot: `{timestamp}`, `Pending`, or `Not Applicable`; status: `Current`, `Refresh Required`, `Pending`, or `Not Applicable`.
- Refresh trigger: `None`, or `{material scope/runtime/role-metadata change}`.

| Assignment | Task Type | Eligible Roles | Selected Role | Decision Status | Rationale |
| --- | --- | --- | --- | --- | --- |
| Not Applicable | Not Applicable | None | Not Applicable | Not Applicable | No material delegated assignment is currently planned. |

Keep exactly one current row per material delegated assignment and tie its durable assignment identifier to an `Execution Plan` phase, for example `P2/exploration`, `P2/implementation`, or `P2/verification`. Keep checkpoints and directed retries for the same deliverable in that row. Create a new identifier and row when the task type, primary deliverable, material ownership scope, or acceptance boundary changes; never repurpose an identifier. Use only `Exploration`, `Implementation`, `Verification`, or `Not Applicable` for `Task Type`, and only `Pending`, `Selected`, `Refresh Required`, or `Not Applicable` for `Decision Status`. For `Selected`, list at least one eligible role and set `Selected Role` to exactly one of them. For `Pending` or `Refresh Required`, set both role fields to `Pending`. Use the placeholder `Not Applicable` row only when no material delegation is planned. Replace it as soon as delegation is planned.

List only visible roles that could realistically perform the assignment and limit `Rationale` to one sentence explaining material fit. Do not add rows for coordinator-local work. Do not record agent IDs, active status, ownership, tool inventories, raw role descriptions, outputs, reasoning, unrelated roles, or prior choices here. Replace changed decisions in place and record the superseded choice in `Progress Log`. Refresh unresolved rows only after a material scope change, a different or uncertain runtime, or changed visible role metadata; preserve selections tied only to `Accepted` work. Beyond the two fixed metadata bullets, the selection table, and these fixed rules, add no other bullets, tables, notes, or narrative to this section.

## Execution Plan

| Phase | Status | Scope | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- |
| P1 | Pending | Define executable phases | Agent Hive | Objective | Plan is specific enough to resume without chat context. |

Keep `Phase` as a short stable identifier such as `P1`, `M-04`, or `F2`. Keep `Status` immediately after it, and put the descriptive title only in `Scope`, so status values remain visually aligned and easy to scan.

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
