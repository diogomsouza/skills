---
name: overmind
description: >-
  Coordinate complex, high-risk, parallelizable, or long-running work through a throughput gate, root-frozen design, runtime-aware delegation,
  precise work packages, forward-only integration, a persistent goal and ledger, and risk-scaled independent verification. Use when the user explicitly
  invokes Overmind, requests design-first subagent orchestration, or needs durable coordinated work across agents or turns. When Overmind or agents were
  not explicitly requested, avoid the full Managed Run only when every Fast criterion is satisfied.
---

# Overmind

Keep the root responsible for the goal, design, integration, verification barrier, and user report.

Use agents as bounded contributors:

- explorers collect facts without owning the solution;
- executors implement decisions already closed by the root;
- verifiers independently inspect the cumulative candidate.

Prefer the smallest process that preserves correctness. Choose exactly one execution mode before material work.

## Pass The Throughput Gate

Start with bounded read-only discovery. Before choosing any mode or creating a goal, ledger, package, or agent, inspect authoritative runtime metadata for usable, occupied, and free capacity, lifecycle controls, active agents, workspace topology, and active writers. Then compare expected wall-clock or risk reduction against token use, capacity, coordination, and integration cost.

Choose `Fast` only when every condition is true:

- the work is local, reversible, and limited to one clear boundary;
- no security, privacy, durability, concurrency, migration, release, or public-contract risk is material;
- no matching Overmind run or active goal exists;
- the user did not explicitly invoke Overmind or request agents;
- no agent, delegated write, or parallel workstream is needed;
- the work can finish in the current turn without a planned continuation.

Otherwise choose a Managed mode:

- `Managed-Serial`: durable coordination is justified, but work overlaps, capacity is limited, topology is unknown, or parallelism would not shorten the critical path. Use this mode for bounded read-only exploration when only one explorer is useful.
- `Managed-Parallel(N)`: at least two coherent independent workstreams can run safely, usable capacity is known, and the expected net gain exceeds coordination and integration cost. Treat `N` as a ceiling, not a target.

Explicit invocation of Overmind, an explicit agent request, or a request for managed design-first orchestration selects a Managed mode, but never forces parallelism.

After selecting a Managed mode, create or reuse the goal and ledger, then record the timestamped pre-decision discovery snapshot and mode rationale before any package or spawn.

The Fast Path creates no Overmind goal, ledger, package, or agent. Work normally at root and verify proportionally. Promote immediately when scope expands, risk becomes material, an agent becomes useful, or work must continue across turns. Promotion follows the same order: refresh read-only runtime, capacity, topology, agent, and writer discovery; choose `Managed-Serial` or `Managed-Parallel(N)`; then, before the first Managed spawn:

1. create or reuse the goal;
2. create or resume the ledger;
3. record the pre-decision snapshot and throughput rationale;
4. record the bounded assignment in the ledger.

Read-only explorers may run during `Planning`. Reach `DesignReady` before the first delegated write. Never combine Fast execution with agents.

## Classify Managed Risk

Classify the run before planning:

- `Standard`: coordinated work without a material high-risk boundary;
- `High-Risk`: security, privacy, secrets, privileges, data loss, durability, recovery, migration, concurrency, cancellation, release, or public contracts.

Escalate from Standard when discovery reveals a high-risk boundary. Record the change in the ledger before more writes or spawns.

High-Risk changes require a checkpoint or an early vertical smoke defined by the frozen plan. Standard changes require one only when the plan says it adds useful evidence.

## Discover Runtime And Workspace

The initial gate inspection is read-only and precedes mode selection and creation of a new goal or ledger. After the Managed ledger exists, record that pre-decision snapshot. Before each Managed assignment and again on resume, refresh authoritative callable schemas and runtime metadata and record a compact timestamped snapshot covering:

- goal and delegation availability;
- usable, occupied, and free agent capacity;
- context delivery, same-assignment continuation, waiting, result retrieval, interruption, and terminal lifecycle semantics;
- visible agent purposes, restrictions, and authority;
- active agents and writers already in flight.

Do not infer capabilities, permissions, independence, or model configuration from an agent name or self-report. If a required capability is unavailable, redesign within the available constraints or report the blocker instead of weakening the contract.

Classify workspace topology before any delegated write:

- `shared-live`: edits become immediately visible; keep write scopes disjoint or serialize them, and never reapply the whole workspace as a handoff;
- `isolated/forked`: require the actual base, source candidate identity, intended delta, changed paths, and evidence, then reconcile only that delta;
- `unknown`: prohibit parallel writes and permit at most one serialized bounded writer until topology becomes authoritative.

Treat runtime and workspace inspection as authority for current operational state. The ledger stores the durable contract and last observed snapshot; reconcile it with current authoritative state before resuming or spawning.

