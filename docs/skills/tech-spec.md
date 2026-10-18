# Tech Spec

**Create an implementation specification that lets development proceed without rediscovering essential decisions.**

Tech Spec turns a request to build or change software into a saved, repository-grounded specification. It establishes the required outcome, the behavior and contracts that must hold, the essential technical decisions, and observable evidence of completion.

The result is written for the person or agent implementing the change. It focuses on information that affects execution: what must change, where the relevant behavior lives, which constraints must be preserved, and how the finished work will be verified.

## Use it when the deliverable directs a change

The skill applies to specifications for new systems, features, bug fixes, and maintenance work. Both parts matter: the user needs a software change and asks for a saved specification that guides its implementation.

A request to explain an existing system, write an operations guide, or document a standalone testing procedure belongs to [System Spec](system-spec.md). An implementation-only request or brief planning question does not automatically activate Tech Spec.

Verification can be part of an implementation specification when it establishes that the proposed change was completed correctly. That does not make every test document an implementation plan.

## Establish what must be decided

The workflow inspects the relevant code, consumers, contracts, schemas, configuration, dependencies, and existing requirements. It uses those sources to distinguish today's behavior from the requested change.

Some decisions must be resolved before handoff. For example, whether cancellation preserves a completed write or attempts to undo it changes data semantics and recovery behavior. That is materially different from choosing a private helper's name.

| Binding content | Choices that may remain local |
| --- | --- |
| Externally observable behavior and failure outcomes | Equivalent internal organization |
| Data, permission, compatibility, and protocol contracts | Method decomposition within those contracts |
| Essential algorithms or ordering required for correctness | Incidental implementation details |
| Scope, constraints, and completion conditions | Repository-consistent choices that preserve the specified result |

The skill investigates facts before asking questions. When a material decision cannot be inferred or resolved from evidence, it presents the issue, options, consequences, and a recommendation, then asks one decision at a time.

Recommendations do not count as approval. Likewise, existing code establishes current behavior but cannot silently define the user's intended new behavior.

## Describe concrete implementation work

A contained change can use one implementation unit. Larger work can use cohesive phases with real dependencies and clear outcomes.

For each unit, the specification describes the required behavior, relevant code locations, contracts, and essential mechanics. References distinguish files to change or create from files consulted only as evidence. Shared-resource ownership and integration ordering are resolved when they affect safe execution.

Dependencies describe actual prerequisite outputs. Phase numbering alone does not require sequential work, and two phases with no declared dependency may still conflict if they modify the same shared state.

Safeguards are assigned where the operation is introduced. A phase that writes data must preserve the necessary failure and integrity guarantees in that phase; a later cleanup phase cannot be the only thing preventing data loss in the earlier one.

## Make verification observable

Completion checks pair a concrete action with an expected result. They cover relevant behavior, integrations, failure paths, and recovery conditions without expanding into an unrelated test catalog.

For example, an idempotent import change may need to show that retrying the same accepted input does not create duplicate records and that a failed attempt remains distinguishable from a completed one. The exact checks must follow the actual contract and available validation boundaries.

Authoring-time inspection or exploratory checks establish premises about the current system. They do not prove that the future implementation passes its specified checks.

Verification should also be assigned where its prerequisites exist. If a check requires output from a later phase, that later phase owns it and the overall completion criteria still require it. Existing results can be reused only while their implementation, contracts, inputs, and environment remain applicable.

## Save a plan that can be handed off

The default output is `docs/PLAN-SPECS-{context-id}.md`, with a creation timestamp. Explicit revisions update the active document; new requests preserve colliding files by selecting an available suffix.

The skill chooses a structure suited to the change. Its suggested scaffold is a starting point, not a requirement to create empty sections or artificial phases. Full definitions of shared decisions live in one canonical place, with references where needed.

Before handoff, an independent reviewer checks the saved version against the original request, confirmed decisions, and supporting sources. The review evaluates whether a downstream implementer can proceed without inventing a missing product decision or essential contract.

The current version must receive `ACCEPT`. Corrections require renewed review, and unresolved evidence or decisions needed for the specification remain explicit blockers.

## From specification to implementation

Authoring does not change application code, tests, behavior, or configuration. A specification-only request ends with the accepted plan.

If the same request already authorized implementation, development can continue after independent specification acceptance unless the user asked for another checkpoint. This differs from [Grill Code](grill-code.md), whose interview workflow requires explicit post-grilling implementation approval.

## Example requests

```text
Use $tech-spec to specify resumable CSV imports.
Inspect the current import flow, preserve its validation rules, and define
how retries avoid duplicate records.
```

```text
Use $tech-spec to prepare an implementation plan for replacing the cache backend.
Document compatibility constraints, failure behavior, and completion checks.
Do not implement it yet.
```

For sustained execution of an accepted plan, [Code Craft](code-craft.md) provides implementation, coordination, verification, and progress checkpoints.

## Source and related guides

- [Skill definition](../../codex/skills/tech-spec/SKILL.md) — investigation, implementation planning, verification, and review.
- [Document Reviewer](../agents/document-reviewer.md) — independent review of the saved specification.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->