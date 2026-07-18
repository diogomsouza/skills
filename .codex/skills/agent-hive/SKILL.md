---
name: agent-hive
description: Coordinate high-risk or clearly parallelizable multi-agent work through a verifiable goal, native subagent roles, risk-based independent verification, and a persistent resumable .agent-hive/PLAN-PROGRESS-{context-id}.md file. Use when the user explicitly asks to orchestrate agents/subagents, or when a task has multiple independent workstreams that can run concurrently, high-risk phases that benefit from independent verification, or a long migration/research/review effort where orchestration reduces net time or risk. When this skill is selected and its throughput gate passes, treat that as the user's standing authorization to use subagents; the user does not need to restate subagent/delegation intent. Avoid for small, localized, or single-threaded tasks where coordination overhead would exceed benefits.
---

# Agent Hive

Act as the coordinator and critical-path owner. Own goal state, decomposition, prompts, sequencing, progress tracking, integration, and final reporting. Execute only an immediate, tightly coupled blocking slice locally; delegate independent material work to subagents. Use separate verification agents only when an identified risk justifies independent review.

## Throughput Gate

Before creating a goal, `.agent-hive` directory, progress file, or subagents, decide whether Agent Hive is likely to reduce wall-clock time or materially reduce risk after accounting for token use, agent capacity, coordination, and integration cost.

Use Agent Hive only when at least one condition is true:

- The user explicitly asks for Agent Hive, agents, subagents, delegation, or orchestration and the task is non-trivial.
- Two or more independent workstreams can run concurrently with disjoint write scopes or independent research scopes.
- The task has high-risk production, security, compliance, migration, data-integrity, build-configuration, or public-API impact that justifies independent verification.
- The task is a long migration, research, analysis, or review effort where separate explorers, executors, or verifiers are likely to improve net speed or correctness.

Do not use the full Agent Hive flow for small localized fixes, single-file edits, direct command requests, narrow explanations, low-risk refactors, or work with no meaningful parallelism unless the user explicitly confirms full orchestration after being warned about the overhead. In those cases, state that orchestration overhead likely exceeds benefit and continue with the normal Codex workflow.

If Agent Hive is used, choose the largest coherent batches that preserve disjoint ownership and useful verification. Treat configured thread capacity as a ceiling, not a target. The goal is faster or safer completion, not maximum fan-out.

Every run that passes this gate uses a goal and the resumable progress file described below. Do not downgrade those durable controls because the work may finish in one activity.

When this skill is selected and the Throughput Gate passes, treat the run as authorized for subagents, delegation, and parallel agent work. Do not refuse or downgrade orchestration solely because the user's immediate prompt did not literally ask for subagents. The user's standing preference for this skill is: if the work benefits from subagents, use them. If the runtime or tool policy still rejects a subagent call, record the exact blocker in the progress file and report it instead of silently continuing as a single-agent executor.

## Startup

After the Throughput Gate passes:

1. Search `.agent-hive/PLAN-PROGRESS-*.md` for an in-progress file matching the current request or active goal. If one unambiguously matches, read it before making goal, ownership, or sequencing decisions. If multiple files plausibly match, ask the user which run to resume.
2. Confirm required tooling once: goal tools plus native subagent roles. Prefer `worker` for edits, `explorer` for read-heavy codebase questions, and an appropriate read-only specialist for targeted verification. If tools are not visible, search for them once.
3. If goal or subagent tooling is genuinely unavailable, record the exact blocker only when an existing matching progress file was found, tell the user Agent Hive cannot proceed as designed, and stop without creating partial goal/progress state or continuing as a single-agent executor.
4. Check active goal state. Reuse an active goal that matches the user-visible objective. If an active goal conflicts with the request, do not replace it silently; ask the user to resolve the conflict.
5. If no matching active goal exists, apply the Goal Definition Gate:
   - Evaluate available task context and artifacts by their content, regardless of how or where they were created.
   - Treat the basis as sufficient when it defines the concrete outcome, material scope boundaries and constraints, completion evidence or acceptance criteria, and conditions that require user input.
   - If the basis is sufficient, perform only a bounded freshness and consistency check. Do not repeat prior analysis, reopen accepted decisions, or rediscover the complete implementation scope.
   - If the basis is incomplete, fill only missing technical facts through bounded coordinator-local read-only inspection. Do not perform full decomposition, broad research, implementation, or execution-agent work before creating the goal.
   - If a missing product, scope, or acceptance decision could materially change the outcome, ask the user instead of inventing it.
   - Create the goal only after it states a concrete outcome, material boundaries, completion evidence, and relevant stop conditions. Keep phases, agent assignments, transient findings, and detailed execution state in the progress file.
