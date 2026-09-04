---
name: create-spec
description: Create and persist a decision-complete implementation specification in `docs/PLAN-SPECS-{context-id}.md` as direct instructions for a downstream implementation task. Use when the user asks for a saved implementation plan or a detailed technical specification that an implementation agent or harness can execute without redesigning it. Do not use for implementation-only requests or brief, answer-only planning advice.
---

# Create Spec

Create a repository-grounded specification for the user's requested implementation, save it in the required location, and stop after handing off the completed plan. The specification is an execution contract for the downstream implementation task, not a user-facing explanation or a brainstorming document.

## Operating Contract

- This is a planning and documentation workflow. Do not implement production code, change application behavior, edit tests, or alter configuration while using it.
- Creating or revising the active plan file is the only repository mutation allowed by this workflow.
- If the request combines planning and implementation, complete and hand off the specification first. Implementation requires a subsequent explicit request.
- Preserve the requested scope. Do not add features, refactors, abstractions, migrations, or cleanup that are not required for the stated outcome.
- A final specification must be decision-complete. It must not leave material choices, alternatives, TODOs, or unresolved questions for the implementer.
- Optimize the document for implementation execution. Include only context, evidence, decisions, boundaries, concrete changes, dependencies, and gates that affect implementation.
- Avoid executive framing, pedagogical background, persuasive prose, repeated rationale, and explanations whose only purpose is to help a non-implementing reader understand the project.

## Workflow

### 1. Understand the request

Identify the intended outcome, users or callers affected, in-scope behavior, constraints, terminal completion conditions, and explicit exclusions. Read applicable repository instructions before investigating the solution.

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

## Core Structure and Dynamic Sections

Write the entire specification in the user's language unless they request another language. Translate every heading, label, status, instruction, and fixed constraint in the template into the document language. The English text below defines the required structure and semantics; copy it literally only when the document language is English.

Use direct, practical technical writing rather than the tone of a formal standards document. Do not introduce identifier catalogs, cross-reference matrices, or bookkeeping sections disconnected from the implementation phases.

Write for the downstream implementation task, regardless of which agent or harness will execute it. Prefer exact paths, symbols, contracts, state changes, constraints, and executable gates over narrative written for a user or stakeholder. Include background only when omitting it would cause an implementation mistake.

The template below is a core scaffold, not a closed document schema. Derive any additional sections from the current request, the explored system, and the decisions needed for implementation:

- Create zero or more dynamic sections when a cohesive subject is shared by multiple phases, establishes a contract those phases depend on, or is too complex to repeat safely inside phase descriptions.
- Name dynamic sections using the language and concepts of the current problem. There is no predefined catalog of allowed or expected dynamic section names.
- Use whatever Markdown structure best communicates that subject, including nested headings, tables, diagrams, formulas, code blocks, state descriptions, or protocol details when they materially improve implementation clarity.
- Do not create a dynamic section when the content belongs naturally in one phase or when a short specification does not need it.
- Never copy the section tree, headings, ordering, depth, or level of detail from an example or reference document merely because it was inspected. Reference documents provide evidence and constraints, not a template, unless the user explicitly asks to reproduce their structure.

### Content Ownership

Assign every implementation rule, decision, or constraint to one canonical location.

- Dynamic sections own contracts, invariants, protocols, schemas, or behavior shared by multiple phases.
- Implementation phases must reference the owning dynamic section by heading and describe only where and how that contract is implemented, including affected paths, symbols, dependencies, and phase-local boundaries.
- `Advance only when` blocks contain observable proof that the contract was implemented; they must not restate the contract.
- Content used by only one phase belongs directly in that phase and does not justify a dynamic section.
- Never repeat or paraphrase a rule in multiple sections. Use a short reference to its canonical section instead.

Use this core Markdown scaffold and extend it only where the current problem requires. Replace every bracketed placeholder with concrete specification content and do not include the outer code fence in the saved file.

```markdown
## Specification Title

**Title:** [Precise implementation-oriented title]
**Context ID:** `[YYYY-MM-DD-short-kebab-slug]`
**Created:** [YYYY-MM-DD]
**Status:** Ready for implementation

## Implementation Context

[State the requested outcome, relevant current behavior, exact change from current to desired behavior, architectural constraints, and final implementation state in compact, direct prose. Include only context the downstream implementation task needs to make correct changes. Clearly distinguish observed facts from user-confirmed intent.]

**Relevant evidence**

- `[repository-relative/path:line-or-symbol]` - [What this evidence establishes]
- [Authoritative external source, version, or access date when applicable]

## Scope

- [Included behavior, component, integration, or data change]
- [Concrete implementation deliverable]

## Out of Scope

- [Explicit non-goal or adjacent work that must not be performed]

[Insert zero or more problem-specific `##` sections here when the implementation needs shared contracts or explanations beyond the phase descriptions. Choose every title and internal structure from the current problem. Remove this instruction when no dynamic section is needed.]

## Implementation Stages

### Phase 1 — [Cohesive phase name]

**Preconditions**

- [Earlier phase output or external condition; use `None` when independent]

**Deliverables and boundary**

- [Describe the concrete files, symbols, and implementation work owned by this phase. When behavior is defined in a dynamic section, reference that section by heading instead of repeating its rules.]
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

- [Describe the concrete files, symbols, and implementation work owned by this phase. When behavior is defined in a dynamic section, reference that section by heading instead of repeating its rules.]