## Start Or Resume A Managed Run

Read the request, project instructions, current workspace state, and available agent specifications before assigning work.

For a resume:

1. inspect `.overmind/*/PLAN-PROGRESS-*.md` for a clear match;
2. read the matching ledger completely;
3. inspect the authoritative runtime goal state;
4. if no runtime goal is active, recreate it from the ledger's goal and completion contract before continuing or delegating;
5. if the active runtime goal is compatible with the ledger's goal, scope, and completion contract, reuse it;
6. if the active runtime goal conflicts, stop and ask the user whether to resolve the goal or the run; never replace or rebind either silently;
7. reuse the ledger's `context-id`, plan revision, assignments, and next actions;
8. refresh runtime, topology, candidate identity, active-agent, writer, and capacity state;
9. ask the user when multiple runs plausibly match.

For a new run:

1. use the gate's read-only discovery to select the Managed mode;
2. create the goal from the requested outcome and completion evidence;
3. create `context-id` as `YYYY-MM-DD-{short-kebab-slug}`, adding a numeric suffix only for a real collision;
4. create `.overmind/{context-id}/PLAN-PROGRESS-{context-id}.md` from the progress template;
5. record `GoalDefined`, the pre-decision snapshot, and the throughput rationale before any delegation.

Use only these run artifacts:

- `.overmind/{context-id}/PLAN-PROGRESS-{context-id}.md`;
- optional `.overmind/{context-id}/WORK-PACKAGE-{context-id}-{assignment-id}-v{package-version}.md` files.

Do not create a separate design artifact. Keep the authoritative plan under `Frozen Plan` in the ledger.

Treat the ledger as the durable source for the goal, frozen design, assignments, last reconciled snapshot, results, verification, blockers, and next actions. Runtime and workspace state remain authoritative for current agents, capacity, ownership, and candidate contents.

Update it after every material transition, capability or topology refresh, assignment, acknowledgement, exact runtime identity, lifecycle change, handoff, candidate promotion, root audit, verifier result, correction, circuit decision, or user decision.

## Follow The State Machine

Use this state sequence:

```text
GoalDefined -> Planning -> DesignReady -> Executing -> RootChecked -> Verifying
Verifying --accept--> Accepted
Verifying --reject--> Correcting -> RootChecked
```

Track a separate circuit state: `Closed` or `Open`. It is not a workflow phase.

Apply these transition rules:

- `GoalDefined`: the Managed goal and ledger exist and agree.
- `Planning`: the root is closing requirements, design, boundaries, and evidence.
- `DesignReady`: the current plan revision is frozen and packages can be issued.
- `Executing`: acknowledged executors are implementing bounded packages.
- `RootChecked`: the root has audited the full cumulative candidate and evidence.
- `Verifying`: the risk-scaled independent review barrier is running against a stable candidate.
- `Correcting`: one aggregated correction wave of fresh assignments and instances for the current Plan Revision is active.
- `Accepted`: every required contract is satisfied and completion conditions hold.

After a correction, return through `RootChecked` and `Verifying`. If the corrected candidate is rejected again, the candidate base diverges materially, ownership becomes ambiguous, or a new material decision is required, open the circuit, stop candidate writes, and return to `Planning`. Close the circuit only after recording the strategy, incrementing the Plan Revision, and freezing a coherent replacement plan.

Never skip `DesignReady`, `RootChecked`, or the independent verification barrier.

## Freeze The Plan At Root

At `Planning`, personally inspect the critical sources, interfaces, tests, consumers, and workspace changes. Use explorers only to collect specific missing facts.

Write a frozen plan that closes:

- the requested outcome, included scope, exclusions, and completion evidence;
- the throughput mode, runtime constraints, workspace topology, and capacity assumptions;
- architecture, algorithm, interface, sequencing, and integration decisions;
- state, failure, cancellation, cleanup, recovery, and compatibility behavior when relevant;
- exact implementation boundaries and ownership;
- candidate identity, provenance, and forward-only integration behavior;
- requirement-to-evidence mapping, negative paths, and validation commands;
- checkpoint or vertical-smoke requirements;
- risk-scaled independent verification contracts, the one-wave-per-revision limit, and circuit-opening conditions.

Do not enter `DesignReady` while an executor would still need to choose material behavior, architecture, scope, failure semantics, or proof.

Ask the user only for a missing decision that would materially change the solution. Record the answer and increment the plan revision before freezing again.

## Select And Bind Agents

Inspect the agent types and restrictions available in the current environment before each assignment.

Derive the needed profile from the task:

- implementation, exploration, or verification;
- domain and risk boundary;
- required tools and write authority;
- independence and evidence obligations;
- any security, state-machine, durability, or review specialization.