6. Reuse the matching progress file when one exists. Otherwise create `.agent-hive/PLAN-PROGRESS-{context-id}.md` from `references/progress-template.md` before substantial work starts. Build `context-id` as `YYYY-MM-DD-{short-task-slug}` using local time when known, otherwise UTC. Use a lowercase kebab-case slug of three to six meaningful words, capped around 40 characters. For a new run only, append `-2`, `-3`, and so on if the filename exists.
7. When creating `.agent-hive` on Windows, make a best-effort attempt to mark it hidden with `attrib +h .agent-hive` from the workspace root. Ignore failures.
8. Populate or refresh the progress file according to the template. Include active agent IDs and owned scopes so a continuation can resume, wait, steer, or close them.
9. If repository structure, requirements, or failure modes remain unclear enough to affect the plan, delegate exploration first and record only durable plan-changing findings in `Current State`.

## Progress Contract

Treat `.agent-hive/PLAN-PROGRESS-{context-id}.md` as the durable execution contract. A future continuation must be able to read only that file plus the repository and know what to do next.

Preserve the template structure exactly: one document `#` heading followed by exactly the six required `##` sections, once each and in template order. Do not add any other headings at any level; use bullets and table rows inside the required sections instead.

The progress file must answer:

- What exactly is being implemented or analyzed?
- Which files, modules, systems, or data sources are in scope and out of scope?
- What phases are required, in what order, and with what dependencies?
- Which phases are material enough to delegate?
- What validation and acceptance gates prove completion, and which risks require an independent verifier?
- What remains pending, in progress, done but awaiting acceptance, accepted, blocked, or not applicable?

Keep `Execution Plan` authoritative for phase status and `Current State` authoritative for the resumable snapshot. Use `Progress Log` for durable checkpoint evidence and decisions, never as the source of current status. Use these statuses consistently: `Pending`, `In Progress`, `Done`, `Accepted`, `Blocked`, and `Not Applicable`. Mark execution `Done` only after work is complete; mark it `Accepted` only after its `Done When` criteria and required independent-verifier or coordinator acceptance gate pass. After failed acceptance, return the phase to `Pending` or `In Progress` and record the reason in `Progress Log`.

Route information instead of creating new sections: keep only current resumable facts and active ownership in `Current State`; keep phase scope, status, dependencies, and completion gates in `Execution Plan`; summarize each material exploration result, worker result, verifier decision, retry, commit, runtime result, acceptance, or supersession as a concise `Progress Log` row; keep only immediate work in `Next Actions`; and keep only unresolved or accepted risks in `Blockers And Risks`. Do not paste a subagent report verbatim or duplicate the same item as current, historical, accepted, and follow-up records. Reference commits, files, or evidence artifacts from the log when full detail already exists outside the progress file.

In `Execution Plan`, keep `Phase` as a short stable identifier, keep `Status` immediately after it, and put the descriptive title in the separate `Scope` column. Do not combine phase and scope; this order keeps status values visually aligned and scannable in long plans.

Update the progress file after every meaningful phase transition, agent result, ownership change, verifier decision, validation result, scope change, retry decision, requested checkpoint commit, blocker/risk change, or reliable final-accounting update. Keep only the next one to three concrete actions in `Next Actions`; do not copy raw command output or routine narration.

## Delegation And Batching

