# Overmind Progress Template

Populate as `.overmind/PLAN-PROGRESS-{context-id}.md`. Use this file as concise resumable execution state, not as a ceremonial report or exhaustive transcript.

Preserve exactly the seven `##` sections below, once each and in this order. Store each fact in one authoritative home: objective facts in `Objective`; current workspace, runtime,
ownership, and quality-contract facts in `Current State`; current non-terminal selection decisions in `Agent Selection`; phase progress in `Execution Plan`; material history in
`Progress Log`; immediate work in `Next Actions`; and unresolved or accepted risk in `Blockers And Risks`.

Write the ledger only for material decisions, ownership changes, phase transitions, checkpoint dispositions, candidate promotions, blockers, and terminal evidence. In one atomic
edit, use one authoritative timestamp for `Updated` and the new `Progress Log` row, refresh every affected section, and validate all `Execution Plan` statuses against its durable
vocabulary.
Keep routine checkpoints in commentary.

Update current facts in place and append only material events. Never add tables or headings beyond the shapes below; never copy raw command output or an agent report; never retain
completed candidates, terminal agents, old verdicts, or resolved blockers in current-state fields. Evidence references must remain understandable after resume and point to a
workspace path, command/result, immutable external result, or concise ledger event.

Use append time in monotonically nondecreasing order for `Progress Log`. If an event happened earlier, put its observed time inside `Evidence / Result`; never reorder or backdate
appended rows.

Header `Status` is `Pending`, `In Progress`, `Blocked`, or `Ready For Final`. `Ready For Final` means the authoritative goal is complete, the terminal ledger is normalized, and the
final handoff may be emitted or safely reemitted after revalidation; it is not a second acceptance authority.

```markdown
# Overmind Progress: {context-id}

Goal: `{authoritative goal identity or exact objective}` - `{authoritative status}`
Task: {task}
Created: {timestamp}
Updated: {timestamp}
Status: `Pending`, `In Progress`, `Blocked`, or `Ready For Final`

## Objective

- Request: `{original user request}`
- Specification: `None`, or `{exact accessible plan or specification locator}`; origin: `User Referenced` or `Generated`
- In scope: `{included outcomes and boundaries}`
- Out of scope: `{explicit exclusions}`
- Done when: `{user-visible result and acceptance evidence; when Specification is not None, complete mapped-requirement acceptance evidence and explicit justification for every exclusion}`

## Current State

- Current phase and gate: `{current concrete phase; exact pending gate or condition; governing SKILL.md section; next legal transition}`
- Working set: `{authoritative workspace and topology; current cumulative candidate identity/fingerprint; root or immutable locator; reproducibility recipe or evidence reference;
  protected operational coordination state; relevant external state}`
- Runtime or external state: `{captured-at; authoritative goal and delegation lifecycle capabilities; role and execution-configuration metadata snapshot; context-transfer and
  selection policy; usable capacity; lifecycle/release behavior; required service, database, process, deployment, or environment state}`
- Active agents and ownership: `None`, or `{assignment -> runtime identity; selected role; selected model, effort, and context mode; effective configuration or Unverified;
  owned/read-only scope; current state}`
- Active implementation quality contracts: `None`, or `{assignment -> verification mode and rationale; activated specialists and material consequence; invariant clusters; fault
  paths; evidence gate; correction threshold}`
- Assumptions and constraints: `None`, or `{only current constraints needed to act safely}`
- Decisions and durable findings: `None`, or `{at most five current plan-changing conclusions}`

## Agent Selection

- Discovery snapshot: `{timestamp and compact role, model, effort, override, fixed-configuration, ordering, and selection-metadata fingerprint}`, `Pending`, or `Not Applicable`;
  status: `Current`, `Refresh Required`, `Pending`, or `Not Applicable`.
- Refresh trigger: `None`, or `{runtime uncertainty or material host, capability, configuration availability, ordering, override, or fixed-configuration change}`.

| Assignment | Task Type | Eligible Roles | Selected Role | Execution Configuration | Decision Status | Rationale |
| --- | --- | --- | --- | --- | --- | --- |
| Not Applicable | Not Applicable | None | Not Applicable | Not Applicable | Not Applicable | No non-terminal material delegated assignment is currently required. |

## Execution Plan

Phase status: `Pending` | `In Progress` | `Done` | `In Review` | `Accepted` | `Blocked` | `Not Applicable`

| ID | Status | Work Item | Source Coverage | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- | --- |
| P0 | In Progress | Discover/decompose phases | Request; Specification locator and headings when present; project-instruction locators | Overmind | Objective | Outcomes map to cohesive phases with earliest dependencies and evidence. |

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialization | Goal state, preliminary P0, known objective and working set, capability snapshot, and next discovery decision recorded. |

## Next Actions

1. `Overmind`: complete bounded P0 discovery and the post-discovery decomposition checkpoint; depends on `Objective`; complete when concrete acceptance phases and the checkpoint
   are recorded.

## Blockers And Risks

- Blockers: `None`, or `{blocking condition and required resolution}`.
- Risks: `None`, or `{current accepted or residual risk}`.
```

**Field rules**

`Current State` is present tense only. Keep exactly the seven labeled bullets above, in that order. `Current phase and gate` must identify the exact pending condition, governing
`SKILL.md` section, and next legal transition clearly enough to resume without conversation history. Replace changed values and record each material transition once in `Progress Log`.

`Request` preserves the original user request verbatim and never appends source text. `Specification` is the authoritative home for the implementation plan or specification locator.
Use the exact accessible user-referenced locator with origin `User Referenced`; otherwise use the generated workspace-relative PLAN-SPECS path with origin `Generated` when creation
succeeded; otherwise use `None`. Prefer a workspace-relative locator when the user-referenced source is inside the workspace.