Choose only from declared purpose, capabilities, authority, and constraints. Never select by model name, provider, service tier, or reasoning effort.

Use the closest capable agent. If no agent fits, split the boundary, redesign the evidence path, or report the capability blocker. Never weaken the contract to fill a slot.

For each material assignment:

- use a fresh instance and bind its exact returned runtime identity, assignment ID, package version when applicable, topology, and owned scope;
- continue that instance only for acknowledgement, checkpoints, or clarification inside the same unchanged assignment; post-verification correction always receives a new assignment and fresh instance;
- never retask an instance across assignments or reuse an executor as its own independent verifier;
- record assignment state, ownership state, instance lifecycle, and capacity disposition as four separate facts;
- after terminal handoff and evidence integration, release scope ownership, then release capacity through supported lifecycle control or mark the instance terminal and non-reusable, recording whether capacity remains occupied.

Tell every agent whether the workspace is shared, isolated, or unknown, assign exact ownership, and require preservation of unrelated edits. Keep cross-assignment communication root-mediated and do not prime one verifier with another verifier's conclusion.

## Delegate Material Writes With Packages

Read [the work-package template](references/work-package-template.md) before delegating a material write.

Give each package one semantically verifiable boundary. Specify exact touchpoints, fixed decisions, required behavior, negative paths, validation, non-scope, and decision budget.

Bind each package to its `context-id`, assignment ID, package version, frozen Plan Revision, topology, integration mode, and base Candidate ID plus the strongest reproducible fingerprint available.

Create a new package version when its contract changes. Never mutate a version after acknowledgement. A changed assignment boundary receives a new assignment ID at version 1.

Post-verification correction never mutates or versions the predecessor package. It creates a fresh correction assignment and package at version 1, linked to the rejected candidate, stable finding IDs, and predecessor assignment.

Make the executor's first turn read-only. Require exactly one response:

```text
READY | SPEC_GAP | NEEDS_SPLIT | MISROUTED
```

Interpret the response at root:

- `READY`: record acknowledgement, then send a separate execution turn;
- `SPEC_GAP`: return to planning and close the missing decision;
- `NEEDS_SPLIT`: replace the package with smaller coherent packages;
- `MISROUTED`: select a different capable agent.

Do not allow edits, goal changes, ledger changes, or replacement design during acknowledgement.

For execution, bind the acknowledged package and require `DONE`, `INCOMPLETE`, or `BLOCKED` with changed files, checks, and explicit gaps.

At handoff require the exact runtime identity, actual base candidate, changed paths or symbols, delta provenance, validation, and observed divergence. Reissue the package only when candidate drift affects its owned scope, dependencies, assumptions, or acceptance boundary; disjoint unrelated changes do not invalidate it automatically.

Use packages only for material delegated writes. Read-only exploration and independent verification use precise prompts recorded as assignments in the ledger.

## Execute And Checkpoint

Keep ownership disjoint or serialize overlapping writes. Do not patch an executor's owned scope concurrently.

Require the executor to follow the frozen decisions, preserve unrelated edits, run the smallest relevant checks first, and identify unrun validation.

In `shared-live`, treat visible edits as in-flight until the owner hands them back; audit and promote them without copying or reapplying the workspace. In `isolated/forked`, integrate only the intended delta onto the latest cumulative candidate. Refresh capacity and writer state before each spawn and after interruption or terminal handoff.

Require a checkpoint only for High-Risk work or when the frozen plan specifies an early vertical smoke. Record its evidence in the ledger, not in the immutable package.

Treat a new finding outside the frozen plan as a proposed scope change. It blocks only when it violates an existing requirement, guarantee, realistic in-scope risk, or instruction.

## Integrate Forward Only

Keep two identities separate:

- **Candidate State**: the cumulative product or deliverable contents that must pass acceptance, identified monotonically as `C0`, `C1`, and so on, with the strongest practical content fingerprint and `Mutable` or `Frozen` status;
- **Operational State**: the live `.overmind` ledger, packages, agents, capacity, topology, ownership, and coordination activity.

Operational updates do not change or invalidate the candidate unless an immutable ledger or package snapshot is explicitly part of the deliverable.

Before promoting a handoff, freezing a candidate, or entering `RootChecked`:

1. reconcile the package's actual base candidate with the latest cumulative candidate;
2. inventory every changed workspace path and classify provenance at the smallest reliable change unit, such as delta, hunk, or symbol, as candidate-bearing, operational, or an explicitly preserved unrelated user change; allow a path to contain more than one class;
3. attribute every candidate-bearing change unit to its immutable authorized assignment record, whether that assignment is live or terminal, and reject ambiguous, unauthorized, retired-assignment, or overlapping residue;
4. derive the candidate fingerprint from only the candidate-bearing projection, keep mixed paths and excluded operational or preserved-user units explicitly recorded, review the complete projected diff, and confirm that affected previously accepted guarantees still hold;
5. issue the next Candidate ID and fingerprint only after the forward-only preflight passes.

