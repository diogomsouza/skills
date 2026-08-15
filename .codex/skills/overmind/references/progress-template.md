# Overmind Progress Template

Populate as `.overmind/PLAN-PROGRESS-{context-id}.md`. Use this file as concise resumable execution state, not as a ceremonial report or exhaustive transcript.

Preserve exactly the seven `##` sections below, once each and in this order. Store each fact in one authoritative home: objective facts in `Objective`; current workspace, runtime,
ownership, and quality-contract facts in `Current State`; current non-terminal selection decisions in `Agent Selection`; phase progress in `Execution Plan`; material history in
`Progress Log`; immediate work in `Next Actions`; and unresolved or accepted risk in `Blockers And Risks`.

Write the ledger only for material decisions, ownership changes, phase transitions, candidate promotions, blockers, and terminal evidence. In one atomic edit, use one authoritative
timestamp for `Updated` and the new `Progress Log` row, refresh every affected section, and validate all `Execution Plan` statuses against its durable vocabulary.
Keep routine checkpoints in commentary.

Update current facts in place and append only material events. Never add tables or headings beyond the shapes below; never copy raw command output or an agent report; never retain
completed candidates, terminal agents, old verdicts, or resolved blockers in current-state fields. Evidence references must remain understandable after resume and point to a
workspace path, command/result, immutable external result, or concise ledger event.

Use append time in monotonically nondecreasing order for `Progress Log`. If an event happened earlier, put its observed time inside `Evidence / Result`; never reorder or backdate
appended rows.

Header `Status` is `Pending`, `In Progress`, `Blocked`, or `Ready For Final`. `Ready For Final` means all acceptance prerequisites passed and the final handoff may be emitted or
safely reemitted after current-state revalidation; it is not a second acceptance authority.

