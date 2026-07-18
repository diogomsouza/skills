# IA Agents Skills

A collection of active Codex agents and skills. Reusable definitions live under `.codex/agents` and `.codex/skills`, global coding guidance lives in `.codex/AGENTS.md`, and historical definitions under `deprecated/` are not loaded.

## Active Custom Agents

- `reviewer`: general-purpose, read-only reviewer for material code changes when independent verification is useful and no narrower specialist is a better fit. Uses GPT-5.6 Sol with high reasoning and focuses on correctness, regressions, contracts, compatibility, and high-confidence maintainability concerns.
- `code-reviewer-security`: reviews security-sensitive and high-risk changes involving authorization, privacy, cryptography, secrets, data integrity, feature gates, installers, drivers, or trust boundaries.
- `pr-test-analyzer`: reviews behavioral test coverage and identifies concrete gaps in changed behavior, error paths, state transitions, concurrency, and integrations.
- `silent-failure-hunter`: reviews error handling, retries, fallbacks, background work, cleanup, and recovery paths for silent or misleading failures.
- `type-design-analyzer`: reviews materially changed domain types, public contracts, state models, serialization boundaries, and their invariants.

## Native Roles Used by Workflows

- `worker`: the default Codex role for delegated implementation and fixes. There is no active custom `code-worker.toml`.
- `explorer`: the default Codex role for material read-only codebase exploration.

Native-role availability is provided by the Codex runtime rather than this repository.

## Active Skills

- `agent-hive`: coordinates high-risk or parallelizable work through best-fit role selection, persistent progress, disjoint ownership, and risk-based independent verification.
- `analyzing-dotnet-performance`: analyzes .NET performance using workload, profiling, benchmark, and targeted static evidence.
- `angular-developer`: guides and generates Angular code using modern framework practices.
- `angular-new-app`: creates modern Angular applications with the Angular CLI.
- `code-planner`: produces a decision-complete implementation plan before editing.
- `gpt-image-2`: generates or edits bitmap images through the OpenAI Images API.
- `grill-code`: stress-tests a technical plan against the codebase and referenced documentation.
- `grill-me`: interviews the user about a plan or design until material ambiguities are resolved.
- `optimizing-ef-core-queries`: optimizes Entity Framework Core queries and common database access patterns.
- `thermo-nuclear-code-quality-review`: performs an explicit, especially strict, read-only maintainability audit.

## Deprecated Definitions

Definitions under `deprecated/` are retained only as historical references and are not active:

- `code-reviewer` was replaced by the leaner `reviewer`.
- `code-reviewer-max` was replaced by `reviewer` for general independent verification and `$thermo-nuclear-code-quality-review` for an explicitly requested deep maintainability audit.
- `code-worker` was replaced by the native `worker` role.

Other archived agents and skills under `deprecated/` are likewise not part of the active inventory.

## Structure

```text
.codex/
  AGENTS.md
  agents/      # active custom agent profiles
  skills/      # active skills
deprecated/
  agents/      # archived profiles; not loaded
  skills/      # archived skills; not loaded
```

## Recommended Operational Flow

Use these skills when the work carries decision, domain, or implementation risk:

```text
grill-code -> code-planner -> agent-hive
```

- `grill-code`: validates understanding, terms, domain boundaries, and architectural decisions.
- `code-planner`: turns the validated understanding into a closed implementation plan.
- `agent-hive`: executes the plan with best-fit native or custom roles, assignment-scoped ownership, and risk-based independent verification.

Not every case needs all three. For simple changes, direct execution, proportional validation, and coordinator review are usually enough. Use a separate `reviewer` only when independent verification materially reduces risk. For complex changes, use the full flow.

## code-planner

Use when you want to plan before editing code.

Ideal cases:

- non-trivial feature;
- bug with uncertain cause;
- change that affects APIs, contracts, schemas, permissions, or persistence;
- refactor with regression risk;
- migration between patterns or libraries;
- when you want a plan another agent can implement without re-planning.

Workflow:

1. Explore the code without modifying files.
2. Identify current behavior, local patterns, and risks.
3. Ask questions only about material ambiguities.
4. Define scope, out-of-scope items, and expected success.
5. Produce a final plan with summary, main changes, test plan, and assumptions.