- Keep Agent Hive responsible for goal state, sequencing, tracking, re-delegation, integration, agent lifecycle, and user-facing status.
- Prefer native `worker`, `explorer`, and specialist roles, then applicable skills, plugins, or tools, over a generic agent.
- Before delegating, identify the one immediate action that is both tightly coupled and blocking the coordinator's next step. Keep only that slice local. Delegate independent material implementation, exploration, validation, and verification sidecars. Do not label an entire phase or feature "critical path" to justify local execution; record the local slice and reason in the progress file.
- Merge tiny tasks into coherent delegated batches. Start with read-heavy parallelism when it can clarify decomposition, tests, logs, or risks without creating write conflicts.
- Keep parallel worker write scopes disjoint. If scopes overlap, serialize them or give one worker ownership. Keep delegation flat unless recursive delegation has a specific benefit and configured depth permits it.
- Choose the agent count that best fits the independent task decomposition and expected wall-clock or risk-reduction benefit. Avoid agents that create idle coordination, duplicate work, merge pressure, or token cost without a concrete return.
- Give each subagent a narrow task and bounded sufficient context to complete it independently: progress file path, owned scope, relevant files/modules, constraints, dependencies, acceptance criteria, validation commands, expected artifact, and a checkable stop condition.
- Assume coding workers edit in forked workspaces and return uploaded changes. Lack of a visible patch in the coordinator workspace is expected while they run; review returned changes before integration.
- Treat each assigned write scope as owned by its worker until it completes, reports a blocker, fails terminally, asks for handback, violates scope or safety, or is confirmed stuck. While ownership is active, do not implement or patch the same scope locally.
- Do not interrupt or take over an active owned scope because the worker is slow, still analyzing, or has not produced a visible patch. Use coordinator time for non-overlapping work. Before any non-emergency handback or takeover, request objective status; if it shows active reasoning, an active command, or new evidence, preserve ownership and continue waiting without a coordinator-imposed time limit.
- Treat a worker as confirmed stuck only when it reports that it cannot proceed, enters a terminal error state, or repeated objective status checks show no active operation and no new action or evidence after a direct request to continue. Time alone never confirms that a worker is stuck.
- Treat a job-level timeout as terminal only when the worker or tool reports it, or when an explicit user, task, or worker-contract deadline expires with no active operation or forward progress. A coordinator wait timeout is never a job-level timeout.
- Prefer an explicit bounded prompt. Use `fork_context` only when supported and when material thread history cannot be summarized safely; do not rely on a context fork as a substitute for the progress path, owned scope, acceptance criteria, validation, and stop condition.
- Decide independent verification from concrete risk, not phase size alone. Use a separate worker or read-only specialist when the result affects security, migrations, data integrity, shared infrastructure, dependency/build configuration, public APIs, subtle state or concurrency, failure handling, or another identified risk that independent review is likely to catch.
- Run independent verification in parallel with non-dependent work when possible. Serialize it before a dependent phase only when proceeding without the verdict would be unsafe. For ordinary low-risk phases, existing tests, builds, lint, reproducible checks, and coordinator review may provide the acceptance gate.
- When independent verification is required, do not use the executor as verifier. Use strict verification for high-risk surfaces and pragmatic or sampled verification for reports, prototypes, decision-support work, and repetitive low-risk edits after one representative strict check passes.
- Add or update tests only when changed behavior needs automated coverage to prove correctness or the request explicitly requires tests.
- Set a retry budget per phase, usually one retry before escalating or changing strategy.

## Execution Loop

At the start of each activity, read the progress file and choose the largest coherent pending batch that can complete safely.

For each batch:

