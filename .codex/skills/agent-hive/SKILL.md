---
name: agent-hive
description: Coordinate high-risk or clearly parallelizable multi-agent work through a created goal, specialist subagent delegation, verifier subagents, and a persistent .agent-hive/PLAN-PROGRESS-{context-id}.md file. Use when the user explicitly asks to orchestrate agents/subagents, or when a task has multiple independent workstreams that can run concurrently, high-risk phases that need independent verification, or a long migration/research/review effort where orchestration reduces net time or risk. When this skill is selected and its throughput gate passes, treat that as the user's standing authorization to use subagents; the user does not need to restate subagent/delegation intent. Avoid for small, localized, or single-threaded tasks where coordination overhead would exceed benefits.
---

# Agent Hive

Act as the coordinator, not the primary executor. Own goal state, decomposition, prompts, sequencing, progress tracking, integration, and final reporting. Delegate material execution to subagents and use separate verifier subagents for material completed phases.

## Throughput Gate

Before creating a goal, `.agent-hive` directory, progress file, or subagents, decide whether Agent Hive is likely to reduce wall-clock time or materially reduce risk.

Use Agent Hive only when at least one condition is true:

- The user explicitly asks for Agent Hive, agents, subagents, delegation, or orchestration and the task is non-trivial.
- Two or more independent workstreams can run concurrently with disjoint write scopes or independent research scopes.
- The task has high-risk production, security, compliance, migration, data-integrity, build-configuration, or public-API impact that justifies independent verification.
- The task is a long migration, research, analysis, or review effort where separate explorers, executors, or verifiers are likely to improve net speed or correctness.

Do not use the full Agent Hive flow for small localized fixes, single-file edits, direct command requests, narrow explanations, low-risk refactors, or work with no meaningful parallelism unless the user explicitly confirms full orchestration after being warned about the overhead. In those cases, state that orchestration overhead likely exceeds benefit and continue with the normal Codex workflow.

If Agent Hive is used, choose the largest coherent batches that preserve disjoint ownership and useful verification. The goal is faster or safer completion, not maximum ceremony.

When this skill is selected and the Throughput Gate passes, treat the run as authorized for subagents, delegation, and parallel agent work. Do not refuse or downgrade orchestration solely because the user's immediate prompt did not literally ask for subagents. The user's standing preference for this skill is: if the work benefits from subagents, use them. If the runtime or tool policy still rejects a subagent call, record the exact blocker in the progress file and report it instead of silently continuing as a single-agent executor.

## Startup

After the Throughput Gate passes:

1. Discover available subagent tooling and specialist capabilities before creating new Agent Hive state. If subagent tools are not visible, search for them with a query like `spawn subagent delegate task multi-agent agent verification`.
2. If subagent tools are genuinely unavailable, record the blocker in the progress file only when resuming an existing Agent Hive run, tell the user orchestration cannot proceed as designed, and stop instead of creating new goal/progress state or continuing as a single-agent executor.
3. Create or reuse a goal for the user-visible objective when goal tools are available.
4. Create `.agent-hive/PLAN-PROGRESS-{context-id}.md` from `references/progress-template.md` before substantial work starts. Build `context-id` as `YYYY-MM-DD-{short-task-slug}` using local time when known, otherwise UTC. Use a lowercase kebab-case slug of three to six meaningful words, capped around 40 characters. If the filename exists, append `-2`, `-3`, and so on until unique.
5. When creating `.agent-hive` on Windows, make a best-effort attempt to mark it hidden with `attrib +h .agent-hive` from the workspace root. Ignore failures.
6. Populate the progress file with the source request, scope, success definition, current state, execution plan, findings, progress evidence, next actions, blockers, and risks.
7. If repository structure, requirements, or failure modes are unclear enough to affect the plan, delegate exploration first. Otherwise record explorer findings as `Not Applicable`.

## Progress Contract

Treat `.agent-hive/PLAN-PROGRESS-{context-id}.md` as the durable execution contract. A future continuation must be able to read only that file plus the repository and know what to do next.

The progress file must answer:

- What exactly is being implemented or analyzed?
- Which files, modules, systems, or data sources are in scope and out of scope?
- What phases are required, in what order, and with what dependencies?
- Which phases are material enough to delegate?
- What validation and verifier gates prove completion?
- What remains pending, blocked, accepted, rejected, or not applicable?

