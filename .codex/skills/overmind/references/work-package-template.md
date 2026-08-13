# Overmind Work Package Template

Populate as `.overmind/{context-id}/WORK-PACKAGE-{context-id}-{assignment-id}-v{package-version}.md`.

Bind the package to one frozen Plan Revision and one semantically verifiable delegated-write boundary. Freeze it before acknowledgement.

Never change an acknowledged version. If its contract changes, retire it and create the next version. If the assignment boundary changes, create a new assignment at version 1.

The executor's first turn is read-only and starts with exactly one status token: `READY`, `PLAN_IMPROVEMENT`, `SPEC_GAP`, `NEEDS_SPLIT`, or `MISROUTED`. `READY` has no detail payload and means the frozen contract and readiness projection are understood, the boundary is coherent, the role is capable, and the required evidence is feasible. Every other token must be followed by only the evidence and decision details required by the corresponding stop condition below.

- Context ID: `[context-id]`
- Assignment ID: `[assignment-id]`
- Assignment origin: `[initial|stable-scope correction|replacement correction]`
- Predecessor assignment: `[assignment-id|N/A]`
- Predecessor binding: `[binding-id|N/A]`
- Finding IDs: `[stable IDs|N/A]`
- Package version: `[positive integer]`
- Plan revision: `[frozen positive integer]`
- Risk: `[Standard|High-Risk]`
- Base Candidate: `[Candidate ID and fingerprint]`
- Workspace topology: `[shared-live|isolated/forked|unknown]`
- Integration mode: `[audit-in-place|reconcile-intended-delta|serialized-until-known]`
- Status: `PackageReady`
- Owned scope: `[exact semantic boundary and known paths or symbols]`
- Applicable readiness rows: `[Readiness IDs copied from the frozen plan]`

## Deliverable

[One independently verifiable result and its dominant invariant.]

## Known Touchpoints And Required Outcomes

| Path or symbol | Required outcome or constraint | Consumer or interface impact |
| --- | --- | --- |
| [known path or symbol] | [outcome, invariant, or non-negotiable change] | [impact or None] |

Known touchpoints are starting evidence, not an exhaustive recipe. The executor may discover and change additional touchpoints inside `Owned scope` when needed for the best contract-preserving implementation and must report them at handoff.

## Frozen Contract And Required Outcomes

1. [Externally observable behavior, invariant, or acceptance outcome.]
2. [Interface, compatibility, failure, cleanup, recovery, or risk constraint.]
3. [Non-negotiable architecture, algorithm, or ordering with reason, or `Delegated`.]

- Starting state: [dependencies, current candidate, and assumptions]
- Negative paths: [triggers and required outcomes]
- Checkpoint: [High-Risk or plan-required vertical smoke, otherwise None]
- Handoff: return `DONE`, `INCOMPLETE`, or `BLOCKED` with actual base candidate, changed paths plus hunk or symbol provenance when a path is mixed, delta provenance, checks, per-Readiness-ID dispositions and evidence, adversarial self-audit, observed divergence, preserved unrelated edits, and explicit gaps. Runtime identity comes only from authoritative runtime metadata; never persist executor self-report as identity authority.

## Verification Readiness Projection

These are preventive implementation and self-audit obligations derived from the complete anticipated verification portfolio. They do not disclose verifier conclusions and do not replace independent review. Copy every row applicable to this assignment exactly from the frozen plan; omit irrelevant contracts rather than copying generic checklists.

| Readiness ID | Implementation Subject | Verification Assignment / capability | Material risk or review dimension | Preventive implementation invariant | Negative or fault paths | Implementer evidence before `DONE` | Independent evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| [stable row ID] | [this package's implementation Assignment ID] | [verification Assignment ID / declared capability, not merely a role name] | [concrete applicable risk or broad-review dimension] | [condition the implementation must preserve] | [adversarial, boundary, partial-failure, cancellation, recovery, or regression paths] | [inspection, test, fault injection, analysis, or trace] | [fresh review or independently reproduced proof] |

Challenge the package before acknowledging it. Return `SPEC_GAP` when an applicable criterion is missing or undecided, `NEEDS_SPLIT` when these rows do not form one coherent acceptance boundary, and `MISROUTED` when the selected implementation capability cannot materially satisfy them.

## Executor Mandate

Inspect the relevant implementation, consumers, neighboring patterns, and available validation before choosing an approach. Use independent judgment to deliver the strongest maintainable result inside the frozen contract; do not merely translate the known touchpoints literally. Choose local design, algorithm, structure, controls, style, naming, error handling, and supporting changes as the work requires. Prefer established project patterns, but improve them locally when doing so is in scope and evidence-backed.

## Non-Scope

- [Excluded behavior, file, or refactor.]
- Preserve unrelated edits and do not change the goal, ledger, or this package.

## Validation

1. [Smallest relevant command or inspection and expected result.]
2. [Broader command or integration proof and expected result.]
3. [Per-Readiness-ID executor evidence and the independent evidence the root should request.]

## Stop Conditions

- Return `PLAN_IMPROVEMENT` before the affected change when a materially better result requires exceeding the current decision budget or when a discovered risk or proposed local design changes the applicable verification capability, criterion, fault path, or evidence expectation. State the current limitation, proposal, benefit, contract and scope impact, risks, and validation; do not edit until root disposition.
- Return `SPEC_GAP` before writing when a material behavior, invariant, boundary, or proof remains undecided.
- Return `NEEDS_SPLIT` when this scope cannot be implemented as one coherent boundary.
- Return `MISROUTED` when the selected agent lacks required capability, authority, or independence.
- Return `BLOCKED` during execution when an external condition prevents safe progress.
- Stop before writing or hand back when topology changes, ownership overlaps, or candidate drift affects the owned scope, dependencies, assumptions, or acceptance boundary. Ignore unrelated disjoint candidate changes unless they invalidate an explicit premise.

## Decision Budget

- Allowed without approval: choose and implement the best local design, algorithm, structure, controls, style, naming, error handling, tests, and supporting changes inside `Owned scope` when they preserve the requested outcome, frozen invariants, interfaces, compatibility, risk posture, non-scope, and acceptance evidence. Report material choices and rationale at handoff.
- Escalate with `PLAN_IMPROVEMENT`: a beneficial change to a frozen constraint, externally observable behavior, interface, compatibility promise, risk posture, acceptance boundary, verification portfolio or readiness projection, evidence contract, or owned scope that is not required merely to resolve an ambiguity.
- Use `SPEC_GAP` instead when safe implementation cannot proceed without a missing decision. Use `NEEDS_SPLIT` when the acceptance boundary itself is not coherent.
- Forbidden: silently expand the user's request, change a frozen contract, perform unrelated refactors, take goal or ledger ownership, edit outside owned scope, replace the cumulative candidate with an agent snapshot, or apply an isolated whole workspace instead of its intended delta.

## Self-Audit Before DONE

Inspect the complete owned diff and challenge it against every acceptance item, every applicable Readiness ID, relevant negative and partial-failure path, consumers, integration behavior, maintainability, consistency with project conventions, and unintended regressions. For each Readiness ID, report `Satisfied` or `Gap`; include the concrete proof and distinguish pre-existing checks, checks authored with the change, independently reproduced evidence, and unavailable evidence. Do not override a frozen row as `Not Applicable`: if its applicability premise changed, stop for root disposition and a new package version. Do not leave an in-scope obligation for a verifier to discover later. Return `DONE` only when every applicable row is satisfied and no known in-scope gap remains; otherwise return `INCOMPLETE` or `BLOCKED`.