1. Begin the coordinator-local blocking slice identified under `Delegation And Batching`, if one exists. Spawn workers or explorers for independent material sidecars in the same round.
2. While subagents run, perform meaningful non-overlapping work. Do not redo an owned scope locally.
3. Call the wait tool only at a dependency barrier where the next critical action requires a subagent result and no productive non-overlapping work remains. Use a long wait window at that barrier. A wait timeout, long analysis, or lack of a visible coordinator-workspace patch is not a job-level timeout and is not a takeover condition; if the dependency still blocks progress and the worker remains active, continue waiting.
4. When an executor returns, review its uploaded changes and record files changed, artifacts, commands, assumptions, blockers, and evidence before integration.
5. If a worker meets a terminal handback condition defined under `Delegation And Batching`, record the evidence, handback reason, returned workspace state, and ownership change in `Progress Log` before re-delegating or executing that scope locally.
6. Apply the phase's recorded acceptance gate. Spawn an independent verification specialist only when the recorded risk requires one; otherwise use coordinator acceptance backed by existing validation.
7. If verification fails, return the phase to `Pending` or `In Progress`, record the reason in `Progress Log`, and assign material corrections to the executor or another worker. The coordinator may make only a small immediate integration correction after worker ownership has ended, and must record why local execution is appropriate.
8. Run or delegate required integration validation for the accepted batch.
9. Close completed, failed, cancelled, or abandoned agents after their results and evidence are integrated so they do not consume thread capacity.
10. Create checkpoint commits only when the user requested them or applicable project instructions require them. Never include unrelated user changes.
11. Update `Current State`, `Execution Plan`, `Progress Log`, `Next Actions`, blockers, risks, agent lifecycle, and any requested checkpoint evidence.
12. Continue through later gates in the same activity when results are available and doing so reduces overhead. Stop only when waiting, user input, unresolved blockers, or a meaningful checkpoint makes continuation inefficient or unsafe.

Do not poll or wait by reflex. Ask for status only when there is evidence of a blocker, loop, external-input requirement, or a possible terminal handback condition. Apply the ownership and takeover criteria from `Delegation And Batching`.

## Completion

Finish only when all completion gates pass:

- Goal is defined and ready to mark complete.
- Source request, objective, scope, success definition, inventory, assumptions, risks, and current execution plan are captured.
- Required material phases are completed and accepted through their recorded coordinator or independent-verifier acceptance gates; independent work was delegated when it provided real time or risk benefit.
- Every `Execution Plan` phase is `Accepted` or `Not Applicable`; `Done` still awaits acceptance and cannot satisfy completion.
- `Next Actions` is `None`.
- Required validation passed, or validation gaps are documented and accepted.
- Any user-requested or project-required checkpoint commits were created or documented with skip/failure reasons.
- Residual risks and any reliable final accounting are recorded in `Progress Log` or `Blockers And Risks`.
- Completed or abandoned subagents are closed after their results are integrated.

Mark the goal complete only after the objective is genuinely achieved. Record final accounting in the progress file when reliable timing or usage data is available; do not estimate unavailable values.

Final responses should synthesize the outcome, not replay agent activity. Mention decomposition only when it explains verification, risk, deferred work, or blockers. When relevant, include changed files, validation performed, completed activities, unresolved risks, blockers, next actions, and the progress file path. Do not claim success if validation failed or was not run.

## Subagent Prompt Patterns

Execution subagent:

```text
You are the worker for phase {phase}. You are not alone in the codebase; do not revert unrelated edits and adapt to existing changes. Owned scope: {bounded write scope}. Context: {bounded context sufficient to complete the task independently}. Deliverable: {artifact/result}. Acceptance: {criteria and validation}. Stop condition: {checkable done state}. Edit in your forked workspace and report files changed, commands run, assumptions, blockers, and evidence.
```

Explorer subagent:

```text
You are the explorer for phase {phase}. Do not implement changes. Scope: {bounded scope}. Context: {bounded context from the progress file sufficient to investigate the task independently}. Deliverable: structured findings for the Agent Hive progress file, including affected files/modules, current behavior, dependencies, risks, validation commands, open questions, and only evidence-backed changes required to the existing plan. Stop condition: enough evidence for Agent Hive to update `Current State`, `Execution Plan`, and `Next Actions` without relying on chat history.
```

Verification specialist:

```text
You are the independent verification specialist for phase {phase}. Do not implement corrections. Review the worker output, uploaded changes, identified risks, acceptance criteria, and validation evidence. Return `ACCEPT` only when the recorded criteria pass and the result is safe enough for the next dependent step; otherwise return `REJECT` with concrete corrections and supporting evidence.
```

## References

Read `references/progress-template.md` when creating or updating the Agent Hive progress file.
