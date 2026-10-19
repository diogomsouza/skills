# Planning And Resume

## Start

Before substantial discovery, delegation, ledger creation, or candidate writes, inspect `.code-craft/` for run ledgers. If a matching ledger exists, reuse its
context ID and follow [Resume](#resume); do not reinitialize it.

Reuse an unfinished run only when its Objective matches the request; ask the user to resolve an unfinished run whose scope conflicts with the request. When no
matching run exists, derive the outcome, scope, non-scope, and completion evidence from the request and authoritative sources. Resolve only technical gaps needed to
define the goal through bounded read-only inspection; leave implementation discovery and phase decomposition to P0. Ask only for material product or scope decisions
that cannot be inferred from those sources; the goal is then recorded as the new ledger's Objective in step 3.

For a new run, choose a unique `YYYY-MM-DD-{slug}` context ID. Then:

1. Use the user-referenced specification. If it cannot be found or read, try to locate it or recover access; do not generate a substitute. Keep only source-dependent
   work pending while that prerequisite remains unresolved. Only when no specification was supplied, capture the user's request, specified or clarified requirements,
   scope, exclusions, and acceptance criteria in `docs/CRAFT-SPECS-{context-id}.md`, preserving any user-approved conversational plan. Do not turn agent assumptions into
   requirements.
2. Preserve that specification after creation, regardless of origin. Edit it only on an explicit user instruction to update that file. Record its locator, origin,
   and current authorized content identity (an immutable revision covering that content or a digest) in the ledger. Follow [Specification And Design](#specification-and-design)
   for technical additions.
3. Create `.code-craft/CRAFT-PROGRESS-{context-id}.md` using the [progress template](progress-template.md), initially with only discovery phase P0. On Windows,
   attempt `attrib +h ".code-craft"` from the workspace root after folder creation; the leading dot alone does not hide it. Mirror P0 in the session's task list.

Record a concise request description and its source, specification origin and locator, scope references, and acceptance criteria. Preserve user requirements in the
source specification rather than copying them into the ledger. Every applicable requirement must map to acceptance evidence;
exclusions need a reason consistent with the user's scope.

## Specification And Design

Create `.code-craft/CRAFT-DESIGN-{context-id}.md` only when implementation needs material shared decisions not already established in the specification or existing project documentation. 
Otherwise record `Design: None` in the ledger. Maintain at most one design document per run and record its locator in the ledger.

Keep assignment-local implementation details in the code; include the constraints needed to execute and validate the assignment in its contract. Those details alone
do not justify a design document. Reuse existing requirements, code, and documentation as sources when no new shared decision is needed.

For each decision, include only its governing source, chosen approach, brief rationale, and affected shared contract. Relevant subjects include component responsibilities, 
interfaces, dependency direction, cross-component invariants, and unresolved architectural assumptions. Reference existing definitions instead of reproducing them.

Keep acceptance criteria and numerical limits in their authoritative sources. Record effective user amendments and their sources in the ledger; update the design only when 
an amendment changes a shared technical decision. Keep execution status, measurements, test scheduling, approval history, agent contracts, local algorithms, and debugging 
history out of the design.

Update the affected decision in place when it changes. Before reviewing an affected design section, remove superseded or duplicated detail and replace explanations already 
established in code with references. Do not edit the design merely because a phase starts, ends, or produces new validation evidence. Complete necessary design edits before 
freezing the candidate for review under [verification](verification.md#bind-evidence-to-the-candidate).

The specification and subsequent explicit user instructions govern requirements. The design guides implementation within those boundaries and never acquires authority
to add functionality, remove obligations, relax acceptance criteria, or change exclusions. Resolve ordinary technical choices from evidence and correct design
conflicts against clear requirements. Ask the user only for a missing material decision that cannot be inferred or for a change to approved scope; pause only work
dependent on that resolution. Keep effective user amendments and their sources in the ledger's Scope and exclusions, and update the affected design and assignments.
Update the specification's recorded content identity only after a confirmed user change or an explicitly authorized edit. Scope approval alone is not an instruction
to edit the source file.

## Discover And Decompose

P0 is bounded read-only discovery of implementation, consumers, tests, project instructions, existing changes, and relevant external state. Where a comparable workflow
exists, compare its responsibilities, dependencies, and guarantees with the requested behavior before choosing what to reuse. Similarity alone does not justify
abstraction or refactoring.

Identify unverified assumptions that could change the design or invalidate acceptance evidence. Resolve them through available read-only checks, or make the smallest
authorized experiment a prerequisite to dependent implementation after P0. Stop discovery when remaining unknowns cannot change phase boundaries, dependencies,
obligations, or evidence, or are assigned explicit prerequisites requiring replanning from their results. Before P0 acceptance, writes are limited to run documents
under [Start](#start) and [Specification And Design](#specification-and-design).

Inspect the available subagent types (built-in and custom agents in `~/.claude/agents/` and `.claude/agents/`), their tool restrictions, worktree isolation, and
capacity. Recheck when these change or after resume. Unknown writer topology forbids concurrent writes.

Root defines the solution design: affected component responsibilities, dependency direction, interfaces, and what to reuse, adapt, separate, or create. Locate shared
behavior according to those responsibilities and identify how existing consumers will integrate with it. Resolve structural decisions before fixing the corresponding
assignment boundaries. When an experiment is needed, P0 defines it and marks only the dependent design and decomposition as provisional. Root finalizes those decisions
from the result before releasing dependent implementation. Maintain technical additions under [Specification And Design](#specification-and-design). A requirements
list and file ownership alone do not define a design.

Group work by independently acceptable outcomes or a shared invariant whose parts must pass and be corrected together. Split when an outcome can start earlier, unlock
useful work, or be accepted and corrected independently. Do not split by file count, technical layer, or available agent slots alone.

Map each required behavior and cross-phase guarantee to one primary phase and a resolvable source section. Give each phase its earliest dependencies and observable
acceptance evidence in Outcome and Acceptance. Record each phase's verification mode and complete obligations there under
[Select Verification Before Writes](delegation.md#select-verification-before-writes). Create assignments only when dependencies permit work, choose root or a subagent
under [Select The Executor](delegation.md#select-the-executor), and record responsibility in Active ownership.
Reserve final integration phases for behavior that cannot be established earlier. When independent final review is needed, assign it to that phase if its scope fits,
or create a dedicated final-assurance phase under [Final Assurance](verification.md#final-assurance). A root coverage check using valid evidence needs no additional phase.

For work whose correctness depends on ordering, durable state, or recovery, root defines the governing states, permitted transitions, partial effects, and evidence
authorizing continuation or compensation in the applicable assignment contract, including interruption during recovery and affected callers. Reference existing
definitions; record new material shared decisions in the design document only under [Specification And Design](#specification-and-design). Local transition details
stay in the contract and code. Unresolved platform behavior remains an explicit prerequisite, not an assumed guarantee.

Confirm P0 source coverage and decomposition, then close it through the [lifecycle](lifecycle.md) before dependent work.

## Scope And Changes

A correction must address an approved requirement or a directly affected existing guarantee. Separate a valid defect from an unnecessarily broad remedy. Do not add
features, compatibility layers, or adjacent refactors merely because a reviewer suggests them. Apply the test exception in `SKILL.md` before authorizing new tests.

Discard unsupported or unrelated remedies from execution. Material unrelated findings may be reported separately without turning them into work or blocking this task.
User updates can amend scope; reconcile affected phases, contracts, and evidence.

Give agents access to relevant original requirements and specification sections. Include clean requirement excerpts in assignment messages when a source also contains
previous verdicts or implementation deliberations. Root remains responsible for complete source coverage; a bounded contract must not silently replace or omit an
applicable requirement.

## Resume

Inspect the complete matching ledger, workspace, agent identities and ownership, candidate changes, and relevant external state. Recover unavailable skill 
instructions under `SKILL.md`'s Read On Demand rule, then load only the references governing the pending action. Revalidate execution state even when the governing 
instructions remain available.

Read the specification sections governing the pending work, effective user amendments, and, when a design document exists, its relevant sections and dependencies
before reconstructing assignments or making design decisions. Read the complete design only when the affected scope cannot be determined or a cross-cutting change
requires it. Reuse the recorded design locator. With `Design: None`, recover applicable constraints from existing sources and assignment contracts; resuming alone
does not justify creating a design document.

Reconcile durable records against authoritative sources. Treat summaries as memory, not permission. Stop for conflicting runs, ambiguous ledgers, or unreconstructable
critical state. Rebuild the session's task list from the ledger when it is missing. A recorded subagent that `ListAgents` no longer lists, such as one from a previous session,
cannot be continued; treat its assignment as stopped and reconcile its writes under the ownership-transfer rules in [delegation](delegation.md#execute-and-track).

Reproduce evidence whose candidate binding, provenance, or independence is uncertain. If the ledger Status is already `Complete`, use the terminal recovery procedure in
[lifecycle.md](lifecycle.md); do not restart accepted work.
