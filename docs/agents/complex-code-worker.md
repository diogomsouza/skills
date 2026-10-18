# Complex Code Worker

**Implement a bounded technical core with explicit invariants and validation suited to its failure modes.**

Complex Code Worker handles algorithms, numerical methods, parsers, protocols, memory-model problems, native code, and interoperability boundaries where ordinary application implementation is not enough to establish correctness.

The role is useful when the core requires reasoning about representations, precision, format semantics, complexity, or memory behavior. It implements that core and the small related adapters or consumers needed to deliver it within an assigned boundary.

## Identify why the specialist is needed

Before editing, the agent identifies the invariant or validation method that justifies specialization. A large task, an unfamiliar library, or high business impact alone does not establish that need.

| Suitable assignment | Why the role helps |
| --- | --- |
| Implement a bounded binary parser | Correctness depends on framing, lengths, malformed input, and resource limits |
| Implement a numerical routine | Units, error tolerances, convergence, rounding, and exceptional values affect the result |
| Implement a concurrent data structure | Ownership, memory ordering, interleavings, and progress guarantees must be established |
| Implement a native interoperability core | ABI, alignment, bounds, lifetimes, and platform behavior determine correctness |

Calling or configuring an established library usually does not require this role. Problems dominated by lifecycle transitions, retries, cancellation, or recovery belong to [State Machine Worker](state-machine-worker.md).

If the assignment does not justify specialization, the agent returns `MISROUTED` with a suggested role instead of inventing complexity to retain the task.

## Establish the working contract

The caller should provide the objective, exact ownership boundary, relevant requirements, consumers, and expected validation. The agent reads repository guidance and current sources, then records only the dimensions that apply:

- Inputs, outputs, invariants, and required determinism.
- Compatibility, format, protocol, or platform constraints.
- Failure behavior, cancellation, and partial-result semantics.
- Resource, precision, and performance limits.
- Evidence required to establish completion.

A sufficient supplied contract is reused. Missing implementation details are resolved from evidence where possible. A missing essential decision, dependency, or evidence source is reported as a blocker rather than silently guessed.

Ownership remains bounded. The agent preserves unrelated and concurrent changes and reports necessary work outside its assignment. Small coupled adapters can stay with the core; substantial independent work or another specialty may require a split before editing.

## Match implementation to the domain

For algorithms, the role establishes complexity, termination, and progress conditions. Boundary, degenerate, adversarial, and worst-case inputs matter when they can change correctness or resource behavior.

Numerical work makes units, domains, precision, rounding, overflow, non-finite values, and convergence explicit where applicable. Authoritative vectors or higher-precision references provide stronger evidence than agreement with the same implementation's calculations.

Parsers and protocols follow the authoritative grammar or wire format. The agent addresses framing, lengths, versions, endianness, trailing data, streaming, and expansion limits as required by the contract.

For concurrency and native code, it checks ownership, synchronization, linearization, memory ordering, lifetimes, bounds, alignment, architecture, ABI, and supported fallbacks. Validation should explore relevant interleavings or platform behavior rather than relying only on favorable timing.

Cryptographic work uses maintained libraries and authoritative constructions. The role does not invent primitives or protocols. Key lifetimes, nonce constraints, authentication, encodings, and invalid parameters must follow the actual requirements, and security-sensitive cryptographic changes require independent security review.

These are applicable obligations, not a demand to perform every technique for every assignment.

## Validate the core with independent evidence

Validation is chosen for the actual failure modes. Useful methods can include authoritative test vectors, differential comparison, property or metamorphic checks, fuzzing, bounded models, benchmarks, or real platform execution.

For example, a parser's successful round trip through its own serializer may miss a shared interpretation error. Independent conformance examples and malformed-input behavior can establish different properties.

The agent distinguishes implementation-authored checks from pre-existing, authoritative, independent, and workflow evidence. Performance claims require measurements relevant to the contract; an optimization must preserve the required result and behavior.

Before handoff, it inspects the full owned diff, challenges central invariants and worst-case behavior, and corrects confirmed in-scope issues. Self-audit remains separate from independent review.

## Interpret the handoff

| Status | Meaning |
| --- | --- |
| `DONE` | Assigned behavior and required validation are complete with no known in-scope gap |
| `MISROUTED` | Another role is appropriate; no files were changed |
| `NEEDS_SPLIT` | Substantial independent work or another specialty needs separate ownership; no files were changed |
| `BLOCKED` | A necessary decision, dependency, or evidence source prevents progress |
| `INCOMPLETE` | Behavior or validation remains unfinished and needs continuation |

The response identifies changed paths and consumers, design rationale, central invariants, validation sources and results, and outstanding limitations. Deferred in-scope obligations cannot be hidden behind `DONE`.

## Example assignment

```text
Implement the binary record decoder in the parser module.
Own the decoder and its small adapters; preserve the published record format.
Use the protocol specification and supplied conformance vectors.
Define bounds for malformed lengths and truncated records, and validate the
required behavior without changing unrelated transport code.
```

The role does not start its own orchestration or spawn descendants without explicit authorization. [Code Craft](../skills/code-craft.md) can coordinate the surrounding implementation and independent acceptance.

## Source and related guides

- [Agent configuration](../../codex/agents/complex-code-worker.toml) — eligibility, contracts, domain obligations, validation, and status meanings.
- [State Machine Worker](state-machine-worker.md) — lifecycle and recovery specialization.
- [Code Reviewer Security](code-reviewer-security.md) — independent assessment of security-sensitive changes.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->