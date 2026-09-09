# Delegation

## Select Just In Time

For an executable assignment, select a role by purpose, scope, authority, and domain fit before choosing its model. Prefer a general implementer unless a specialist's
method materially improves a concrete correctness problem within its declared domain.

## Model Catalog

| Tier | Nickname used in rules | Runtime model ID |
| --- | --- | --- |
| Efficiency | Lua | `gpt-5.6-luna` |
| Balanced | Terra | `gpt-5.6-terra` |
| Advanced | Sol | `gpt-5.6-sol` |
| Astra | Astra | `gpt-6-astra` |

Resolve each nickname to its runtime ID in launch configurations and assignment prompts. An alternative ID requires runtime confirmation that it
resolves to the same model.

## Mandatory Model Routing

Classify assignments by their required result and apply this table. The only implementation exception is a [bounded root
correction](verification.md#direct-root-correction).

| Work | Required model | Effort |
| --- | --- | --- |
| Code/file exploration, lookup, extraction, and mechanical inspection | Lua | `high` |
| Standalone script, build, and validation assignments | Lua | `high` |
| Conventional implementation | Terra | Start at `medium` |
| Implementation requiring elevated reasoning | Sol | Start at `medium` |
| Exceptionally complex implementation | Astra | `low` or `medium` |
| General, specialist, correction, and final reviews | Astra | `low` or `medium` |

Lua gathers evidence and executes bounded commands. Writing or changing a script is implementation. Implementers own diagnosis and technical choices inside their
contracts; root resolves changes to product behavior, architecture, or scope.

Choose Terra when established project patterns and bounded dependencies suffice. Choose Sol when implementation requires substantial reasoning about interacting
invariants, concurrency, recovery, or nontrivial algorithms. Record the specific difficulty; file count, technology labels, business importance, or a previous failure
alone do not establish elevated reasoning needs. Choose Astra only when tightly interacting constraints, difficult algorithms, or cross-component invariants make the
implementation exceptionally complex. Record why Sol is insufficient for that assignment; no failed attempt is required.

For Terra and Sol, use `high` only when named implementation obligations make `medium` insufficient. Reserve `xhigh` for exceptional implementation demands: record the
obligation, why `high` is insufficient, and the expected evidence benefit before launch. For Astra implementation and review, prefer `low` when the bounded contract and
evidence are clear; use `medium` for interacting invariants, subtle failure paths, or ambiguity requiring deeper analysis. These assignments never exceed `medium`. Do not
use `max` or `ultra` for any assignment.

Commands and validation needed to complete an assignment remain with its executor, within its permissions and ownership. Root delegates standalone exploration and
command-execution assignments to Lua when that provides a concrete coordination or parallelism benefit.

Only select roles compatible with the required model and effort. A fixed role must not override this policy: use another eligible configurable role with the needed
contract. If no compatible route exists, report the blocker; do not silently switch models, inherit the root configuration, or violate tool constraints.

Select the concrete role, model, effort, and context mode before launch. Use `none` or bounded context for exploration and implementation; independent verification
requires `none`. Full conversation
history is forbidden. Map bounded context to the host's supported mechanism, or supply a self-contained prompt with `none`; never invent tool parameters.

Check the launch arguments against the selected configuration. Pass overrides only where the tool permits them; honor fixed roles without incompatible overrides.
On a runtime-reported mismatch, stop affected work, reconcile writes, and replace the invalid assignment context.

Give each agent its exact runtime role name, requested model ID, effort, and bounded scope. Require its first commentary message on each execution, including
continuation, to announce all four as assigned configuration before working. Use the selected role identifier, not a generic task label. Send these facts again with
continuation prompts; do not repeat the announcement during that execution.
An announcement reports the requested configuration, not verified runtime identity. Claim confirmation only from authoritative runtime metadata.
If the initial announcement is missing or incomplete, root requests the missing fields at the next interaction. This reporting omission alone does not require restarting
the assignment or invalidate otherwise valid evidence.

## Select Verification Before Writes

Choose one mode and record its obligations in the implementation contract:

- `Root Evidence`: all effects are bounded, local, reversible, and decidable with reproducible root evidence; no material trust, durable-state, concurrency, lifecycle,
  schema, or public-contract boundary changes.
- `Independent General`: the default when those conditions do not hold.
- `Independent Portfolio`: general review plus a specialist whose changed boundary has a reachable material failure that root evidence and general review cannot
  adequately decide.

If acceptance requires substantive review, select an independent mode.

Activate specialists by concrete consequence, not technology labels. Read their available role contracts and translate applicable review dimensions into implementation
invariants, failure paths, and evidence obligations. Do not infer hidden instructions; missing internals block only when eligibility or coverage cannot otherwise be
established.

Escalate review coverage after new risk, missing evidence, or consumer impact appears. Do not de-escalate after material writes. Serialize required review when capacity
is limited.

## Build The Contract

Root writes a self-contained contract before launch. Include only what the assignment needs:

- outcome, owned paths or systems, baseline, dependencies, and source requirements;
- architectural constraints, interfaces, invariants, and required failure behavior;
- exclusions, validation evidence, unavailable facts, and handoff condition;
- decisions that require returning to root, verification mode, and any new-test authorization.

Define required outcomes and boundaries while leaving local algorithms, code structure, and debugging to the implementer. Prescribe an approach only when a requirement or
shared architectural constraint demands it. Reference existing patterns and source sections. Do not dictate a reviewer's findings or conclusion.

Before dispatch, check that the prompt has no unresolved product or architectural decision, conflicting instruction, inaccessible dependency, or undefined success
condition. If evidence is missing, assign bounded exploration first. Root resolves the result and updates the contract before implementation. Implementation details may
be discovered during execution.

Give agents relevant original requirements. Fresh reviewers receive no prior verdicts or predicted findings. If one executor cannot produce a coherent increment, use
bounded sequential assignments; create separate phases only for independently acceptable outcomes.

## Execute And Track

Use the applicable [exploration](exploration-assignment-prompt.md), [command execution](command-assignment-prompt.md),
[implementation](implementation-assignment-prompt.md), or [verification](independent-verification-assignment-prompt.md) prompt.

An identity belongs to one assignment and phase. Reuse it only for continuation or correction of that assignment. A different assignment requires a fresh identity.
Descendants require root authorization of each child's scope, role, configuration, depth, and capacity; they cannot own the ledger or verify their implementation
ancestry.

Root works outside active writer ownership. Preserve unrelated edits. For isolated work, require a base and integration delta; for shared work, use disjoint ownership or
serialize. Integrate into the cumulative workspace, never replace it with an agent snapshot.

Implement the bounded outcome and return evidence. Report `SPEC_GAP` when a discovery requires a contract change, `NEEDS_SPLIT` for an incoherent boundary, or `MISROUTED`
for an unsuitable capability. Pause only dependent work; root decides and updates the contract. Continue local diagnosis and corrections that preserve its boundaries.

Treat tool activity and coherent analysis as progress; a timeout or missing file change is not proof of inactivity. Prefer steering before replacement. Intervene for an
explicit blocker, runtime failure, confirmed inactivity, exhausted execution budget, or ownership/safety violation.

A handoff states `DONE`, `INCOMPLETE`, or `BLOCKED`, evidence, gaps, and out-of-scope writes. Root confirms the complete owned diff, validation, and ownership release
before advancing the [lifecycle](lifecycle.md). A handoff alone is not acceptance.
