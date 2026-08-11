# Overmind Work Package Template

Populate as `.overmind/{context-id}/WORK-PACKAGE-{context-id}-{assignment-id}-v{package-version}.md`.

Bind the package to one frozen Plan Revision and one semantically verifiable delegated-write boundary. Freeze it before acknowledgement.

Never change an acknowledged version. If its contract changes, retire it and create the next version. If the assignment boundary changes, create a new assignment at version 1.

The executor's first turn is read-only and returns exactly `READY`, `SPEC_GAP`, `NEEDS_SPLIT`, or `MISROUTED`.

- Context ID: `[context-id]`
- Assignment ID: `[assignment-id]`
- Assignment origin: `[initial|correction]`
- Predecessor assignment: `[assignment-id|N/A]`
- Finding IDs: `[stable IDs|N/A]`
- Package version: `[positive integer]`
- Plan revision: `[frozen positive integer]`
- Risk: `[Standard|High-Risk]`
- Base Candidate: `[Candidate ID and fingerprint]`
- Workspace topology: `[shared-live|isolated/forked|unknown]`
- Integration mode: `[audit-in-place|reconcile-intended-delta|serialized-until-known]`
- Status: `PackageReady`
- Owned scope: `[exact paths or symbols]`

## Deliverable

[One independently verifiable result and its dominant invariant.]

## Exact Touchpoints

| Path or symbol | Required change | Consumer or interface impact |
| --- | --- | --- |
| [path or symbol] | [closed change] | [impact or None] |

## Fixed Decisions And Required Behavior

1. [Required architecture, algorithm, or ordering.]
2. [Required failure, cleanup, recovery, or compatibility behavior.]
3. [Required evidence and integration behavior.]

- Starting state: [dependencies, current candidate, and assumptions]
- Negative paths: [triggers and required outcomes]
- Checkpoint: [High-Risk or plan-required vertical smoke, otherwise None]
- Handoff: return `DONE`, `INCOMPLETE`, or `BLOCKED` with exact runtime identity, actual base candidate, changed paths plus hunk or symbol provenance when a path is mixed, delta provenance, checks, observed divergence, preserved unrelated edits, and explicit gaps.

## Non-Scope

- [Excluded behavior, file, or refactor.]
- Preserve unrelated edits and do not change the goal, ledger, or this package.

## Validation

1. [Smallest relevant command or inspection and expected result.]
2. [Broader command or integration proof and expected result.]
3. [Independent evidence the root should request.]

## Stop Conditions

- Return `SPEC_GAP` before writing when a material behavior, invariant, boundary, or proof remains undecided.
- Return `NEEDS_SPLIT` when this scope cannot be implemented as one coherent boundary.
- Return `MISROUTED` when the selected agent lacks required capability, authority, or independence.
- Return `BLOCKED` during execution when an external condition prevents safe progress.
- Stop before writing or hand back when topology changes, ownership overlaps, or candidate drift affects the owned scope, dependencies, assumptions, or acceptance boundary. Ignore unrelated disjoint candidate changes unless they invalidate an explicit premise.

## Decision Budget

- Allowed: [observationally equivalent local tactics and style choices].
- Escalate: [choices that change behavior, architecture, scope, compatibility, risk, or evidence].
- Forbidden: replacement design, unrelated refactors, goal or ledger ownership, edits outside owned scope, replacing the cumulative candidate with an agent snapshot, or applying an isolated whole workspace instead of its intended delta.
