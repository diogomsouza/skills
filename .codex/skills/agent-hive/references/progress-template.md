# Agent Hive Progress Template

Use this file as resumable execution state, not as a ceremonial report. A continuation must be able to read the populated progress file plus the repository and know what to do next without relying on chat history.

Keep the current snapshot concise and the progress log append-only. Record only phase transitions, material decisions, capability or agent-selection refreshes, implementation-readiness decisions, assignment-bound spawns, exact returned runtime identities, requested and authoritative effective metadata, replacements, handoff gates, closures or terminal retirements, capacity dispositions, agent results, ownership changes, verification, validation, retry or circuit-breaker decisions, strategy changes, phase reopenings, requested commits, blockers, and reliable quality or final accounting. Do not copy raw command output, estimate unavailable metrics, preserve routine narration, or paste complete subagent reports. Completeness means enough durable state and evidence to resume safely, not an exhaustive transcript.

The populated file must preserve the template structure exactly: one document `#` heading followed by exactly these seven `##` sections, once each and in this order. Do not add other headings at any level. Use bullets and table rows inside the required sections; never create per-item or per-event headings such as `Historical Item Scope`, `Accepted Item Record`, `Current Follow-Up Scope`, `Committed Follow-Up Record`, exploration, retry, runtime, agent-inventory, or agent-report sections.

Required sections:

- `Objective`: only the stable request, scope, non-scope, and success definition.
- `Current State`: only the bounded present-tense snapshot: current phase, authoritative working set, topology, candidate-bearing product or deliverable integration-state identity and separately classified live operational coordination inventory when repository-backed, compact runtime capability or external state, active durable-assignment-to-runtime-instance bindings with exact returned identities and ownership, assumptions and constraints, and at most five plan-changing durable findings.
- `Agent Selection`: one current row per non-terminal material delegated assignment still required by an unaccepted phase, including each complementary verification assignment, with only relevant candidates, the selected role, decision status, and concise rationale; append newly introduced assignments at the bottom in first-spawn order and never reorder existing rows.
- `Execution Plan`: only one authoritative row per phase with `ID`, `Status`, `Work Item`, `Owner`, `Depends On`, and `Done When`, in exactly that order.
- `Progress Log`: only concise append-only material events, superseded decisions, readiness and handoff gates, exact returned identities, requested and authoritative effective metadata, evidence references, closures or terminal retirements, capacity disposition, verification and validation, first-pass verdicts, blocker and correction counts, reliable timing, circuit-breaker and strategy decisions, phase reopenings, requested commits, blockers resolved, and final accounting.
- `Next Actions`: only the next one to three concrete actions required to advance or resume.
- `Blockers And Risks`: only unresolved blockers and current accepted or residual risks.

Apply a single-home rule: store each fact in exactly one authoritative section and use only a phase, assignment, commit, or evidence reference elsewhere. Route current facts and active ownership to `Current State`, current role-selection decisions to `Agent Selection`, phase status and work item to `Execution Plan`, and each material historical result or superseded selection to one concise `Progress Log` row. Put immediate work in `Next Actions` and unresolved or accepted risks in `Blockers And Risks`. Never duplicate full evidence or the same result across sections.

For every new progress file, preserve the exact section shapes shown in the template: four labeled bullets in `Objective`; six labeled bullets in `Current State`; two metadata bullets plus one table in `Agent Selection`; one table in `Execution Plan`; one append-only table in `Progress Log`; `None` or a numbered list of one to three items in `Next Actions`; and exactly the two labeled bullets `Blockers` and `Risks` in `Blockers And Risks`. Do not add free-form narrative, auxiliary tables, or extra bullets to any section.

For every new progress file, `Current State` must contain exactly the six labeled top-level bullets shown below, in that order. Put topology, the candidate-bearing product or deliverable integration-state identity and fingerprint, and the separately classified live operational coordination inventory in `Working set`; put the compact semantic capability snapshot and reusable capacity in `Runtime or external state`; put active durable-assignment bindings, runtime-compatible spawn inputs, exact returned identities, requested metadata, authoritative effective metadata or `Unverified`, and ownership in `Active agents and ownership`. Use `None` or `Not Applicable` for an empty field. Do not add tables, nested lists, narrative, phase histories, accepted or superseded candidates, completed agents, old verdicts, evidence catalogs, resolved risks, or per-phase `Current ...` bullets. Keep each bullet to one compact paragraph of at most 200 words. Keep at most five concise facts in `Decisions and durable findings`, and only if they change the next decision or are required to resume safely. When a current fact changes, replace it and record the transition in `Progress Log`; never append history to `Current State`.

For an existing progress file created before this schema, apply these content boundaries only to future writes. Do not compact or reorder old content automatically, do not block execution because the legacy section is oversized, and do not add another top-level `Current State` bullet. Update the best matching current field in place, replace superseded durable findings, and route new chronology to `Progress Log`.

For `Agent Selection`, keep exactly one row per non-terminal material assignment still required by a phase that is not yet `Accepted`. Append a new row at the bottom immediately before its first spawn; never prepend, insert between rows, sort, group, or reposition existing rows. Keep the durable assignment ID separate from its runtime-compatible spawn input and exact returned runtime identity. Before spawning, record requested role and model or reasoning overrides; after spawning, record only effective metadata exposed by authoritative runtime state, otherwise `Unverified`, never agent self-report. Keep spawn input, identities, active status, metadata, and ownership in `Current State` or `Progress Log`, not the selection table. Re-evaluate or update a row in place, including for a replacement, only while task type, primary deliverable, material ownership scope, and acceptance boundary remain unchanged. If any boundary changes, record retirement or supersession in `Progress Log`, create a new durable assignment, append its new row at the bottom immediately before its first spawn, and use a fresh instance. When the phase becomes `Accepted`, record each assignment's selected role, terminal result, candidate identity, exact returned runtime identity, lifecycle disposition, and evidence in `Progress Log`, then remove all of that phase's rows in the same ordinary update. Retire a cancelled, abandoned, superseded, terminally failed, or no-longer-required assignment only after its evidence, closure or non-reusable retirement, capacity disposition, and risk disposition or replacement are logged; never remove a rejecting assignment to bypass its verdict. Do not automatically purge legacy rows from phases accepted before this rule. Use only `Exploration`, `Implementation`, `Verification`, or `Not Applicable` for `Task Type`, and only `Pending`, `Selected`, `Refresh Required`, or `Not Applicable` for `Decision Status`. Use the `Not Applicable` row only when no non-terminal material assignment is currently required.

