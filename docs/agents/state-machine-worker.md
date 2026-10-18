# State Machine Worker

**Make lifecycle transitions, interruption outcomes, and recovery behavior explicit.**

State Machine Worker implements bounded workflows whose correctness depends on who may change state, when effects occur, and what happens if execution stops between them.

The role applies to persisted and in-memory systems, including linear workflows. The defining difficulty is the transition contract: ordering, partial effects, cancellation, retries, concurrency, or recovery must be modeled carefully enough to preserve the required guarantees.

## Recognize an appropriate assignment

An operation with a status field is not automatically a state-machine problem. Routine CRUD, schema edits, and mechanical changes normally do not need this specialist.

The role becomes useful when an observable outcome depends on distinctions that ordinary sequential code can obscure. Examples include cancellation after a remote effect, retry after an uncertain commit, ownership transfer between workers, or recovery when only one persisted candidate remains valid.

Before editing, the agent identifies the transition invariant or interruption outcome that makes specialization useful. If that basis is missing, it returns `MISROUTED` and recommends another role.

Algorithmic and memory-model problems belong to [Complex Code Worker](complex-code-worker.md), even when they also involve concurrency.

## Reconstruct the transition contract

The caller supplies the requested behavior, ownership boundary, applicable sources, and validation requirements. The agent verifies any supplied model against current code and consumers, then records applicable dimensions.

| Dimension | What must be understood |
| --- | --- |
| State and authority | States, authoritative owners, events, guards, and legal or forbidden transitions |
| Effects | Points where mutation, publication, or durability changes the possible outcome |
| Interruption | Success, partial failure, timeout, cancellation, and externally visible status |
| Recovery | Retry, replay, idempotency, rollback, restart, and uncertain outcomes |
| Resources | Ownership, cleanup, synchronization, and stale-state handling |
| Compatibility | Consumers, serialization, preserved guarantees, and required evidence |

An in-memory workflow does not need persistence merely to fit a template. Unchanged behavior does not need to be restated for every transition. The model focuses on distinctions that affect the assigned contract.

A material conflict is raised before behavior changes. Essential missing decisions or dependencies remain blockers rather than being resolved through invented semantics.

## Implement around authority and observable outcomes

The agent makes state authority explicit and prevents competing transition decisions. Explicit states are useful when they eliminate invalid combinations; they are not an excuse for unrelated architectural changes.

Separating transition decisions from effects can clarify ordering and recovery. It must not hide an unresolved question behind a new abstraction.

For example, after a remote write may have succeeded, local cancellation cannot automatically mean that nothing happened. The implementation needs to preserve the appropriate completed, failed, or unknown outcome and provide the recovery behavior required by its contract.

Synchronization is justified by the invariant being protected. Locks require attention to blocking and reentrancy; leases require handling expiration and stale holders; transactions require the promised atomicity and uncertain-commit behavior. Protection should not expand across unrelated work without a reason.

Snapshots are revalidated before commit or publication when concurrent changes could invalidate them. Cleanup is safe to repeat where retries can invoke it again, and cleanup failures that affect final state remain visible.

## Keep consumers aligned with the model

The task may include small related machines, adapters, consumers, serialization, and status reporting when they form one coherent delivery.

The agent preserves unrelated and concurrent edits. It reports required changes outside its ownership to the coordinating task. Substantial independent work or another specialty can justify `NEEDS_SPLIT` before editing, but tightly coupled behavior is not split merely because some routine code can be separated.

The complete owned diff is checked for agreement between transition behavior and what consumers observe. A correct internal state machine is insufficient if the public response reports the wrong outcome.

## Verify meaningful interruption points

Checks follow distinct outcomes in the contract. Relevant boundaries include guard validation, mutation, publication, durability, acknowledgement, and cleanup.

The role considers duplicate, stale, reordered, or concurrent events, partial resource failures, timeout, cancellation, restart, and replay when they can change the result. Recovery from persisted candidates may also require checking corrupt or divergent copies and preservation of the sole valid copy.

Evidence can come from deterministic tests, reference models, fault injection, or actual workflow execution, proportional to the risk. The handoff separates implementation-authored checks, existing or independent evidence, reasoning, and unavailable execution.

## Interpret the handoff

| Status | Meaning |
| --- | --- |
| `DONE` | Assigned transitions and required validation are complete |
| `MISROUTED` | Specialization is unjustified; no files changed |
| `NEEDS_SPLIT` | Independent work or another specialty requires separate ownership; no files changed |
| `BLOCKED` | A necessary decision, dependency, or evidence source is missing |
| `INCOMPLETE` | In-scope behavior or validation remains unfinished |

The result identifies changed paths and consumers, state authority, key invariants, validation, assumptions, and gaps. Self-audit does not replace independent review, and unfinished obligations prevent a `DONE` result.

## Example assignment

```text
Implement cancellation and restart recovery for the import operation.
Own its lifecycle coordinator and status mapping.
Preserve committed records, distinguish uncertain completion from clean cancellation,
and validate interruptions around commit and acknowledgement.
Bring contract conflicts back before changing the agreed behavior.
```

The role does not spawn descendants or start orchestration without explicit authorization. [Code Craft](../skills/code-craft.md) can coordinate related implementation and review.

## Source and related guides

- [Agent configuration](../../codex/agents/state-machine-worker.toml) — transition contract, implementation rules, and validation.
- [Reviewer](reviewer.md) — independent correctness assessment.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->