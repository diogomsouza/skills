---
name: create-spec
description: Create and persist a decision-complete implementation specification in `docs/PLAN-SPECS-{context-id}.md`. Use when the user asks for a saved implementation plan or a detailed technical specification that another engineer or agent can execute without redesigning it. Do not use for implementation-only requests or brief, answer-only planning advice.
---

# Create Spec

Create a repository-grounded specification for the user's requested implementation, save it in the required location, and stop after handing off the completed plan. The specification is the implementation contract, not a brainstorming document.

## Operating Contract

- This is a planning and documentation workflow. Do not implement production code, change application behavior, edit tests, or alter configuration while using it.
- Creating or revising the active plan file is the only repository mutation allowed by this workflow.
- If the request combines planning and implementation, complete and hand off the specification first. Implementation requires a subsequent explicit request.
- Preserve the requested scope. Do not add features, refactors, abstractions, migrations, or cleanup that are not required for the stated outcome.
- A final specification must be decision-complete. It must not leave material choices, alternatives, TODOs, or unresolved questions for the implementer.

## Workflow

### 1. Understand the request

Identify the intended outcome, users or callers affected, in-scope behavior, constraints, acceptance signals, and explicit exclusions. Read applicable repository instructions before investigating the solution.

Treat an existing-system change differently from greenfield work: current code establishes the implementation context and constraints, but it does not override the user's desired behavior.

### 2. Resolve discoverable facts before asking questions

For changes to an existing system, inspect the relevant code before writing the specification. Locate the entry points, related components, contracts, schemas, configuration, dependencies, existing validation, and established implementation patterns needed to make the plan concrete. Cite repository-relative paths and symbols where they remove ambiguity.

- Use targeted local exploration for a contained change.
- When the investigation is broad enough to benefit from delegation and an explorer agent is available, delegate a read-only, bounded fact-gathering task. Configure that explorer to **use the most cost-efficient suitable model**; its role is to locate and report evidence, not to perform the specification's reasoning or make product, architecture, or scope decisions.
- The root agent owns all analysis of the explorer's return. Review the reported paths, symbols, current behavior, conflicts, and unknowns; verify material claims against the repository; resolve contradictions; and decide how the evidence affects the specification. Never adopt the explorer's conclusions without this root-agent analysis.
- Research the internet only when current or external authoritative information is necessary to design the requested change. Prefer primary documentation, record the relevant version or date when available, and link the sources in the specification.
- Never ask the user for a fact that can be answered reliably from the repository, supplied material, or authoritative documentation.

### 3. Clarify only material blockers

Pause before finalizing the specification when the request conflicts with the observed system or when a missing decision would materially change behavior, contracts, data, user experience, architecture, compatibility, security, rollout, or implementation ownership.

Ask exactly one question at a time and wait for the answer. Each question must:

1. State the relevant discovered fact, conflict, or uncertainty.
2. Explain briefly why the answer affects the implementation.
3. Provide the viable choices when choices are known.
4. Include a clearly labeled recommendation and its rationale.

Do not turn clarification into a general interview. Ask only what blocks a decision-complete specification, continue exploration whenever it can resolve the uncertainty, and stop asking as soon as the remaining details can be specified safely. Never silently select a material option.

Do not write the final plan while a blocking question remains unanswered. After the user answers, incorporate the decision and ask another question only if a separate material blocker remains.

### 4. Design the smallest complete solution

Choose the simplest approach that fully satisfies the request and fits the observed architecture. Make behavior, component responsibilities, interfaces, data flow, validation, error handling, compatibility, and operational concerns explicit wherever they affect implementation.

Separate the work into cohesive implementation phases. Do not create micro-phases for individual trivial edits. Each phase must act as the detailed specification for that slice of work, using the following shape:

- **Preconditions** state what must already exist or be true.
- **Deliverables and boundary** describe exactly what the phase implements and what it deliberately does not include.
- **Can run in parallel with** identifies independent phases when parallel work is safe.
- **Advance only when** defines the concrete evidence required before dependent work may begin.

The dependency information must make a safe execution order obvious without forcing independent work to run sequentially.

### 5. Save the specification

Build `context-id` as `YYYY-MM-DD-{short-kebab-slug}` using the current local date when available, otherwise UTC. The slug must be lowercase, concise, and identify the requested outcome. Use three to six meaningful words when practical.

Save the completed specification at the repository root as:

```text
docs/PLAN-SPECS-{context-id}.md
```

Create `docs/` when it does not exist. For an explicit revision of the same active plan, update that file. For a new request whose candidate filename already exists, preserve the existing file and append the smallest available numeric suffix to the slug, such as `-2`.

## Required Specification Structure

Write the entire specification in the user's language unless they request another language. Translate every heading, label, status, instruction, and fixed constraint in the template into the document language. The English text below defines the required structure and semantics; copy it literally only when the document language is English.

Use direct, practical technical writing rather than the tone of a formal standards document. Do not introduce identifier catalogs, cross-reference matrices, or bookkeeping sections disconnected from the implementation phases.

Use this complete Markdown template. Replace every bracketed placeholder with concrete specification content and do not include the outer code fence in the saved file.

