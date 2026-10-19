# Delegation

## Select The Executor

Root implements by default. For each available implementation assignment, first determine whether a specialist's method materially improves a concrete correctness
problem within its declared domain. Delegate that bounded core when needed, even when it is the only implementation available.

For general implementation, root takes the work when only one assignment is available. When independent assignments can proceed concurrently, root takes one and
delegates the others where parallel execution provides a concrete benefit. Choose root's part for its use of existing context and ability to unlock dependent work.
Do not divide coupled work merely to keep agents occupied. Resolve shared interfaces and dependencies before concurrent writes.

Before taking an assignment, root assesses whether its runtime model and effort support the required reasoning and evidence under the selection criteria below.
Root retains its runtime configuration; if it is unsuitable, delegate a coherent assignment to a compatible configuration instead of lowering the obligations.

Before starting its own implementation assignment, root announces a short description of the work it is taking, without explanation or a task list.
Repeat only when its assigned scope materially changes, not for routine continuation.

Root retains orchestration responsibility while implementing. Address blockers and decisions that prevent other authorized work before continuing local implementation;
handle coordination at natural execution boundaries. Root may temporarily prioritize orchestration when its own implementation
would delay the overall task. Do not duplicate work already assigned to a subagent.

Keep in-scope diagnosis and corrections with the current implementer. Reconsider the executor when the boundary or capability needs change, or an ownership transfer
would materially improve progress; use the transfer rules below before another writer takes over.

## Select Delegated Roles

Define the required role contract by purpose, scope, authority, and domain fit before selecting a model and effort.
For implementation, use a general implementer by default and a specialist for cores selected under the executor policy above.
Choose a specialist for its method and authority; select its model and effort from the assignment's reasoning obligations independently of the role label.

## Model Catalog

| Model | Agent tool `model` | Model ID |
| --- | --- | --- |
| Haiku | `haiku` | `claude-haiku-5-5` (Claude Haiku 5.5) |
| Sonnet | `sonnet` | `claude-sonnet-5-5` (Claude Sonnet 5.5) |
| Opus | `opus` | `claude-opus-5-5` (Claude Opus 5.5) |

Launch with the Agent tool's `model` alias. Use the full model ID where a launch surface takes one, such as custom agent `model:` frontmatter, and to name the
model in assignment prompts. Root runs on the session's model and does not select its own.

If the required model cannot be launched, report the blocker under Launch Configuration; do not silently switch models.

## Mandatory Model Routing

The configuration, launch-context, and announcement rules below apply to delegated agents. The work-assessment criteria also govern whether root's fixed runtime
configuration is suitable for its own assignment. Root's run-document maintenance follows [planning](planning.md#specification-and-design).

### Delegation Boundaries

Commands and validation needed to complete an assignment stay with its executor, within its scope, permissions, and ownership.

Root delegates standalone exploration when delegation provides a concrete coordination or parallelism benefit. Distinguish factual collection from analytical
investigation in the contract: collection can use Haiku; diagnosis, synthesis, and other substantive conclusions follow the shared model-and-effort assessment.
For standalone command execution, delegation requires the same benefit and a long-running validation campaign or script expected to take minutes or hours. Root runs other 
standalone commands directly, including quick commands.

Creating or modifying project scripts is implementation. Inline, nonpersistent inspection and validation commands that leave project implementation unchanged follow
command-execution routing only when execution and success criteria are prescribed. Designing an experiment or interpreting uncertain results is analytical work.
Classify by the required result and effects, not language or tool use.

### Assess The Work

Assess each assignment's reasoning difficulty, material uncertainty, coupled guarantees, and required verification depth:

- Reasoning difficulty: applying an established solution, combining known mechanisms, or developing and justifying a conceptually difficult solution or conclusion.
- Material uncertainty: which assumptions, behaviors, causes, or correctness claims must be discovered or challenged before completion.
- Coupled guarantees: which decisions and invariants must be considered jointly across components, states, or execution stages.
- Verification depth: which evidence, alternatives, counterexamples, and failure paths must be examined to support the result.

Select the model and effort together from that assessment, applying the criterion of the most demanding obligation necessary for completion. Routine portions of an
assignment do not dilute its difficult obligation. Decompose work only when the separate results can still establish the required combined guarantees.

Consequences of error inform the required assurance and verification depth. File count, duration, role, technology labels, business importance, or diff size alone do
not determine a configuration. Missing prerequisites and environmental failures require resolution; they do not by themselves imply greater reasoning difficulty.

Choose a configuration that supports the required reasoning and evidence. Optimize cost and latency among suitable configurations.
Do not assume that a lower configuration is sufficient merely because its limits have not yet been observed.

