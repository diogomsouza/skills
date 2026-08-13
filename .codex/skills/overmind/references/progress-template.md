# Overmind Progress Template

Populate as `.overmind/PLAN-PROGRESS-{context-id}.md`. Use this file as concise resumable execution state, not as a ceremonial report or exhaustive transcript.

Preserve exactly the seven `##` sections below, once each and in this order. Store each current fact in one authoritative home: objective facts in `Objective`, current workspace/runtime/ownership/quality-contract facts in `Current State`, current non-terminal selection decisions in `Agent Selection`, phase progress in `Execution Plan`, material history in `Progress Log`, immediate work in `Next Actions`, and unresolved or accepted risk in `Blockers And Risks`.

Update current fields in place and append only material events. Never add tables or headings beyond the shapes below; never copy raw command output or an agent report; never retain completed candidates, terminal agents, old verdicts, or resolved blockers in current-state fields. Evidence references must be understandable after resume and point to a workspace path, command/result, immutable external result, or concise ledger event.

Use append time in monotonically nondecreasing order for `Progress Log`. If an observed event happened earlier, put its observed time inside `Evidence / Result`; never reorder or backdate appended rows.

Header `Status` is `Pending`, `In Progress`, `Blocked`, or `Ready For Final`. `Ready For Final` means all acceptance prerequisites passed and the final handoff may be emitted or safely reemitted after current-state revalidation; it is not a second acceptance authority.

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
- Working set: `{authoritative workspace; shared-live, isolated/forked, or unknown topology; current cumulative candidate-version identity/fingerprint; exact root or immutable locator; phase canonicalization scheme; current complete manifest or complete unit set; exhaustive inclusion rule and explicit exclusions; executable-metadata and non-regular-unit policy; separately protected operational coordination state; relevant external state}`
- Runtime or external state: `{captured-at; authoritative goal and delegation lifecycle capabilities; authoritative capability and visible-role metadata snapshot; supported none, bounded, or full-history context-transfer semantics and current selection policy; usable capacity; lifecycle/release behavior; required service, database, process, deployment, or environment state}`
- Active agents and ownership: `None`, or `{assignment -> exact authoritative runtime identity; selected role; effective metadata or Unverified; owned/read-only scope; current state}`
- Active implementation quality contracts: `None`, or `{implementation assignment -> selected downstream verification capabilities; cohesive invariant clusters; material fault/negative paths; evidence gate; correction/strategy threshold}`
- Assumptions and constraints: `None`, or `{only current constraints needed to act safely}`
- Decisions and durable findings: `None`, or `{at most five current plan-changing conclusions}`

## Agent Selection

- Discovery snapshot: `{timestamp and compact capability/visible-role metadata fingerprint}`, `Pending`, or `Not Applicable`; status: `Current`, `Refresh Required`, `Pending`, or `Not Applicable`.
- Refresh trigger: `None`, or `{runtime uncertainty, material capability change, or visible-role metadata change}`.

| Assignment | Task Type | Eligible Roles | Selected Role | Decision Status | Rationale |
| --- | --- | --- | --- | --- | --- |
| Not Applicable | Not Applicable | None | Not Applicable | Not Applicable | No non-terminal material delegated assignment is currently required. |

## Execution Plan

| ID | Status | Work Item | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- |
| P0 | In Progress | Discover the architecture, consumers, dependencies, current changes, topology, invariant and failure-domain boundaries, validation surfaces, and material risks needed to decompose implementation | Overmind | Objective | Authoritative evidence is sufficient to create bounded implementation phases with explicit ownership, dependencies, quality contracts, validation, and proportional verification paths. |

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialization | Goal created or reused; preliminary P0 discovery phase, known objective and working set, capability snapshot status, and next discovery decision recorded. |

## Next Actions

1. `Overmind`: complete bounded P0 discovery and perform the post-discovery decomposition checkpoint; depends on `Objective`; complete when concrete acceptance phases are recorded and the ledger checkpoint is confirmed.

## Blockers And Risks

- Blockers: `None`, or `{blocking condition and required resolution}`.
- Risks: `None`, or `{current accepted or residual risk}`.
```

**Field rules**

`Current State` is present tense only. Keep exactly the seven labeled bullets shown above, in that order. Replace a value when it changes and record the material transition once in `Progress Log`.

`Goal` records the authoritative runtime goal identity or exact objective and its current status. The goal owns durable objective lifecycle; it does not duplicate phase acceptance in `Execution Plan`. Apply the inspection and resume rules from `SKILL.md` before updating it.

`Active implementation quality contracts` is the only durable current snapshot of verifier-informed executor obligations. Keep it compact and concrete. Name selected verification capabilities, not verifier conclusions. Remove a contract after its implementation phase no longer needs correction; retain its material outcome and evidence in `Progress Log`.

`Runtime or external state` records authoritative runtime capabilities, topology, supported context-transfer modes, selected policy, capacity, lifecycle behavior, and relevant external state. Apply lifecycle, continuation, and contamination handling from `SKILL.md`.

`Agent Selection` contains one row per non-terminal material assignment still required by an unaccepted phase. Use only `Exploration`, `Implementation`, `Verification`, or `Not Applicable` for `Task Type`; use only `Pending`, `Selected`, `Refresh Required`, or `Not Applicable` for `Decision Status`. List only realistically eligible roles and use one sentence for rationale. Runtime identities and ownership do not belong here.

Use the `Not Applicable` row only when no current assignment remains. Runtime identities and ownership belong in `Current State`; terminal results, lifecycle disposition, evidence, and candidate impact belong in `Progress Log`. Apply assignment selection, spawn, reuse, and termination rules from `SKILL.md`.

`Execution Plan` is the sole phase-acceptance view. A new run begins with only the P0 row shown in the template. After its evidence gate passes, replace catch-all placeholders with concrete phases using the decomposition, dependency, and acceptance rules from `SKILL.md`.

Keep exactly one row per phase. `Work Item` names the independently acceptable capability or invariant cluster. Use only `Pending`, `In Progress`, `Done`, `In Review`, `Accepted`,
`Blocked`, or `Not Applicable` as phase status; their transition and acceptance semantics are defined in `SKILL.md`.

`Owner` is `Overmind` for a root-owned phase or a comma-separated set of durable assignment IDs. `Depends On` uses phase IDs or `Objective`. `Done When` remains a stable outcome and evidence gate, not a transcript.

`Progress Log` is the single home for goal creation/reuse and lifecycle transitions, assignment spawns and exact identities, terminal handoffs, candidate freezes/promotions, readiness decisions, verification verdicts, correction findings, strategy reviews, phase acceptance/reopening, external validation, reliable quality metrics, lifecycle/capacity disposition, and resolved blockers. Use one concise row per material event. Candidate history and verification history live only here.

`Next Actions` is either `None` or a numbered list of one to three immediately executable actions. Replace it when the dependency frontier changes; do not preserve completed actions.

`Blockers And Risks` keeps exactly the two labeled bullets. Remove resolved blockers after their resolution is logged. Keep only current accepted or residual risk.

`Blocked` records the affected phase, exact unresolved decision or authority, and safe next action after the blocking rules in `SKILL.md` apply.

`Ready For Final` records that the final-readiness requirements in `SKILL.md` passed. Store the confirmed goal status, current candidate identity, absence of active ownership or blockers, and one `Goal complete; ready for final handoff` event with authoritative usage. There is no ledger `Completed` state without an authoritative delivery receipt.
