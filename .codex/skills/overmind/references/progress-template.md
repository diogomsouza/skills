# Overmind Progress Ledger Template

Populate as `.overmind/{context-id}/PLAN-PROGRESS-{context-id}.md`. Keep one ledger per run and preserve its `context-id` on resume.

Keep exactly the seven `##` sections below, in this order. Replace mutable current facts instead of duplicating them, and append material transitions to Progress Log. In Assignments, append one row per immutable assignment-instance binding; never repurpose or delete a historical row or overwrite its assignment ID, origin, package, runtime identity, or scope. Update its four state/disposition columns independently and log each material transition. Corrections and replacements always receive fresh IDs, rows, packages, and runtime identities.

- Goal: [authoritative managed-run objective]
- Context ID: `[context-id]`
- Context root: `.overmind/[context-id]/`
- Created: `[date and time]`
- Updated: `[date and time]`
- Throughput gate snapshot: `[timestamp; authoritative sources; usable/occupied/free capacity; lifecycle controls; topology; active agents and writers]`
- Throughput decision: `[Managed-Serial|Managed-Parallel(N)]` - [net-value rationale]
- Plan revision: `[positive integer]`
- Plan status: `[Draft|DesignReady|Reopened]`
- Phase: `[GoalDefined|Planning|DesignReady|Executing|RootChecked|Verifying|Correcting|Accepted]`
- Risk: `[Standard|High-Risk]`
- Circuit: `[Closed|Open]`
- Status: `[Active|Accepted|Blocked]`

## Goal And Completion Contract

- Outcome: [user-visible result]
- In scope: [included boundaries]
- Out of scope: [excluded boundaries]
- Required evidence: [tests, inspection, smoke, and independent verification]
- User decision required when: [material choice that cannot be inferred]
- Complete when: [acceptance, terminal assignments and instances, released ownership, recorded capacity disposition, no blockers, and no next actions]

## Frozen Plan

- Sources inspected: [request, instructions, critical code, interfaces, tests, and consumers]
- Artifact design: [candidate and persistent run artifacts]
- Throughput decision: [why serial or parallel is expected to reduce net time or risk]
- Risk decision: [classification and triggers]
- Runtime constraints: [required capabilities, usable capacity, and lifecycle assumptions]
- Topology and integration policy: [shared-live, isolated/forked, or unknown; ownership and forward-only rules]
- Architecture and algorithm: [closed design and sequencing]
- Interfaces and integration: [consumers, compatibility, and order]
- State and failure behavior: [negative paths, cancellation, cleanup, and recovery]
- Assignment boundaries: [ownership and dependencies]
- Checkpoint plan: [High-Risk or planned vertical smoke, otherwise None]
- Verification plan: [Standard baseline or High-Risk portfolio, one correction wave per Plan Revision, and circuit triggers]
- Open material decisions: [None before DesignReady]

| Requirement | Planned evidence | Disposition |
| --- | --- | --- |
| [requirement] | [command, inspection, or review] | [Required|Not Applicable] |

## Current State

- Phase: [current phase and Plan Revision]
- Candidate State: [Candidate ID; fingerprint and projection method; Mutable or Frozen; base revision; exact cumulative scope; candidate-bearing delta/hunk/symbol provenance to immutable authorized assignment records; mixed paths]
- Operational State: [snapshot timestamp; authoritative source; topology; occupied/free capacity; active writers; operational artifact inventory; operational and preserved-user change units excluded from the candidate projection]
- Assignment state: [current nonterminal assignment IDs and states; terminal history remains in Assignments]
- Ownership state: [scope-to-assignment map, including unowned/released scopes and explicit transfer events]
- Instance lifecycle: [runtime identity-to-lifecycle map]
- Capacity disposition: [runtime identity-to-occupied/released/still-occupied map]
- Validation: [latest commands and results, including unrun checks]
- Last event: [latest material event]
- Resume note: [next safe action and any freshness check needed]

## Assignments

| Assignment ID | Origin / findings | Type/risk | Required capability | Selected agent | Runtime identity | Base candidate | Package | Owned scope | Assignment state | Ownership state | Instance lifecycle | Capacity disposition | Done when |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [id] | [initial or rejected candidate, finding IDs, and predecessor assignment] | [type/risk] | [declared capability] | [agent or pending] | [exact identity or pending] | [ID/fingerprint] | [path/version or N/A] | [paths] | [state] | [unassigned, reserved, owned, or released] | [pending, live, terminal, interrupted, or non-reusable] | [not acquired, occupied, released, or still occupied] | [evidence] |

## Verification Contract

| Contract | Reviewer capability | Runtime identity | Candidate | Scope | Required evidence | Native result | Verdict | Coverage | Unreviewed surface |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [contract] | [declared capability and independence] | [exact identity or pending] | [frozen ID/fingerprint] | [cumulative scope] | [evidence] | [native result or pending] | [Pending|Accept|Reject] | [Pending|Complete|Incomplete] | [None or gap] |

- Correction wave: `[0/1 for Plan Revision N]`; rejected candidate: `[ID/fingerprint or N/A]`; finding IDs: `[IDs or N/A]`; correction assignments: `[fresh IDs or N/A]`; ownership transfers: `[logged events or N/A]`.
- Circuit: `[Closed|Open]`; reason: [None or trigger]; close when: [None or strategy completion condition].

## Progress Log

| Revision | Time | Event | Evidence |
| --- | --- | --- | --- |
| [revision] | [time] | [transition, runtime/topology refresh, acknowledgement, assignment/ownership/lifecycle/capacity change, handoff, candidate promotion, audit, verdict, correction, circuit, or decision] | [candidate ID/fingerprint, paths, checks, capacity, or result] |

## Next Actions And Blockers

- Next Actions: [None or up to three ordered actions]
- Blockers: [None or owner, condition, and required decision]
- Risks: [None or current accepted/residual risk and mitigation]