[State in a short paragraph what this phase deliberately excludes.]

**Can run in parallel with:**

- [Other phase numbers and rationale, or `None`]

**Advance only when**

- [Concrete observable condition or verification gate]

[Add only the additional cohesive phases required to cover the scope.]

## Testing Decisions

[If the user explicitly requested unit tests, specify only the exact unit-test scope and cases to create or change. Otherwise write only this sentence, translated into the document language: **Creating new unit tests is prohibited for this implementation.** Do not include build commands, existing test commands, integration tests, end-to-end tests, manual scenarios, runtime checks, or any other validation content in this section.]

## Done When

[Write one direct terminal rule in natural prose. State that the implementation task may be marked complete only when the full requested outcome exists, every phase's `Advance only when` conditions have passed, applicable final integration behavior is proven, and all scope boundaries still hold. Include any task-specific end-state conditions that cannot be inferred from individual phase gates. If any condition is unproven, the task remains incomplete or blocked and must not be reported as complete. Do not use a table, numbered list, checklist, identifiers, or stakeholder-oriented acceptance language.]

## Implementation Rules

- Implement exactly the approved specification and do not expand its scope.
- Preserve unrelated user changes and avoid unrelated refactors or formatting.
- If implementation evidence contradicts this specification, or completing the work requires behavior or changes outside its scope, stop before diverging and ask the user exactly one question. Present the evidence, impact, viable choices, and a recommendation.
- Do not treat a recommendation as authorization. Wait for the user's answer and revise this specification when the approved direction changes it.
```

### Template Completion Rules

- Keep the core second-level sections shown in the scaffold. Add, remove, name, and organize dynamic sections according to the current problem rather than a fixed catalog.
- Usually place shared design material before `Implementation Stages`, then keep implementation phases, testing decisions, `Done When`, and implementation rules in a direct execution order. Depart from that order when the problem genuinely reads more clearly another way.
- If a required subject genuinely does not apply, replace its placeholder with the document-language equivalent of `Not applicable` and a brief reason. Do not leave a section blank.
- Remove unused example phases and every bracketed instruction. The final file must read as a completed specification, not as a partially filled template.
- Use `Relevant evidence` as the only evidence index. Cite concrete repository-relative paths and symbols there when they establish implementation context, and include versions or access dates for external sources when freshness matters. Do not create a separate `References` section or duplicate the same evidence in another index.
- Keep phases cohesive rather than creating a phase for each trivial edit. Each phase must contain enough detail to implement its slice on its own, and the phases together must cover all in-scope behavior without adding out-of-scope work.
- Express dependencies, safe parallel work, and readiness gates inside each phase. Put all build commands, existing test commands, integration or end-to-end checks, manual scenarios, runtime observations, and other non-unit verification in the applicable `Advance only when` blocks. Do not add a separate dependency matrix, validation section, or cross-reference section.
- Do not create a standalone risk summary. Put a material implementation hazard only in the phase precondition, boundary, or advance gate that must control it.
- Add a dynamic section only when it reduces ambiguity or prevents cross-phase duplication. Do not add one merely to make the document look comprehensive.
- Add a dynamic decisions section only when a user-confirmed or externally constrained choice affects multiple phases and would otherwise be easy to miss. Omit it when each decision is already explicit in `Implementation Context`, scope boundaries, a problem-specific contract, or a phase. Never repeat those decisions in a separate summary.
- Treat inspected specifications and documentation as sources of facts, constraints, and terminology only. Do not imitate their structure unless the user explicitly requests that structure.
- Keep `Testing Decisions` exclusively about unit tests. If the user explicitly requested them, replace the default prohibition with their exact intended scope and cases. Otherwise include the translated prohibition as the section's only content and do not add unit-test creation to any phase or `Done When`. Running existing unit tests may still appear in a relevant phase gate as a regression check.
- Write `Done When` as a terminal completion rule for the downstream task, not as stakeholder-facing acceptance prose. It must prevent the executor from marking the task complete while any required end state or phase gate remains unproven.
- Include all four implementation rules translated into the document language without weakening them.

## Quality Check and Handoff

Before reporting completion, reread the saved file and verify that:

- every requested behavior is covered by the implementation phases and the `Done When` terminal rule;
- no material choice, placeholder, TODO, or unresolved question remains;
- dependencies, safe parallel work, and advance conditions are explicit inside the phases and internally consistent;
- `Testing Decisions` contains only the correct unit-test decision and no other validation content;
- `Relevant evidence` is the sole evidence index and no duplicate `References` section exists;
- no identifier catalogs, cross-reference matrices, or extra bookkeeping sections remain;
- every dynamic section is justified by the current problem and is not structural imitation of a reference document;
- no decisions section repeats choices already stated in the implementation context, scope, shared contracts, or phases;
- every rule has one canonical location, and phases reference shared contracts without restating or paraphrasing them;
- phase-specific details have not been pulled into standalone sections without reason;
- no standalone risk summary exists, and implementation-critical hazards appear only where they constrain a phase;
- `Done When` clearly forbids completion until every terminal condition is proven and is written as direct prose rather than a table or list;
- the plan does not extend beyond the request;
- the saved path follows the required naming convention.

Then respond with only a short summary of the specification's outcome and key boundaries, plus a clickable link to the saved plan. Do not paste the full specification into the response.