When not to use:

- obvious one-line fix;
- purely textual change;
- task where the user already provided a closed plan and asked for direct execution.

## grill-code

Use when the problem needs to be questioned before becoming a plan or code.

Ideal cases:

- poorly defined domain;
- ambiguous names such as `account`, `order`, `cancellation`, or `session`;
- business rule with exceptions;
- change that may require an ADR;
- plan that looks correct but depends on undocumented invariants;
- before implementing something that changes responsibilities across modules.

Workflow:

1. Explore existing code and documentation.
2. Ask exactly one question at a time.
3. Recommend an answer, but wait for confirmation.
4. When a term, boundary, or invariant is resolved, record it in `docs/CONTEXT-{context-id}.md`.
5. When there is a relevant architectural decision, create an ADR in `docs/adr/`.
6. At the end, ask whether implementation may begin.

When not to use:

- when the domain is already clear;
- when the user only wants a review;
- when the change is purely mechanical.

## agent-hive

Use when work benefits from parallel delegation, durable progress, or independent verification tied to concrete risk.

Ideal cases:

- long or multi-step implementation;
- migration or refactor across independent modules;
- feature work that crosses layers;
- security, data-integrity, public-API, build, migration, concurrency, or failure-handling risk;
- work that can be divided into disjoint exploration, implementation, or verification assignments.

Workflow:

1. Create or reuse a verifiable goal and matching progress file.
2. Discover visible roles and record the best-fit selection for each material assignment.
3. Delegate standalone exploration to the native `explorer` or another exploration role when needed.
4. Delegate implementation and fixes to the native `worker` or another role explicitly designed for implementation.
5. Review returned work and validation evidence.
6. When concrete risk requires independence, use a fresh verifier that did not implement the change.
7. Select `reviewer` for general code verification or the narrow specialist matching the identified risk.
8. Correct rejected work, run proportional integration validation, and accept the phase only when its recorded gate passes.
9. Create checkpoint commits only when requested by the user or required by project instructions.
10. Close assignment-bound agents after their evidence is integrated.

Role selection:

- native `worker`: default delegated implementation and fixes;
- native `explorer`: default standalone read-only codebase exploration;
- `reviewer`: general independent code review;
- `code-reviewer-security`: security and high-risk correctness;
- `pr-test-analyzer`: behavioral test gaps;
- `silent-failure-hunter`: error and recovery paths;
- `type-design-analyzer`: domain types and invariants.

For ordinary low-risk work, tests, builds, lint, reproducible checks, and coordinator review may be the complete acceptance gate. Do not spawn a reviewer merely because implementation occurred.

## Quick Choice

- I want to plan before coding: `code-planner`
- I want to challenge a technical plan against the codebase: `grill-code`
- I want to clarify a product or design decision tree: `grill-me`
- I want to orchestrate parallel or high-risk work: `agent-hive`
- I want a general independent code review: `reviewer`
- I want a security-sensitive review: `code-reviewer-security`
- I want a test-gap review: `pr-test-analyzer`
- I want an error-recovery review: `silent-failure-hunter`
- I want a domain-type review: `type-design-analyzer`
- I explicitly want an especially strict maintainability audit: `$thermo-nuclear-code-quality-review`

## Recommended Flows

For a feature with uncertain domain:

```text
grill-code
-> code-planner when a decision-complete handoff is needed
-> agent-hive
   -> native explorer as needed
   -> native worker
   -> reviewer only when independent generic verification is justified
```

For authentication, authorization, billing, secrets, or feature-gate changes:

```text
code-planner
-> agent-hive
   -> native worker
   -> code-reviewer-security
```

For a large refactor:

```text
code-planner
-> agent-hive
   -> native workers with disjoint module ownership
   -> reviewer for material batches whose risk justifies independence
```

For an already written but suspicious plan:

```text
grill-code
-> agent-hive if execution is large
```

For targeted review risk, select the narrow specialist instead of stacking every reviewer. Use `$thermo-nuclear-code-quality-review` only when the user explicitly requests a deep maintainability audit.

## Usage

Copy or keep `.codex/` at the root of a workspace that should load these active agents and skills. The `deprecated/` directory is archival and should not be copied as active configuration. Native roles such as `worker` and `explorer` are supplied by Codex.