List only visible roles that could realistically perform the assignment and limit `Rationale` to one sentence explaining material fit. Do not add coordinator-local work, runtime identities, active status, ownership, inventories, outputs, reasoning, unrelated roles, or prior choices. Record superseded choices in `Progress Log`. Refresh capability and role discovery only after a different or uncertain runtime or a material capability or visible-metadata change; re-evaluate an existing row against the current snapshot only within the unchanged assignment boundaries defined above. Beyond the two fixed metadata bullets and the selection table, add no content to this section.

For `Execution Plan`, use exactly this column order: `ID`, `Status`, `Work Item`, `Owner`, `Depends On`, and `Done When`. Keep `ID` as a short stable identifier such as `P1`, `M-04`, or `F2`, keep `Status` immediately after it, and put the descriptive title only in `Work Item`. For a material implementation phase, make `Done When` identify or reference its readiness contract, handoff gate, acceptance evidence, and retry or circuit-breaker threshold without expanding the table into a test transcript. Use only `Pending`, `In Progress`, `Done`, `Accepted`, `Blocked`, or `Not Applicable`. Use `Done` while execution is complete but integration validation or acceptance remains pending. Use `Accepted` only when `Done When`, implementation readiness and handoff gates, integration validation, coordinator gates, every current required verification assignment, and any triggered circuit-breaker strategy pass against the same frozen product or deliverable candidate and authoritative candidate-bearing integration-state identity. Changes limited to the separately inventoried live `.agent-hive` ledger or other operational coordination artifacts do not invalidate verdicts. If the ledger is a deliverable, review an identified immutable snapshot and keep later live-ledger updates separate. Record verdicts, invalidations, retired assignments, risk dispositions, failures, quality metrics, and aggregated acceptance in `Progress Log`; after a failed gate, return the phase to `Pending` or `In Progress`.

For `Next Actions`, keep only the next one to three real actions and replace the list when the dependency frontier changes. Use `None` when no action remains.

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
- Working set: Pending files, modules, systems, data sources, and relevant workspace state. For repository-backed work, include `shared-live`, `isolated/forked`, or `unknown` topology; authoritative workspace; base revision; candidate-bearing product or deliverable integration-state identity and content fingerprint; complete tracked/untracked inventory with every path classified as candidate-bearing or live operational coordination state; and path attribution for shared-live work or intended-delta/base/fingerprint evidence for isolated work. Keep the live `.agent-hive` ledger and other operational artifacts inventoried, attributed, and protected from loss but outside the candidate fingerprint and verdict invalidation. If the ledger is a deliverable, identify its immutable reviewed copy or snapshot as candidate-bearing content and keep later live-ledger updates separate. Use an explicit candidate-clean marker when applicable.
- Runtime or external state: Capability snapshot `{captured-at; authoritative source; goal/delegation availability; usable concurrency; workspace topology; none/bounded/full-history context transfer; context-delivery, same-assignment continuation, steering/interruption, state-change wait, authoritative-result retrieval, terminal lifecycle/capacity-release, descendant-delegation semantics; visible-role metadata fingerprint}`; refresh status `{Current or Refresh Required}`; reusable capacity `{value or Unverified}`. Add only external installed, deployed, environment, service, process, dataset, or system state required to resume safely.
- Active agents and ownership: `None`, or `{durable-assignment-id} -> spawn input {runtime-compatible-input}; returned identity {exact-runtime-identity}; requested {role/model/reasoning overrides}; effective {authoritative values or Unverified}; owned scope {scope}; status {state}`. Bind each exact identity to one assignment for life. Remove a terminal binding only after its closure or non-reusable retirement, capacity disposition, and evidence are logged.
- Assumptions and constraints: Pending review, or `None`.
- Decisions and durable findings: Pending review, `None`, or at most five concise current plan-changing facts.

## Agent Selection

- Discovery snapshot: `{timestamp and capability/visible-role metadata fingerprint}`, `Pending`, or `Not Applicable`; status: `Current`, `Refresh Required`, `Pending`, or `Not Applicable`.
- Refresh trigger: `None`, or `{different or uncertain runtime, material capability change, or material visible-metadata change}`.

| Assignment | Task Type | Eligible Roles | Selected Role | Decision Status | Rationale |
| --- | --- | --- | --- | --- | --- |
| Not Applicable | Not Applicable | None | Not Applicable | Not Applicable | No non-terminal material delegated assignment is currently required. |

## Execution Plan

| ID | Status | Work Item | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- |
| P1 | Pending | Define executable phases | Agent Hive | Objective | Plan is specific enough to resume without chat context. |

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialization | Progress file created; initial topology, capability snapshot, candidate-bearing state, separate operational coordination inventory, and phase quality-control thresholds captured. |

## Next Actions

1. `{owner}`: {next action}; depends on {dependency}; complete when {stop condition}.

## Blockers And Risks

- Blockers: `None`, or `{blocker and required resolution}`.
- Risks: `None`, or `{current, accepted, or residual risk}`.
```