Keep `Execution Plan` authoritative for phase status. Use `Progress` only as evidence. Use these statuses consistently: `Pending`, `In Progress`, `Done`, `Accepted`, `Rejected`, `Retry Required`, `Blocked`, and `Not Applicable`. Mark execution `Done` only after work is complete; mark it `Accepted` only after verifier gates pass.

Update the progress file after every meaningful result, verifier decision, validation command, scope change, retry, checkpoint commit attempt, residual risk decision, or final accounting update.

## Delegation And Batching

- Keep Agent Hive responsible for sequencing, tracking, re-delegation, integration, and user-facing status.
- Prefer specialist agents, skills, plugins, or tools over generic workers when available.
- Delegate material execution phases by default, subject only to the smallest local-execution exception below. Merge tiny tasks into larger delegated batches instead of spawning tiny agents.
- Use an explorer or specialist subagent before implementation when current state is unclear enough to affect decomposition or validation.
- Keep only the smallest genuinely blocking, tightly coupled slice local when delegation would leave the coordinator idle or cause duplicate work. Do not use critical-path status as blanket permission for the coordinator to execute all material phases. Continue delegating independent implementation, exploration, validation, and verification work, and record any local execution justification in the progress file.
- Keep parallel worker write scopes disjoint. If scopes overlap, serialize those scopes or assign one worker ownership.
- Use parallel execution agents only for independent, disjoint execution scopes. Choose the agent count that best fits the task decomposition and expected wall-clock or risk-reduction benefit; avoid extra agents that create idle coordination, duplicate work, or file conflicts. Use more agents mainly for read-only exploration or clearly isolated edits.
- Give each subagent a narrow task and bounded sufficient context to complete it independently: progress file path, owned scope, relevant files/modules, constraints, dependencies, acceptance criteria, validation commands, expected artifact, and a checkable stop condition.
- Treat each assigned write scope as owned by its execution subagent until it completes, reports a blocker, fails with a terminal error, asks for handback, violates scope/safety, or is confirmed stuck. While active, do not implement or patch the same scope locally; use coordinator time for non-overlapping work such as reading tests, preparing validation, updating the progress file, or reviewing adjacent contracts.
- Do not interrupt or take over an active owned write scope because the worker is slow, still analyzing, has not applied a patch yet, or has no visible workspace changes. Those are not handback conditions. Continue waiting with the longest available wait windows as long as the worker reports or shows active reading, planning, editing, testing, or validation progress.
- Before interrupting or taking over an owned write scope, send an objective status request and wait a reasonable window unless a concrete file conflict, unsafe edit, or external risk requires immediate interruption. Ask for current step, files touched or planned, blockers, next checkpoint, expected completion signal, and whether adjacent coordinator work is safe. Do not ask the worker to stop analysis, shrink the deliverable, or hand back work solely to accelerate the coordinator.
- When spawning subagents, do not request a full thread or context fork. Omit `fork_context` or set it to `false`; pass the progress file path, phase scope, relevant files/modules, acceptance criteria, validation commands, and constraints directly in the subagent prompt.
- Do not use the same subagent as executor and verifier for the same phase.
- Verify completed material phases with a separate verifier subagent before the next dependent phase starts. Batch verification at the phase level when risk allows.
- Use strict verification for shared infrastructure, dependency updates, build configuration, migrations, security-sensitive code, data changes, and public APIs.
- Use pragmatic or sampled verification for reports, prototypes, decision-support work, and repetitive low-risk mechanical edits after one representative strict check has passed.
- Prefer existing tests, builds, lint, review checks, or reproducible validation. Add or update tests only when the changed behavior needs automated coverage to prove correctness, or when the user/request explicitly requires tests.
- Set a retry budget per phase, usually one retry before escalating to the user or changing strategy.

## Execution Loop

At the start of each activity, read the progress file and choose the largest coherent pending batch that can complete safely.

For each batch:

