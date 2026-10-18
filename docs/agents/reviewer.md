# Reviewer

**Assess whether a substantive code change fulfills its contract and preserves the behavior around it.**

Reviewer is an independent, read-only agent for non-trivial code changes. It examines correctness, regressions, compatibility, failure handling, and concrete maintainability concerns, using the requirements, implementation, consumers, and available evidence.

The role looks beyond whether the new path works once. It traces what happens when inputs are missing, operations are repeated, responses arrive late, cancellation interrupts work, or a dependency fails after a partial effect.

## Give the review a clear boundary

Supply the objective, candidate change, applicable requirements, and relevant validation results. These establish what the agent must assess and what behavior must remain compatible.

Without an explicit scope, the configuration directs the agent to review all staged, unstaged, and untracked changes. It reads applicable repository guidance and follows relevant consumers outside the diff when needed to understand the changed behavior.

The review covers defects introduced or worsened by the candidate and required behavior omitted from the implementation. It can inspect existing code to establish a cause or protection, but unrelated technical debt does not become an automatic correction request.

## Follow behavior through the system

The agent traces inputs through validation, state changes, side effects, and responses. It checks that guards run before protected effects and that the reported result matches actual state.

| Area | Questions the review investigates |
| --- | --- |
| Compatibility | Do changed defaults, APIs, serialization, migrations, or configuration break established consumers? |
| Failure handling | Are errors ignored, masked, misclassified, or converted into misleading success? |
| Retries and cancellation | Can repetition duplicate effects, or can cancellation conceal an uncertain completed operation? |
| Concurrency | Can stale reads, competing mutations, or ownership errors violate the contract? |
| Background work | Are failures observed, results accurate, and resources released? |
| Recovery and cleanup | Do rollback, compensation, or cleanup preserve the promised outcome and original failure? |
| Performance | Is there a concrete workload and causal path supporting a regression? |

For example, a method may return cancellation while a remote write has already succeeded. The relevant question is whether its contract preserves and exposes that uncertain outcome, not merely whether a cancellation exception was caught.

Suspected defects are challenged against upstream validation, downstream recovery, framework guarantees, and intentional behavior. A catch, fallback, or optional access is not inherently wrong, and duplicate logging is not a default requirement.

## Use evidence without changing the candidate

The [configuration](../../codex/agents/reviewer.toml) selects a read-only sandbox and forbids edits. Reviewer establishes conclusions independently rather than accepting the implementer's explanation as proof.

It inspects existing tests for stale expectations, ineffective assertions, mocks that bypass the real behavior, and weakened checks. It does not create or recommend new tests. Existing checks may run only when permitted, useful to resolve a concrete concern, and possible without modifying files or external state.

The handoff distinguishes static reasoning, supplied results, and checks actually executed. Passing tests support the assessment but do not establish correctness by themselves. A defect can also be established from code without reproducing it at runtime.

## Understand findings and verdicts

A confirmed defect needs a reachable trigger, violated behavior, identifiable cause and location, consequence, and focused correction. The agent deduplicates findings by root cause.

Severity ranges from P0 for immediate or widespread severe failure through P3 for a real error with a small consequence. Severity depends on reach, trigger conditions, recoverability, and workarounds. Every confirmed in-scope defect causes rejection, including low-impact defects.

| Verdict | Meaning |
| --- | --- |
| `ACCEPT` | Required review obligations are established and no in-scope defect is confirmed |
| `REJECT` | At least one confirmed in-scope defect exists |
| `BLOCKED` | No defect is confirmed, but a missing prerequisite prevents a required review obligation from being established |

A confirmed defect takes precedence over a simultaneous evidence gap; the response reports both. Optional improvements are labeled `SUGGESTION`. Unresolved hypotheses identify the concrete scenario, evidence, and missing confirmation instead of being presented as defects.

## Example assignment

The following is an illustrative delegated assignment:

```text
Review the current changes to the import retry flow.
Check the requirement that a retried accepted batch cannot create duplicate records,
and that cancellation preserves any already committed outcome.
Inspect the existing validation results and relevant consumers.
Remain read-only and report confirmed defects separately from missing evidence.
```

The result begins with its verdict, then describes scope, findings, suggestions when applicable, and pending verification. Corrections belong to the implementing task.

## Choose the appropriate review role

Use Reviewer for substantive functional and contract review. Use [Code Reviewer Security](code-reviewer-security.md) for security guarantees and [Document Reviewer](document-reviewer.md) for saved prose, specifications, and guides.

For a maintainability or dead-code audit that may include authorized cleanup, [Code Quality Review](../skills/code-quality-review.md) provides the broader skill workflow. Trivial edits and style-only assessment do not require this agent.

## Source and related guides

- [Agent configuration](../../codex/agents/reviewer.toml) — review scope, investigation, evidence, and verdict rules.
- [Code Craft](../skills/code-craft.md) — coordination and acceptance of implementation work.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->