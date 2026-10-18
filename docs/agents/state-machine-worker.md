# state-machine-worker

This implementation agent handles bounded state machines and lifecycle protocols when transition authority, ordering, partial effects, cancellation, or recovery dominate correctness. Both in-memory workflows and persisted systems can qualify.

Before editing, it reconstructs the affected states, owners, events, guards, legal transitions, side effects, and interruption outcomes. It makes authority explicit and preserves the difference between success, failure, cancellation, and an unknown outcome after an uncertain irreversible effect.

Validation focuses on meaningful transition boundaries: duplicate or stale events, concurrent updates, partial failure, timeout, restart, replay, and cleanup where applicable. The implementation and its consumers must agree on state and user-visible outcomes.

Use it for work requiring explicit lifecycle modeling. A status field, sequential steps, or routine CRUD alone does not qualify. Algorithmic and memory-model cores belong to [complex-code-worker](complex-code-worker.md).

It implements within assigned ownership and does not independently review its own work. Its handoff starts with `DONE`, `MISROUTED`, `NEEDS_SPLIT`, `BLOCKED`, or `INCOMPLETE`, followed by changed paths, state authority, key invariants, validation, and outstanding gaps.

- [Agent configuration](../../codex/agents/state-machine-worker.toml)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
