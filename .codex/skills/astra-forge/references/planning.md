# Planning And Resume

## Start

Inspect the goal tools and current goal before substantial discovery, delegation, or writes. Reuse only a matching unfinished goal. Resolve an objective conflict with the
user. Create a missing goal only when its tool contract permits it; skill selection does not override a requirement for explicit user authorization. Set a token budget
only when explicitly requested. If the mandatory goal cannot be established, stop and explain the exact requirement.

Derive scope and observable completion evidence from the request and authoritative project sources. Use bounded Lua exploration to collect code evidence, then resolve
technical choices as root.

Choose a unique `YYYY-MM-DD-{slug}` context ID. After goal activation:

1. Use an accessible user-referenced specification when available. Otherwise preserve an existing conversational plan in `docs/PLAN-SPECS-{context-id}.md`, or create a
   concise implementation plan there from the request and project evidence.
2. Distinguish user requirements from agent assumptions and implementation decisions. A generated plan is derived coordination material, not additional user authority.
   Preserve captured user wording; revise derived decisions as evidence changes and record the reason. Do not modify user-owned specifications without authorization.
3. Create `.astra-forge/PLAN-PROGRESS-{context-id}.md` using the [progress template](progress-template.md), initially with only discovery phase P0.

Record the original request, specification origin and locator, scope, exclusions, and acceptance criteria. Every applicable requirement must map to acceptance evidence;
exclusions need a reason consistent with the user's scope.

## Discover And Decompose

P0 is bounded read-only discovery of implementation, consumers, tests, project instructions, existing changes, and relevant external state. Stop when remaining unknowns
cannot change phase boundaries, dependencies, obligations, or evidence. No implementation writes precede P0 acceptance; coordination artifacts are permitted.

Capture runtime topology, available roles, supported model/effort pairs, fixed configurations, context-transfer options, capacity, and lifecycle capabilities. Refresh
when these change or after resume. Unknown writer topology forbids concurrent writes.

Group work by independently acceptable outcomes or a shared invariant whose parts must pass and be corrected together. Split when an outcome can start earlier, unlock
useful work, or be accepted and corrected independently. Do not split by file count, technical layer, or available agent slots alone.

Map each required behavior and cross-phase guarantee to one primary phase and a resolvable source section. Give each phase its earliest dependencies and observable
acceptance evidence. Keep future owners `Unassigned`; create assignments only when dependencies permit work. Reserve final integration phases for behavior that cannot be
established earlier.

Confirm P0 source coverage and decomposition, then close it through the [lifecycle](lifecycle.md) before dependent work.

## Scope And Changes

A correction must address an approved requirement or a directly affected existing guarantee. Separate a valid defect from an unnecessarily broad remedy. Do not add
features, compatibility layers, or adjacent refactors merely because a reviewer suggests them. Apply the test exception in `SKILL.md` before authorizing new tests.

Discard unsupported or unrelated remedies from execution. Material unrelated findings may be reported separately without turning them into work or blocking this task.
User updates can amend scope; reconcile affected phases, contracts, and evidence.

Give agents access to relevant original requirements and specification sections. Extract clean requirement excerpts when a source also contains previous verdicts or
implementation deliberations. Root remains responsible for complete source coverage; a bounded contract must not silently replace or omit an applicable requirement.

## Resume

Read `SKILL.md`, this reference, and the complete matching ledger. Inspect the goal, workspace, agent identities and ownership, candidate identity, and relevant external
state. Then load only references governing the pending action.

Reconcile durable records against authoritative sources. Treat summaries as memory, not permission. Stop for conflicting goals, ambiguous ledgers, or unreconstructable
critical state. Recreate a missing goal only through its permitted lifecycle.

Reproduce evidence whose candidate binding, provenance, or independence is uncertain. If the goal is already complete, use the terminal recovery procedure in
[lifecycle.md](lifecycle.md); do not restart accepted work.