Never replace, reset, or restore the current candidate from an agent snapshot. When an isolated delta is stale, port only its still-authorized intent onto the current candidate and rerun affected validation. If topology or overlapping ownership becomes uncertain, stop writes and open the circuit.

## Audit At Root

Before independent verification, inspect the cumulative candidate rather than isolated handoffs.

Confirm:

- every planned touchpoint and requirement disposition;
- full diffs, consumers, interfaces, and integration order;
- negative paths, cleanup, and recovery where relevant;
- test provenance, failures, skipped checks, and unrelated changes;
- all implementation assignment states and executor instances are terminal, their ownership is released, capacity dispositions are recorded, and no candidate write remains in flight.

Require the forward-only preflight to pass and fix integration mistakes before `RootChecked`. Do not use the verifier to discover the plan's basic requirements for the first time.

Freeze the candidate for the barrier and record its exact scope and evidence in the ledger.

## Verify And Converge

Scale verification depth to the recorded risk while preserving an independent barrier for every Managed Run:

- `Standard`: use one broad independent verifier over the complete cumulative candidate; keep the contract compact and rely on reproducible validation for low-risk details;
- `High-Risk`: use the broad baseline plus only the complementary independent contracts required by distinct material risks such as security, privacy, durability, recovery, concurrency, lifecycle, migration, or public compatibility.

Launch the current portfolio in one barrier when capacity and topology permit, and wait for all results. Do not duplicate review scopes without a recorded variance-reduction reason.

Read each selected verifier's declared response contract. Accept its native result format and never require status tokens that its specification does not support.

At root, normalize every result and record:

- `verdict: ACCEPT|REJECT`, based on whether the native result approves or rejects the candidate;
- `coverage: Complete|Incomplete`, based on whether the required scope was fully reviewed;
- the native result, findings, unreviewed surfaces, and evidence that support the mapping.

A rejection with incomplete coverage keeps the run in `Verifying`. Finish the barrier and obtain the missing coverage before any candidate write or correction. Before leaving the barrier, close every verification assignment, make every verifier instance terminal, and record its capacity disposition.

Do not mutate the candidate during the barrier. Aggregate all findings before correction.

Classify findings as plan, execution, integration, or verifier-contract issues. Resolve plan issues first.

Allow one normal aggregated correction wave per Plan Revision. Enter it only after assigning stable finding IDs and recording the exact rejected Candidate ID and fingerprint. Create fresh correction assignment IDs and immutable package versions, each bound to that rejected candidate, its finding IDs, and any predecessor assignment. Keep every original assignment's identity, package, scope, runtime identity, terminal history, and released ownership unchanged.

Use a fresh executor instance for every correction assignment; never reopen or continue an original executor. After acknowledgement, transfer each scope explicitly from its released predecessor or unowned state to the correction assignment and log the event. Keep assignment state, ownership state, instance lifecycle, and capacity disposition independent. After every correction assignment and executor instance is terminal, ownership is released, and capacity disposition is recorded, rerun the forward-only preflight and root audit, then recheck the original contracts against the corrected candidate.

If any original contract rejects the corrected candidate, more than three material blockers accumulate, candidate provenance diverges, or correction churn suggests the plan boundary is wrong, open the circuit. Stop ad hoc patching and record one strategy: narrow or split the boundary, revise design or invariants, establish missing independent evidence, replace an instance, retire and recreate an assignment, or request a material user decision. Reopen `Planning`, increment the Plan Revision, and issue new package versions when their contract changes.

Run an additional broad review only when new evidence materially changes the risk assessment.

## Complete The Goal

Enter `Accepted` only when:

- every required implementation contract is satisfied and every verification contract has `verdict: ACCEPT` with `coverage: Complete`;
- validation evidence is green or an explicitly approved gap is recorded;
- the final candidate has a recorded ID and fingerprint and its forward-only preflight passed;
- all agents are terminal, their ownership is released, and lifecycle or occupied-capacity disposition is recorded;
- the circuit is `Closed`;
- blockers are `None`;
- Next Actions is `None`;
- the ledger and workspace agree on the final candidate.

Update the ledger to `Accepted` before completing the goal. Complete the goal only after all conditions hold.

Lead the user handoff with the outcome, changed files, validation, residual risks, and ledger path.

## References

- Read [progress-template.md](references/progress-template.md) when creating or resuming a Managed ledger.
- Read [work-package-template.md](references/work-package-template.md) before every material delegated write.