```markdown
# Overmind Progress: {context-id}

Goal: `{authoritative goal identity or exact objective}` - `{authoritative status}`
Task: {task}
Created: {timestamp}
Updated: {timestamp}
Status: `Pending`, `In Progress`, `Blocked`, or `Ready For Final`

## Objective

- Request: `{original user request}`
- In scope: `{included outcomes and boundaries}`
- Out of scope: `{explicit exclusions}`
- Done when: `{user-visible result and acceptance evidence}`

## Current State

- Current phase: `{P0 bounded discovery until the post-discovery decomposition checkpoint, then the current concrete acceptance phase}`
- Working set: `{authoritative workspace and topology; current cumulative candidate identity/fingerprint; root or immutable locator; reproducibility recipe or evidence reference;
  protected operational coordination state; relevant external state}`
- Runtime or external state: `{captured-at; authoritative goal and delegation lifecycle capabilities; capability and visible-role metadata snapshot; context-transfer semantics and
  selection policy; usable capacity; lifecycle/release behavior; required service, database, process, deployment, or environment state}`
- Active agents and ownership: `None`, or `{assignment -> authoritative runtime identity; selected role; effective metadata or Unverified; owned/read-only scope; current state}`
- Active implementation quality contracts: `None`, or `{assignment -> verification mode and rationale; activated specialists and material consequence; invariant clusters; fault
  paths; evidence gate; correction threshold}`
- Assumptions and constraints: `None`, or `{only current constraints needed to act safely}`
- Decisions and durable findings: `None`, or `{at most five current plan-changing conclusions}`

## Agent Selection

- Discovery snapshot: `{timestamp and compact capability/visible-role metadata fingerprint}`, `Pending`, or `Not Applicable`; status: `Current`, `Refresh Required`, `Pending`, or
  `Not Applicable`.
- Refresh trigger: `None`, or `{runtime uncertainty, material capability change, or visible-role metadata change}`.

| Assignment | Task Type | Eligible Roles | Selected Role | Decision Status | Rationale |
| --- | --- | --- | --- | --- | --- |
| Not Applicable | Not Applicable | None | Not Applicable | Not Applicable | No non-terminal material delegated assignment is currently required. |

## Execution Plan

Phase status: `Pending` | `In Progress` | `Done` | `In Review` | `Accepted` | `Blocked` | `Not Applicable`

| ID | Status | Work Item | Source Coverage | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- | --- |
| P0 | In Progress | Discover/decompose phases | Request/source IDs | Overmind | Objective | Outcomes map to cohesive phases with earliest dependencies and evidence. |

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

`Current State` is present tense only. Keep exactly the seven labeled bullets above, in that order. Replace changed values and record each material transition once in
`Progress Log`.

`Goal` records the authoritative runtime goal identity or exact objective and its current status. It owns durable objective lifecycle and does not duplicate phase acceptance in
`Execution Plan`. Apply the inspection and resume rules from `SKILL.md` before updating it.

`Active implementation quality contracts` is the only durable current snapshot of verifier-informed executor obligations. Record the verification mode, its rationale, and only
specialists that passed the selection gates, each with its changed boundary and material consequence. Keep obligations compact and concrete; never store verdicts here. Remove a
contract after its phase no longer needs correction and retain its material outcome and evidence in `Progress Log`.

`Runtime or external state` records authoritative runtime capabilities, topology, context-transfer modes, selected policy, capacity, lifecycle behavior, and relevant external
state. Apply lifecycle, continuation, and contamination handling from `SKILL.md`.

`Agent Selection` contains only non-terminal material assignments at the current dependency frontier whose capability decision is pending, selected, or requires refresh. A future
phase is not an assignment and receives no row until its dependencies are satisfied and selection actually begins. Use only `Exploration`, `Implementation`, `Verification`, or
`Not Applicable` for `Task Type`; use only `Pending`, `Selected`, `Refresh Required`, or `Not Applicable` for `Decision Status`. List only realistically eligible roles and use one
sentence for rationale. Runtime identities and ownership do not belong here.

Use the `Not Applicable` row when no current selection or non-terminal assignment remains. During P0 review, do not add implementation or verification rows. The current phase's
verification mode and anticipated capabilities belong in its quality contract, not speculative verifier rows. Runtime identities and ownership belong in `Current State`;
terminal results, lifecycle disposition, evidence, and candidate impact belong in `Progress Log`.

`Execution Plan` is the sole phase-acceptance view. Keep exactly one row per phase and validate its `Status` against the durable vocabulary before each ledger write.
A new run begins with only P0; after its evidence gate passes, materialize concrete phases using the decomposition, dependency, coverage, and acceptance rules from `SKILL.md`.

`Work Item` names the independently acceptable capability or invariant cluster. Phase transition and acceptance semantics are defined in `SKILL.md`.

`Source Coverage` lists only compact identifiers or headings for required behaviors, inherited guarantees, and cross-phase invariants owned primarily by that phase; do not restate
requirements. Before P0 acceptance, every required item has exactly one primary phase. `Owner` is `Overmind` for root-owned work, `Unassigned` for a future delegated phase, or an
assignment ID selected at the current dependency frontier.

Never create speculative assignment IDs or owners for future phases. `Depends On` uses phase IDs or `Objective`. `Done When` remains an observable, stable outcome and evidence
gate, not a transcript.

`Progress Log` is the single home for goal and lifecycle transitions, assignment spawns and identities, terminal handoffs, candidate freezes or promotions, readiness decisions,
verification verdicts, correction findings, strategy reviews, phase acceptance or reopening, external validation, quality metrics, lifecycle disposition, and resolved blockers.
Use one concise row per material event. Candidate and verification history live only here.

`Next Actions` is either `None` or one to three immediately executable actions. Replace it when the dependency frontier changes; do not preserve completed actions.

`Blockers And Risks` keeps exactly the two labeled bullets. Remove resolved blockers after their resolution is logged. Keep only current accepted or residual risk.

`Blocked` records the affected phase, exact unresolved decision or authority, and safe next action after the blocking rules in `SKILL.md` apply.

`Ready For Final` records that the final-readiness requirements in `SKILL.md` passed. In one atomic update, set `Current phase` to `Complete`,
`Working set`, active agents, and active quality contracts to `None`, normalize `Agent Selection` to `Not Applicable`, require every phase to be `Accepted` or `Not Applicable`, and
set `Next Actions` and blockers to `None`. Preserve the final candidate identity, validation, residual risks, and authoritative goal usage in one `Goal complete; ready for final
handoff` event. There is no ledger `Completed` state without an authoritative delivery receipt.
