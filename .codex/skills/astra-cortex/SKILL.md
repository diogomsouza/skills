---
name: astra-cortex
description: >-  
  Coordinate complex, high-risk, parallelizable, or long-running implementations with model directed orchestration, a dependency-aware phases, review and correction, 
  per-phase acceptance, and resumable progress. Use for work benefiting from coordinated execution, useful parallelism, and ongoing validation; avoid small, simple, 
  low-risk tasks. Designed for gpt-6-astra: only that model or a runtime-confirmed alias may select it implicitly; other models require explicit user invocation.
---

# Astra Cortex

Keep the approved specification, phase status, review evidence and progress consistent. Reading or editing this skill does not activate its workflow. Root means the agent
responsible for the overall run. Delegated work belongs to that run; reading this skill does not require subagents to create separate goals or progress files.

## Model eligibility

Implicit selection is allowed only when authoritative runtime information identifies the root as gpt-6-astra or a confirmed alias. Otherwise, treat eligibility as unknown
or unmet and do not select this skill implicitly. An explicit user invocation permits any model to use it, subject to live tool contracts; record that basis and preserve
it on resume without asking again. Without explicit invocation, recheck eligibility on resume when the root model changed or is unknown. Do not switch the root model or
edit configuration merely to satisfy eligibility. This restriction concerns skill selection by the root, not the models of its subagents.

## Boundaries

This skill defines the implementation workflow and phase acceptance requirements; you own orchestration decisions within the current Codex environment. Subject to
higher-priority instructions and live tool contracts, explicit user instructions take precedence over this skill's workflow rules; record any resulting exceptions.

Use your own judgment and the orchestration capabilities available to you to decide whether to work directly or delegate, how to divide and coordinate work, and when to
run assignments concurrently or sequentially. Choose roles, models, reasoning effort, and context modes where the environment exposes those choices, subject to applicable
instructions, permissions, and runtime constraints.

This skill adds no delegation policy, model tiers, reasoning-effort limits, agent prompt templates, selection-approval gates, or mandatory dedicated reviewer role. Keep
an accurate record of active assignments for coordination and progress tracking; do not turn that record into an additional prerequisite or approval gate for spawning
agents.

Before accepting an implementation phase, complete its work, review the resulting changes, and make and verify any necessary corrections. Review P0 against its planning
criteria. Choose who performs the review according to applicable independence requirements and your judgment. Create local phase commits where permitted by the
environment and user instructions. Continue through the authorized workflow without routine approval between phases; pause only where a material unresolved decision,
missing authority, unavailable required evidence, user instruction or runtime constraint prevents further work. Unaffected authorized work may continue.

## Workflow

On resume, apply the recovery rules in [ledger.md](references/ledger.md) before creating a goal or progress file. Reuse the reconciled state; do not restart P0 or
overwrite an existing ledger with the template. Revalidate an already completed handoff instead of opening a duplicate run.

1. Read [goal.md](references/goal.md). Reuse a matching unfinished goal or create an authorized real goal before managed work.
2. Read [ledger.md](references/ledger.md). For a new run, initialize progress from [progress-template.md](references/progress-template.md), with P0 as the only active
   phase.
3. Read [planning.md](references/planning.md) and [acceptance.md](references/acceptance.md). Use the supplied specification, save an existing approved conversation plan,
   or create a specification from the resolved request. Investigate the code in P0, map requirements to phases and dependencies, and accept P0 before implementation
   begins.
4. Keep phase states and actual assignments current under ledger.md. Remove finished assignment rows after consuming their results and confirming ownership release.
5. Apply acceptance.md: review completed work, correct qualifying defects, and review affected content again. Accept only after review and the checkpoint requirement are
   satisfied.
6. After all phases close, validate the cumulative result and specification coverage, complete the real goal, and normalize progress for final delivery.

Report the result, validation, limitations, progress path, phase commits and actual goal usage/elapsed time when available. Never invent missing evidence.
