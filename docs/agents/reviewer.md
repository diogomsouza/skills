# reviewer

Reviewer independently assesses non-trivial code changes for correctness, regressions, contract compliance, compatibility, and concrete maintainability problems. It also examines error propagation, retries, cancellation, recovery, background work, resource cleanup, and whether reported outcomes match actual state.

It traces changed behavior through callers, configuration, persistence, and asynchronous boundaries, then challenges suspected defects against existing validation and recovery. Findings require a reachable trigger, an identifiable cause, a violated guarantee, and an actionable correction. Without an explicit scope, it reviews staged, unstaged, and untracked changes.

The configuration uses a read-only sandbox and forbids edits. The agent inspects existing tests and evidence; it does not create or recommend new tests. Existing checks may run only when permitted and possible without modifying files or external state.

Its verdict is `ACCEPT`, `REJECT`, or `BLOCKED`. Confirmed defects are classified from P0 to P3; suggestions and verification gaps are reported separately. Use it for substantive code review. Trivial edits and style-only review fall outside its intended use.

- [Agent configuration](../../codex/agents/reviewer.toml)
- [Security reviewer](code-reviewer-security.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
