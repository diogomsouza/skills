# complex-code-worker

This implementation agent handles bounded technical cores whose correctness benefits from explicit invariants and specialized validation. Examples include algorithms, numerical methods, parsers, protocols, concurrency memory models, native code, and interoperability boundaries.

It establishes the relevant inputs, outputs, invariants, compatibility constraints, failure behavior, and resource or precision limits before editing. Validation is selected for the actual risk and can include authoritative vectors, differential comparison, property checks, fuzzing, benchmarks, or execution on the required platform.

Use it to implement the core itself. Merely calling a library, working in an unfamiliar technology, or handling a large task does not establish a need for this specialist. Lifecycle and recovery problems belong to [state-machine-worker](state-machine-worker.md). Small related adapters and consumers may remain within the assigned boundary.

It preserves concurrent work and does not provide independent review of its own implementation. Its handoff starts with `DONE`, `MISROUTED`, `NEEDS_SPLIT`, `BLOCKED`, or `INCOMPLETE`, followed by changed paths, rationale, invariants, validation, and remaining gaps.

- [Agent configuration](../../codex/agents/complex-code-worker.toml)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