When `Specification` is not `None`, `Done when` includes complete specification conformance: every applicable requirement mapped through `Source Coverage` has acceptance evidence in
an `Accepted` phase, and every exclusion has an explicit justification. Keep the locator only in `Specification`; do not repeat it in `Done when`.

`Goal` records the authoritative runtime goal identity or exact objective and its current status. It owns durable objective lifecycle and does not duplicate phase acceptance in
`Execution Plan`. Apply the inspection and resume rules from `SKILL.md` before updating it.

`Active implementation quality contracts` is the only durable current snapshot of verifier-informed executor obligations. Record the verification mode, its rationale, and only
specialists that passed the selection gates, each with its changed boundary and material consequence. Keep obligations compact and concrete; never store verdicts here. Remove a
contract after its phase no longer needs correction and retain its material outcome and evidence in `Progress Log`.

`Runtime or external state` records authoritative runtime capabilities, topology, context-transfer modes, model and effort availability and ordering, fixed configurations, selection
policy, capacity, lifecycle behavior, and relevant external state. Apply lifecycle, continuation, and contamination handling from `SKILL.md`.

`Agent Selection` contains only non-terminal material assignments at the current dependency frontier whose capability or execution-configuration decision is pending, selected, or
requires refresh. A future phase is not an assignment and receives no row until its dependencies are satisfied and selection begins. Use only `Exploration`, `Implementation`,
`Verification`, or `Not Applicable` for `Task Type`; use only `Pending`, `Selected`, `Refresh Required`, or `Not Applicable` for `Decision Status`. `Execution Configuration` is always
the concrete selected runtime model, reasoning effort, and context-transfer mode, including capability-fixed pairs; `inherit` is invalid and independent verification requires
`none`. A `Selected` row becomes spawn authority only after root reads it back; the call must match its assignment, role, model, effort, and context exactly. Record effective metadata
only in `Current State` and `Progress Log`. List only realistic roles and justify capability, configuration, and context in one sentence; identities and ownership do not belong here.

Use the `Not Applicable` row when no current selection or non-terminal assignment remains. During P0 review, do not add implementation or verification rows. The current phase's
verification mode and anticipated capabilities belong in its quality contract, not speculative verifier rows. Runtime identities and ownership belong in `Current State`;
terminal results, lifecycle disposition, evidence, and candidate impact belong in `Progress Log`.

`Execution Plan` is the sole phase-acceptance view. Keep exactly one row per phase and validate its `Status` against the durable vocabulary before each ledger write.
A new run begins with only P0; after its evidence gate passes, materialize concrete phases using the decomposition, dependency, coverage, and acceptance rules from `SKILL.md`.

`Work Item` names the independently acceptable capability or invariant cluster. Phase transition and acceptance semantics are defined in `SKILL.md`.

`Source Coverage` lists compact, resolvable source locators and relevant headings for required behaviors, inherited guarantees, and cross-phase invariants owned primarily by that
phase; do not restate requirements. When `Specification` is not `None`, every affected phase cites its exact locator and relevant heading. All `Specification` entries are root-only
inputs for building and rechecking self-contained implementation and verification contracts regardless of origin; never carry their locators into agent prompts. Before P0
acceptance, every required item has exactly one primary phase. `Owner` is `Overmind` for root-owned work, `Unassigned` for a future delegated phase, or an assignment ID selected at
the current dependency frontier.

Never create speculative assignment IDs or owners for future phases. `Depends On` uses phase IDs or `Objective`. `Done When` remains an observable, stable outcome and evidence
gate, not a transcript.

`Progress Log` is the single home for goal and lifecycle transitions, assignment spawns and identities, terminal handoffs, candidate freezes or promotions, checkpoint dispositions,
readiness decisions, verification verdicts, correction findings, strategy reviews, phase acceptance or reopening, external validation, quality metrics, lifecycle disposition, and
resolved blockers. Use one concise row per material event. Candidate and verification history live only here.

`Next Actions` is either `None` or one to three immediately executable actions, each naming its governing `SKILL.md` section and required ledger evidence. It is the authorization
gate for spawning, authorizing writes, freezing or promoting a candidate, applying a verdict, transitioning, accepting, or reopening a phase, committing, and completing the goal.
After ledger creation, perform none of these unless the exact action is listed and its evidence exists; reconcile the ledger first when needed. Replace the list when the dependency
frontier changes and never preserve completed actions.

`Blockers And Risks` keeps exactly the two labeled bullets. Remove resolved blockers after their resolution is logged. Keep only current accepted or residual risk.

`Blocked` records the affected phase, exact unresolved decision or authority, and safe next action after the blocking rules in `SKILL.md` apply.

`Ready For Final` records that the final-readiness requirements in `SKILL.md` passed and the authoritative goal is complete. Terminal normalization must not advance phase statuses,
create missing transitions, or invent checkpoint dispositions. In one atomic update, set `Current phase and gate` to `Complete`, `Working set`, active agents, and active quality
contracts to `None`, normalize `Agent Selection` to `Not Applicable`, require every phase to be `Accepted` or `Not Applicable`, require one recorded checkpoint disposition for each
candidate-bearing phase's current acceptance, and set `Next Actions` and blockers to `None`. Preserve the final candidate identity, validation, residual risks, and authoritative
goal usage in one `Goal complete; ready for final handoff` event. There is no ledger `Completed` state without an authoritative delivery receipt.