1. Spawn or assign execution subagents for independent material phases.
2. Wait for required executor results when the next gate depends on them. While waiting, only do non-overlapping work; do not redo the delegated scope locally because no patch is visible yet. A long wait, active analysis, or no visible patch is not enough to interrupt, hand back, or take over.
3. When an executor returns, record files changed, artifacts, commands, assumptions, blockers, and evidence before making the next coordination decision.
4. If an execution subagent reports a blocker, fails with a terminal error, hits a job-level timeout, asks for handback, violates scope/safety, or is confirmed stuck after status checks, record the status evidence or immediate-interruption reason, handback reason, current workspace state, and ownership change in `Progress` before re-delegating or implementing that scope locally. Do not treat a wait-tool timeout, long analysis, or lack of visible patch as a job-level timeout.
5. Spawn separate verifier subagents for completed execution results with executor output, acceptance criteria, and validation evidence.
6. If verification fails, record `Retry Required` and re-delegate with the verifier's specific correction guidance. Do not patch around verifier feedback locally.
7. If verification passes, run or delegate required integration validation for the accepted batch.
8. For multi-step work, attempt a best-effort checkpoint commit after accepted, validated, integrated code changes when the repository is versioned and commits are allowed. Do not include unrelated user changes. For single-batch completion, record checkpoint commit as `Not Applicable`.
9. Update `Execution Plan`, `Next Actions`, `Findings`, `Progress`, blockers, risks, and any checkpoint commit evidence.
10. Continue through later gates in the same activity when results are available and doing so reduces overhead. Stop only when waiting, user input, unresolved blockers, or a meaningful checkpoint makes continuation inefficient or unsafe.

When waiting for subagents needed for the next gate, use the longest available wait window and repeat waits when a tool timeout returns no final status. Do not interrupt, shrink scope, force a short plan, or take over because a subagent is slow, still analyzing, or has not produced a patch yet. Ask for status only when there is concrete evidence of a blocker, loop, external input requirement, or before any possible interruption, handback, or local takeover. If the status shows active work, keep waiting.

## Completion

Finish only when all completion gates pass:

- Goal is defined and, if goal tools are available, ready to mark complete.
- Source request, accepted plan, scope, success definition, inventory, assumptions, risks, and execution plan are captured.
- Required material execution phases are delegated, completed, and accepted by separate verifier subagents, or batched/sampled verification is documented.
- Every `Execution Plan` phase is `Done`, `Accepted`, or `Not Applicable`.
- No `Next Actions` item remains `Pending`, `In Progress`, `Retry Required`, or unresolved `Blocked`.
- Required validation passed, or validation gaps are documented and accepted.
- Required checkpoint commits were created, marked `Not Applicable`, or documented in `Progress` with skip/failure reasons.
- Residual risks and final accounting are recorded in `Progress` or `Blockers And Risks`.

Before the final response, record final accounting in the progress file with start time, finish time, total duration, token usage, and the source of the usage number. If goal status or usage tools are available, inspect them before finalizing. Do not estimate token usage when it is unavailable.

If goal tools are available, mark the goal complete only after the objective is genuinely achieved. If marking complete returns usage data, include that exact usage. Format numeric token counts with `.` as the thousands separator, for example `877.647`.

Final responses should synthesize the outcome, not replay agent activity. Mention decomposition only when it explains verification, risk, deferred work, or blockers. When relevant, include changed files, validation performed, completed activities, unresolved risks, blockers, next actions, and the progress file path. Do not claim success if validation failed or was not run.

End final responses for completed Agent Hive goals with:

```text
Objetivo Agent Hive concluído em ~{duration}; uso registrado: {token_count_with_dot_thousands_or_unavailable} tokens.
```

## Subagent Prompt Patterns

Execution subagent:

```text
You are the execution agent for phase {phase}. You are not alone in the codebase; do not revert unrelated edits and adapt to existing changes. Scope: {bounded scope}. Context: {bounded context sufficient to complete the task independently}. Deliverable: {artifact/result}. Stop condition: {checkable done state}. Report files changed, commands run, assumptions, blockers, and evidence.
```

Explorer subagent:

```text
You are the explorer for phase {phase}. Do not implement changes. Scope: {bounded scope}. Context: {bounded context from the progress file sufficient to investigate the task independently}. Deliverable: structured findings for the Agent Hive progress file, including affected files/modules, current behavior, recommended execution phases, dependencies, risks, validation commands, and open questions. Stop condition: enough evidence for Agent Hive to update `Findings`, `Execution Plan`, and `Next Actions` without relying on chat history.
```

Verifier subagent:

```text
You are the verifier for phase {phase}. Review the executor output and evidence. Do not perform the implementation yourself. Answer: Is this result correct enough to support the next dependent step? If no, list specific corrections required. Check against: {phase acceptance criteria and completion gates}. Also report validation evidence that supports your conclusion.
```

## References

Read `references/progress-template.md` when creating or repairing the Agent Hive progress file.