```markdown
## Specification Title

**Title:** [Precise implementation-oriented title]
**Context ID:** `[YYYY-MM-DD-short-kebab-slug]`
**Created:** [YYYY-MM-DD]
**Status:** Ready for implementation

## Summary

[Summarize the requested outcome, selected solution, and expected system impact.]

## Context and Current State

[Describe the relevant existing behavior, desired change, architecture, and discovered constraints in direct prose. Clearly distinguish observed facts from user-confirmed intent.]

**Relevant evidence**

- `[repository-relative/path:line-or-symbol]` - [What this evidence establishes]
- [Authoritative external source, version, or access date when applicable]

## Goal

[Define the problem to solve and the exact end state.]

## Scope

- [Included behavior, component, integration, or data change]
- [Concrete implementation deliverable]

## Out of Scope

- [Explicit non-goal or adjacent work that must not be performed]

## Confirmed Decisions

- **[Decision]:** [Confirmed choice and its evidence or rationale]

## Technical Approach

### System Design

[Describe the design and responsibility boundaries in enough detail to remove architectural guesswork.]

### Affected Areas

- `[path or symbol]` - [Current responsibility and exact planned change]

### Contracts and Data

[Specify APIs, events, commands, interfaces, schemas, persistence, migrations, and compatibility behavior.]

## Implementation Stages

### Phase 1 — [Cohesive phase name]

**Preconditions**

- [Earlier phase output or external condition; use `None` when independent]

**Deliverables and boundary**

- [Exact behavior, component, contract, data change, validation, or failure handling implemented in this phase]
- [Additional concrete deliverable]

[State in a short paragraph what this phase deliberately excludes.]

**Can run in parallel with:**

- [Other phase numbers and the reason parallel work is safe, or `None`]

**Advance only when**

- [Concrete observable condition or verification gate]
- [Additional condition required before dependent work starts]

### Phase 2 — [Cohesive phase name]

**Preconditions**

- [Dependency on an earlier phase or external condition]

**Deliverables and boundary**

- [Exact behavior and changes implemented in this phase]

[State in a short paragraph what this phase deliberately excludes.]

**Can run in parallel with:**

- [Other phase numbers and rationale, or `None`]

**Advance only when**

- [Concrete observable condition or verification gate]

[Add only the additional cohesive phases required to cover the scope.]

## Validation

[Describe the concrete commands, existing checks, runtime observations, or focused scenarios that prove the implementation works. Tie them naturally to the relevant phases and risks without adding bookkeeping sections or splitting validation by type.]

**Unit-test policy:** [If unit tests were explicitly requested, define their exact coverage. Otherwise write, translated into the document language: **Creating new unit tests is prohibited for this implementation.**]

## Acceptance Criteria

[Write cohesive prose describing what must be observably true for the work to be accepted. Cover the requested outcome, important failure behavior, and applicable quality constraints without a table, numbered list, identifiers, or cross-reference notation.]

## Risks and Mitigations

[Write concise narrative prose about the realistic risks, their impact, and how the implementation will avoid or detect them. Do not use a table, numbered list, severity labels, or risk identifiers.]

## References

- `[repository-relative/path:line-or-symbol]` - [Why it matters]
- [Authoritative external source] - [Version or access date and relevance]

## Implementation Rules

- Implement exactly the approved specification and do not expand its scope.
- Preserve unrelated user changes and avoid unrelated refactors or formatting.
- If implementation evidence contradicts this specification, or completing the work requires behavior or changes outside its scope, stop before diverging and ask the user exactly one question. Present the evidence, impact, viable choices, and a recommendation.
- Do not treat a recommendation as authorization. Wait for the user's answer and revise this specification when the approved direction changes it.
```

### Template Completion Rules

- Keep every second-level section shown in the template and preserve their order. Add third-level subsections only when they materially improve precision.
- If a required subject genuinely does not apply, replace its placeholder with the document-language equivalent of `Not applicable` and a brief reason. Do not leave a section blank.
- Remove unused example phases and every bracketed instruction. The final file must read as a completed specification, not as a partially filled template.
- Cite concrete repository-relative paths and symbols when they remove ambiguity. Include versions or access dates for external sources when freshness matters.
- Keep phases cohesive rather than creating a phase for each trivial edit. Each phase must contain enough detail to implement its slice on its own, and the phases together must cover all in-scope behavior without adding out-of-scope work.
- Express dependencies, safe parallel work, and readiness gates inside each phase. Do not add a separate dependency matrix or cross-reference section.
- If the user explicitly requested unit tests, replace the default prohibition with exact unit-test coverage. Otherwise include the translated prohibition exactly once and do not add unit-test creation to any stage or acceptance criterion. Running existing unit tests remains allowed as a regression check.
- Write `Acceptance Criteria` and `Risks and Mitigations` as natural prose. Do not turn either section into a table, numbered list, checklist, or identifier system.
- Include all four implementation rules translated into the document language without weakening them.

## Quality Check and Handoff

Before reporting completion, reread the saved file and verify that:

- every requested behavior is covered by the implementation phases, validation, and acceptance prose;
- no material choice, placeholder, TODO, or unresolved question remains;
- dependencies, safe parallel work, and advance conditions are explicit inside the phases and internally consistent;
- the unit-test rule matches whether the user explicitly requested unit tests;
- no identifier catalogs, cross-reference matrices, or extra bookkeeping sections remain;
- acceptance criteria and risks are written as narrative prose rather than tables or numbered lists;
- the plan does not extend beyond the request;
- the saved path follows the required naming convention.

Then respond with only a short summary of the specification's outcome and key boundaries, plus a clickable link to the saved plan. Do not paste the full specification into the response.