For Opus or effort `high` and above, briefly record the decisive reasoning obligations and expected evidence benefit in the existing ledger before launch.
Identify what must be related, discovered, or established; a label such as "complex" is insufficient. Prior attempts and proof that another configuration would fail
are not required.

### Model Selection

| Required reasoning | Model |
| --- | --- |
| Factual collection, eligible prescribed command execution, or strictly mechanical implementation with an explicit approach, limited interpretation, and directly checkable results | Haiku |
| General development, investigation, and independent review, including complex work supported by established methods, coherent decomposition, and analysis of interactions | Sonnet |
| Exceptionally difficult inference, derivation, reconciliation of competing models or explanations, or global judgment over tightly coupled guarantees whose premises must also be established or challenged | Opus |

Implementers own diagnosis and technical choices within their contracts; root resolves changes to product behavior, architecture, or scope.

Sonnet is the default for delegated development, investigation, and independent review. Complex work can remain on Sonnet, including concurrency, recovery, algorithms, and
interacting invariants, when its concrete reasoning obligations fit the Sonnet criteria. Select the configuration from those obligations rather than the subject alone.

Use Haiku for implementation only when the required transformation is explicitly determined, effects are localized and well understood, and completion requires no
behavioral design, diagnosis, or nontrivial technical choices. An established pattern or a small diff alone does not qualify. Prefer Sonnet at the Haiku–Sonnet boundary.

Reserve Opus for assignments whose necessary reasoning presents exceptional difficulty of the kinds described above. Identify the dominant difficult obligation and
the evidence or conclusion it must establish. Routine hypothesis comparison or multiple interacting components alone does not meet that threshold. Opus's exceptional
use follows from the work, not a frequency quota or a requirement to exhaust Sonnet. A small assignment can require Opus; a large one can remain on Sonnet.

Apply the same criteria to implementation, investigation, and general, specialist, correction, and final reviews. Select review configuration independently of
implementation configuration, accounting for the review's own need to discover failures, challenge premises, and establish guarantees throughout its authorized scope.

### Effort Selection

Select effort for the depth of reasoning and verification required within the chosen model, using the same work assessment. Pass it in the Agent tool's
`effort` argument on every launch; never rely on a model's default effort. Use these policy limits:

| Model | Permitted effort |
| --- | --- |
| Haiku | `medium`, `high`, `xhigh` |
| Sonnet | `low`, `medium`, `high`, `xhigh`, `max` |
| Opus | `low`, `medium`, `high`, `xhigh` |

- `low`: localized reasoning with a defined approach, clear evidence, and few unresolved interactions.
- `medium`: resolve local technical choices, interacting rules, and known failure paths within an established approach.
- `high`: substantial joint analysis of coupled mechanisms and competing constraints, with the material premises and evaluation approach sufficiently established.
- `xhigh`: sustained investigation to establish or challenge material premises, evaluate competing explanations, or reconcile difficult interactions before reaching
  a supported conclusion.
- `max`: Sonnet only; particularly deep exploration or verification, such as comparison of several plausible alternatives, systematic searches for counterexamples,
  or reconciliation of conflicting evidence, when that depth is necessary to support the conclusion.

These levels apply to focused and broad assignments; `xhigh` and `max` are not restricted to an indivisible core. Effort is relative to the selected model:
Sonnet at `max` is neither equivalent to a particular Opus effort nor a prerequisite for selecting Opus. Increased depth can remain on Sonnet when its model criteria fit.
If an assignment exceeds Haiku's collection, prescribed-execution, or mechanical-implementation criteria, reassess the model instead of compensating only with effort.

Use the shared assessment and rationale above for both model and effort. A rejection or failed check alone does not justify an increase; a newly identified reasoning
obligation can require a different configuration.

`max` is permitted only for Sonnet.

### Launch Configuration

Launch every delegated assignment with the Agent tool. The role is its `subagent_type`: a built-in type or a custom agent defined in `~/.claude/agents/` or the
project's `.claude/agents/`. Select a role compatible with the required contract:

