---
name: astra-forge
description: >-
  Coordinate complex or long-running work with bounded delegation, resumable state, staged verification, and phase commits. Use when parallel work or independent
  assurance materially helps; avoid simple tasks. Implicit use requires a runtime-confirmed gpt-6-astra root; other models require explicit invocation.
---

# Astra Forge

Select verification obligations before implementation, delegate bounded work, and accept each phase against evidence for the delivered candidate.

Reviewing or editing this skill does not activate its workflow. User instructions take precedence over this skill within system, developer, tool, and environment
constraints. Use one orchestration workflow and a ledger dedicated to the current run.

## Admission

Explicit invocation admits the run. Otherwise require a runtime-confirmed `gpt-6-astra` root or confirmed alias and at least one of:

- material risk that benefits from independent assurance;
- independent workstreams that save time or improve evidence;
- work whose duration or coordination needs justify durable resume state.

If admission fails, work directly without Astra Forge artifacts. Do not infer model identity from the task, model names in files, or agent self-report.

## Operating Rules

- A matching runtime goal is mandatory. If its lifecycle is unavailable, unauthorized, or fails, stop the managed run; a ledger cannot substitute for it.
- Root owns product decisions, architecture, scope, assignment contracts, integration, acceptance, goal lifecycle, and the ledger. Implementers choose technical details,
  diagnose failures, and correct their work within those boundaries. Return to root when a discovery requires changing the contract, shared architecture, or ownership.
  Independent reviewers judge evidence within their contracts; root decides the response to findings and cannot prescribe a favorable verdict.
- Root may apply a small correction under the [direct-correction exception](references/verification.md#direct-root-correction) when another delegation round would cost
  more than the known fix.
- Resolve routine technical choices from evidence. Ask only for a missing decision that cannot reasonably be inferred and materially affects scope, correctness, or
  authority. Continue independent authorized work while optional questions are pending.
- Delegate bounded work under the [model-routing policy](references/delegation.md#mandatory-model-routing). Use disjoint ownership for concurrent writes; capacity is a
  ceiling.
- Never use `full-history` or `fork_turns="all"`. Independent verifiers receive no inherited conversation; other agents receive only bounded task context.
- Create new tests only when explicitly required by the user or authoritative project requirements, or exceptionally when indispensable to complete the task. For the
  exception, root must record the exact obligation and why existing checks or another concrete validation method cannot establish it. Convenience, coverage targets, and
  reviewer preference do not qualify. Pass this decision in the assignment contract.
- Close every phase under the [commit protocol](references/lifecycle.md#mandatory-phase-commit): commit its task-owned changes before dependent work; skip only when there
  are no changes or no Git repository.
- Treat user updates as steering of the active objective unless they replace it. Reconcile affected requirements, contracts, ownership, and evidence before dependent
  work. Async operations remain pending until their results arrive.
- Keep reports concise: outcome, material evidence, unresolved limitations, and next action. Do not replay coordination history.

## Read On Demand

Read the applicable reference before its first use, and reread it after context loss or a relevant rule change. Do not preload every reference.

| Action | Required reference |
| --- | --- |
| Start, resume, discover, or revise phases | [Planning](references/planning.md) |
| Initialize or update durable state | [Progress template](references/progress-template.md) |
| Select agents or prepare implementation obligations | [Delegation](references/delegation.md) |
| Integrate, review, or correct a candidate | [Verification](references/verification.md) |
| Transition, commit, close a phase, or finish | [Lifecycle](references/lifecycle.md) |

When composing an assignment, also read its single prompt pattern: [exploration](references/exploration-assignment-prompt.md),
[command execution](references/command-assignment-prompt.md), [implementation](references/implementation-assignment-prompt.md), or
[independent verification](references/independent-verification-assignment-prompt.md).