- Collection-only exploration: `Explore` (read-only). Analytical exploration: `general-purpose` under a read-only contract, or a suitable read-only custom agent.
- Command execution and implementation: `general-purpose` or a suitable custom agent. Pass `isolation: "worktree"` when concurrent writers need an isolated checkout.
- Independent verification: a read-only custom reviewer when one exists; otherwise `general-purpose` under an explicit read-only contract, confirmed by root's
  post-review diff inspection under [verification](verification.md#review-a-phase).

If no compatible role exists, report the blocker; do not silently switch models, inherit root's configuration, or bypass tool constraints.

Finalize role, model, effort, and context before launch. Launch every assignment with fresh context: the assignment prompt is its entire bounded context, so make it
self-contained. Never use `subagent_type: "fork"`.

Check launch arguments against the selected configuration and tool contract: `subagent_type`, `model`, `effort`, `run_in_background`, and `isolation` when used.
The `model` and `effort` arguments override a custom agent's definition. If the Agent tool reports a configuration mismatch, stop affected work, reconcile affected writes,
and replace the invalid assignment context.

### Agent Announcements

Provide the exact `subagent_type` and the launch context (`fresh`) in the initial assignment prompt. Require the agent's first message to announce both before
working. Report the `subagent_type`, not a task label, and the context value, not the assignment's scope. Repeat the fields only after a material change to the role or
launch context. Unchanged continuations need neither; continuation does not reset the agent's own history.

The Agent call's `model` and `effort` arguments are the authoritative launch record; record them in the ledger and do not request them in agent announcements.
Announcements do not establish runtime identity.

If either announcement field is missing or incomplete, root requests it at the next interaction. This omission alone neither requires restarting the assignment nor invalidates 
otherwise valid evidence.

## Select Verification Before Writes

Choose one verification mode for each phase before its first implementation write, or before acceptance for read-only work. Record the mode and complete phase
obligations in the ledger's Outcome and Acceptance. Each assignment contract receives the applicable portion; no assignment's handoff substitutes for the combined
phase obligations. Choose among:

- `Root Evidence`: all effects are bounded, local, reversible, and decidable with reproducible root evidence; no material trust, durable-state, concurrency, lifecycle,
  schema, or public-contract boundary changes, and no required substantive judgment beyond those checks.
- `Independent General`: the default when those conditions do not hold.
- `Independent Portfolio`: general review plus specialist review of an in-scope boundary with a reachable material failure mode that root evidence and general review cannot
  adequately decide.

Substantive review is an acceptance judgment about behavior, invariants, or failure paths not already established by explicit, reproducible checks. Confirming
ownership, candidate binding, or evidence completeness alone is not substantive review. If acceptance requires substantive review, select an independent mode.

Assess guarantees throughout the authorized scope, including existing behavior in read-only work; a changed diff is not required. Activate specialists by concrete
consequence, not technology labels. Security review requires an in-scope trust boundary with a reachable threat that general review cannot adequately assess; a
confirmed defect is not a prerequisite for selecting the review. Read available role contracts and translate applicable review dimensions into invariants, failure paths,
and evidence obligations. Do not infer hidden instructions; missing internals block only when eligibility or coverage cannot otherwise be established.

Escalate the recorded phase obligations and affected contracts after new risk, missing evidence, or consumer impact appears. Do not relax applicable obligations after
material writes to accommodate difficulty, cost, or rejection. Only root may remove or revise an obligation introduced by a disproven premise, after recording the
premise, the evidence that disproves it, and the corrected contract in the ledger. Preserve authoritative requirements and all still-applicable guarantees; notify
affected agents before dependent work resumes.
Reusing valid, unaffected evidence under [verification](verification.md#correct-and-revalidate) does not de-escalate those obligations. Serialize required review when capacity is limited.

## Build The Contract

Define each implementation assignment before writes. For root-owned work, record its ownership and essential contract in the existing ledger, referencing the phase
obligations and design. Do not create a separate agent identity, self-addressed message, or contract file. Root resolves discoveries that change its contract or design
and updates affected records and agents before dependent writes.

For delegated work, root sends a self-contained contract in the assignment message before launch. Include only what the assignment needs:

- outcome, owned paths or systems, baseline, dependencies, and source requirements;
- the assignment's part of the solution design, interfaces, invariants, and required failure behavior;
- material assumptions and uncertainty to resolve, exclusions, permitted tool outputs, required evidence and its limits, unavailable facts, and handoff condition;
- decisions that require returning to root, verification mode, and any new-test authorization.

Include persistence constraints in every delegated assignment: do not create auxiliary coordination files; return findings, decisions, and evidence in the response.
Root maintains the design document when present, protects the specification, and records essential execution results and pending obligations in the ledger.

For each material guarantee, root specifies whether supplied evidence, simulation, a real mechanism, or a public workflow can establish it. Simulation cannot establish
behavior it replaces. When fixtures reproduce permissions, process context, locking, or persistent state, require a representative check of that setup before expanding
the validation matrix. Use existing checks where sufficient; new tests remain subject to the test policy in [SKILL.md](../SKILL.md).

Carry the applicable [solution design](planning.md#discover-and-decompose) into the contract: reference relevant design sections when present or existing sources, and
include the interfaces and invariants needed for the assignment without copying complete documents. Implementers choose local algorithms, function organization, and debugging methods that
preserve it. Component boundaries, shared behavior placement, and dependency direction are architectural decisions even within one writer's owned files. An implementer
may propose an alternative; root resolves it before dependent writes. Do not dictate a reviewer's findings or conclusion.

Before dispatch, confirm the implementer can start without choosing missing product or architectural decisions; check for conflicting instructions, inaccessible
dependencies, and undefined success conditions. Resolve missing prerequisite evidence through bounded exploration or an authorized experiment under
[planning](planning.md#discover-and-decompose). Root interprets the result and updates the contract before dependent implementation. Implementation details may be
discovered during execution.

Give agents relevant original requirements, explicit user amendments, and applicable design sections, identifying the source of each. State that requirements govern
the design and assignment. Fresh reviewers receive no prior verdicts or predicted findings. If one executor cannot produce a coherent increment, use bounded sequential
assignments; create separate phases only for independently acceptable outcomes.

## Execute And Track

For delegated assignments, use the applicable [exploration](exploration-assignment-prompt.md), [command execution](command-assignment-prompt.md),
[implementation](implementation-assignment-prompt.md), or [verification](independent-verification-assignment-prompt.md) prompt.

A subagent identity belongs to one assignment and phase. Reuse it only for continuation or correction of that assignment through `SendMessage` to its agent ID;
a new Agent call is a fresh identity. A different assignment requires a fresh identity. Subagents do not launch descendants; root splits work that needs more
executors into separate assignments.

Each implementer, including root, writes only within its recorded ownership. Preserve unrelated edits. For isolated work, require a base and integration delta. Integrate 
into the cumulative workspace, never replace it with an agent snapshot.

Before running mutating assignments or commands concurrently, check their effective write locations and shared resources, including staging directories, temporary files, 
generated outputs, caches, and package destinations. Different source ownership, build directories, or final output directories do not establish isolation when an 
intermediate resource is shared. Use existing isolation options where available; otherwise serialize the conflicting operations. If isolation is uncertain, serialize until 
it is established.

Before transferring ownership, obtain the prior writer's explicit release or confirm it has stopped and cannot write there. Reconcile its changes and pending operations, 
then record the new owner and notify any continuing agent before writes resume. Disjoint ownership does not override an active [candidate freeze](verification.md#bind-evidence-to-the-candidate).

Each delegated executor carries out only the work authorized by its contract and returns evidence. Report `SPEC_GAP` when a discovery requires a contract change, `NEEDS_SPLIT` for an
incoherent boundary, or `MISROUTED` for an unsuitable capability. Pause only dependent work; root decides and updates the contract. Implementers continue local diagnosis and
corrections that preserve their contract boundaries.

Reassess executor, model, and effort when discoveries materially change reasoning difficulty, uncertainty, coupled guarantees, or required verification depth. Preserve
the assignment when its configuration remains suitable. Otherwise update the contract and configuration before dependent work, following launch and ownership-transfer
rules when replacement is needed. Diagnose isolated failures; do not escalate merely because a check failed or a reviewer rejected the result.

Launch with `run_in_background: true` when root has useful independent work or runs agents concurrently; root is notified when each background agent
finishes. Use `run_in_background: false` only when root's next action depends on that result and nothing else can proceed. Never poll, sleep, or reread files or logs
to check on a running agent; elapsed time alone does not justify a status request, a progress report, or declaring inactivity. Use `SendMessage` to a running agent
only for concrete coordination needs, not routine progress checks; final responses provide assignment results.

Prefer steering before replacement. Intervene when needed to correct course, resolve a blocker or runtime failure, address confirmed inactivity, enforce an execution
budget, or protect ownership/safety boundaries; stop an agent with `TaskStop`, then reconcile its writes under the ownership-transfer rules.

Combine already available decisions and clarifications for each agent into one message. Send blockers and correctness-affecting changes promptly; do not delay them
to collect more updates. Avoid repeating unchanged instructions or sending acknowledgment-only messages unless acknowledgment is required for the agent to proceed.

Delegated execution handoffs state `DONE` when assigned execution and validation obligations pass, `INCOMPLETE` for unfinished work, or `BLOCKED` when a specific prerequisite
prevents continuation. Independent verification uses only `ACCEPT`, `REJECT`, or `BLOCKED` under its prompt. Every handoff reports evidence, gaps, and any out-of-scope
writes. Before advancing the [lifecycle](lifecycle.md), root confirms the complete diff, validation, and ownership release for every implementation assignment,
including its own. Record root's execution evidence directly in the ledger. Execution completion alone is not acceptance.
