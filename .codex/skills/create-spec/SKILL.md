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
- Optimize the document for implementation execution. Include only context, evidence, decisions, boundaries, concrete changes, dependencies, and completion checkpoints that affect implementation.
- Avoid executive framing, pedagogical background, persuasive prose, repeated rationale, and explanations whose only purpose is to help a non-implementing reader understand the project.

## Workflow

### 1. Understand the request

Identify the intended outcome, users or callers affected, in-scope behavior, constraints, terminal completion conditions, and explicit exclusions. Read applicable repository instructions before investigating the solution.

Treat an existing-system change differently from greenfield work: current code establishes the implementation context and constraints, but it does not override the user's desired behavior.

### 2. Resolve discoverable facts before asking questions

For changes to an existing system, inspect the relevant code before writing the specification. Locate the entry points, related components, contracts, schemas, configuration, dependencies, existing input and data validation, and established implementation patterns needed to make the plan concrete. Cite repository-relative paths and symbols where they remove ambiguity.

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

Choose the simplest approach that fully satisfies the request and fits the observed architecture. Make behavior, component responsibilities, interfaces, data flow, input and data validation, failure handling, compatibility, and runtime constraints explicit wherever they affect implementation.

Separate the work into cohesive implementation phases. Do not create micro-phases for individual trivial edits. Each phase must act as the detailed specification for that slice of work, using the following shape:

- Begin with one short, unlabeled paragraph stating the phase's purpose, the cohesive implementation outcome it owns, and the state it establishes for dependent phases or as the final implementation state. Keep this overview at the capability or architectural level. Do not list files, symbols, or technical steps, and do not merely repeat the phase title or the detailed implementation below.
- **Preconditions** list only hard blockers whose absence prevents the phase from starting. Name an earlier phase only when the current phase cannot begin until that phase's implementation output is complete; ordinal position, a contract already fixed by the specification, or a dependency needed only for later integration is not sufficient. If the phase can begin independently, write `None`, translated into the document language, and describe any later handoff or integration ordering under **Technical implementation** or **Can run in parallel with**. Never list work, contracts, decisions, or artifacts that the current phase must create.
- **Technical implementation** is the decision-complete technical specification for the phase, not an inventory of files or expected outputs. Explain what must be implemented and how it must work within the existing system, with enough detail that the implementer does not need to design the solution. Where applicable, cover concrete paths and symbols, component responsibilities, control and data flow, interfaces and contracts, state changes, input and data validation, failure behavior, integration points, compatibility constraints, and correctness-sensitive ordering. Include only details relevant to the phase, but do not reduce the section to a checklist of changes. Paths and symbols anchor the explanation; they do not replace it. End with a concise statement of what the phase deliberately leaves unchanged or assigns to another phase.
- **Can run in parallel with** identifies phases that can start or make bounded progress concurrently and explains the safe concurrency boundary or later handoff. A phase whose completed output is a hard precondition cannot also be listed here.
- **Advance only when** is one concise phase-completion checkpoint confirming that the phase's specified technical implementation is complete, its boundary is respected, and no phase-local work remains before dependent work begins. It is not a test or validation plan.

The dependency information must make a safe execution order obvious without forcing independent work to run sequentially.

### 5. Save the specification

Build `context-id` as `YYYY-MM-DD-{short-kebab-slug}` using the current local date when available, otherwise UTC. The slug must be lowercase, concise, and identify the requested outcome. Use three to six meaningful words when practical.

Record `Created` as the current local date and time in ISO 8601 format, including seconds and an explicit UTC offset, for example `2026-09-04T09:57:00-03:00`.

Save the completed specification at the repository root as:

```text
docs/PLAN-SPECS-{context-id}.md
```

Create `docs/` when it does not exist. For an explicit revision of the same active plan, update that file. For a new request whose candidate filename already exists, preserve the existing file and append the smallest available numeric suffix to the slug, such as `-2`.

## Core Structure and Dynamic Sections

Write the entire specification in the user's language unless they request another language. Translate every heading, label, instruction, and fixed constraint in the template into the document language. The English text below defines the required structure and semantics; copy it literally only when the document language is English.

The template below is a core scaffold, not a closed document schema. The core scaffold is the default document structure. After understanding the request and the existing system, determine whether all information required for implementation has a clear and natural place in the core sections.

- Add zero or more dynamic sections only when required implementation information cannot be expressed clearly and completely within the core scaffold without distorting the purpose of its sections.
- Dynamic sections have no predefined subject, category, title, structure, or expected content. Derive them exclusively from what the current specification requires.
- Use whatever Markdown structure communicates the required information most precisely, including nested headings, tables, diagrams, formulas, code blocks, state descriptions, or protocol details when they materially improve implementation clarity.
- Do not create a dynamic section merely because a subject is important, complex, shared by multiple phases, or would make the document appear more complete. If the core scaffold is sufficient, create no dynamic sections.
- Never copy the section tree, headings, ordering, depth, or level of detail from an example or reference document merely because it was inspected. Reference documents provide evidence and constraints, not a template, unless the user explicitly asks to reproduce their structure.

### Content Ownership

Assign every implementation rule, decision, or constraint to one canonical location.

- A dynamic section owns only the information whose absence from the core scaffold required that section to be created.
- When an implementation phase depends on information defined in a dynamic section, reference that section by heading instead of repeating or paraphrasing it.
- When no dynamic section exists, place all implementation details directly in the appropriate core sections and phases.
- Never move phase-specific information into a dynamic section solely to reduce the size of a phase.
- Never repeat or paraphrase a rule in multiple sections. Use a short reference to its canonical section instead.

Use this core Markdown scaffold and extend it only where the current problem requires. Replace every bracketed placeholder with concrete specification content and do not include the outer code fence in the saved file.

```markdown
# [Outcome-specific specification title]

**Context ID:** `[YYYY-MM-DD-short-kebab-slug]`
**Created:** `[YYYY-MM-DDTHH:mm:ss±HH:mm]`

## Implementation Context

[State the requested outcome, relevant current behavior, exact change from current to desired behavior, architectural constraints, and final implementation state in compact, direct prose. Include only context the downstream implementation task needs to make correct changes. Clearly distinguish observed facts from user-confirmed intent.]

**Relevant evidence**

- `[repository-relative/path:line-or-symbol]` - [What this evidence establishes]
- [Authoritative external source, version, or access date when applicable]

## Scope

- [Included outcome, behavior, affected area, integration, or data boundary; do not repeat phase implementation details]

## Out of Scope

- [Explicit non-goal or adjacent work that must not be performed]

[Insert zero or more problem-specific `##` sections here or elsewhere where their content naturally belongs, but only when required implementation information has no clear place in the core scaffold. Remove this instruction when no dynamic section is necessary.]

## Implementation Stages

### Phase 1 — [Cohesive phase name]

[In one short paragraph, explain the phase's purpose, the cohesive implementation outcome it owns, and the state it establishes for dependent phases or as the final implementation state. Do not list files, symbols, or technical steps, and do not repeat the phase title or the detailed implementation below.]

**Preconditions**

- [Only hard blockers whose absence prevents this phase from starting. Name an earlier phase only when this phase cannot begin until its implementation output is complete; otherwise use `None`. Never list work owned by this phase or a phase also named under parallel execution.]

**Technical implementation**

- [Specify in technical detail what this phase must implement and how it must work in the existing system. Use concrete paths and symbols as anchors where known, and describe the applicable responsibilities, behavior, control or data flow, contracts, state changes, validation, failure handling, integrations, compatibility constraints, and correctness-sensitive ordering. Make every material implementation decision explicit; do not write a file checklist or output inventory. When a dynamic section owns a rule, reference it by heading instead of repeating it.]
- [Add whatever paragraphs, bullets, tables, diagrams, formulas, state descriptions, or code-shaped contracts are necessary to make this phase executable without further solution design.]

[End with a short boundary statement identifying what this phase deliberately leaves unchanged or assigns to another phase.]

**Can run in parallel with:**

- [Other phase numbers, the safe concurrency boundary or later handoff, or `None`. Do not name a phase that is a hard precondition.]

**Advance only when**

[Write one short sentence confirming that the technical implementation specified for this phase is complete, integrated where required, respects its boundary, and has no remaining phase-local work. Do not list tests, commands, scenarios, evidence, or repeat requirements.]

[Repeat the phase structure only for the additional cohesive phases required to cover the scope.]

## Testing Decisions

[If the user explicitly requested unit tests, specify only the exact unit-test scope and cases to create or change. Otherwise write only this sentence, translated into the document language: **Creating new unit tests is prohibited for this implementation.** Include nothing about non-unit testing or other validation work in this section.]

## Done When

[Write one short terminal rule in natural prose. The implementation task may be marked complete only when the full requested outcome exists, every phase-completion checkpoint is satisfied, and all scope boundaries still hold. If any condition remains unsatisfied, the task is incomplete or blocked. Do not restate phase implementation details or use a table, list, checklist, identifiers, validation evidence, or stakeholder-oriented acceptance language.]

## Implementation Rules

- Implement exactly the approved specification and do not expand its scope.
- Preserve unrelated user changes and avoid unrelated refactors or formatting.
- If implementation evidence contradicts this specification, or completing the work requires behavior or changes outside its scope, stop before diverging and ask the user exactly one question. Present the evidence, impact, viable choices, and a recommendation.
- Do not treat a recommendation as authorization. Wait for the user's answer and revise this specification when the approved direction changes it.
```

### Template Completion Rules

- Keep the core second-level sections shown in the scaffold. Place any necessary dynamic section where its information is needed most clearly without changing the relative execution order of the core sections.
- If a required subject genuinely does not apply, replace its placeholder with the document-language equivalent of `Not applicable` and a brief reason. Do not leave a section blank.
- Remove every bracketed instruction. The final file must read as a completed specification, not as a partially filled template.
- Use `Relevant evidence` as the only evidence index. Cite concrete repository-relative paths and symbols there when they establish implementation context, and include versions or access dates for external sources when freshness matters. Do not create a separate `References` section or duplicate the same evidence in another index.
- Do not prescribe build commands, test execution, manual scenarios, runtime checks, or other validation activities unless the user explicitly requests them. An explicitly requested non-unit test change belongs in its owning implementation phase, never in `Testing Decisions` or `Advance only when`.
- Do not create a standalone risk summary. Put a material implementation hazard only in the phase precondition or boundary that must control it.
- Include all four implementation rules translated into the document language without weakening them.

## Quality Check and Handoff

Before reporting completion, reread the saved file and verify that:

- all requested behavior is covered without scope expansion, and no material choice, placeholder, TODO, or unresolved question remains;
- each phase begins with a concise purpose and outcome overview that orients the implementation without repeating its title or technical details and describes either the state provided to dependent phases or the final implementation state;
- the phases are cohesive, complete, correctly ordered by their dependencies, and explicit about safe parallel work; every precondition genuinely blocks the phase from starting, independently startable phases state `None`, and no phase appears both as a hard precondition and as parallel work;
- every `Technical implementation` section explains in sufficient technical detail what must be implemented and how it must work, rather than serving as a file checklist or output inventory;
- every `Advance only when` block is one short completion summary without tests, commands, scenarios, evidence, or repeated requirements;
- `Testing Decisions` contains only the correct unit-test decision, and no unsolicited validation plan appears elsewhere;
- `Relevant evidence` is the sole evidence index, and no identifier catalog, cross-reference matrix, standalone risk summary, or other bookkeeping section remains;
- every dynamic section is necessary because the core scaffold is insufficient, and every rule has one canonical location without repetition or paraphrase;
- `Done When` is a short terminal rule that leaves the task incomplete or blocked while any required end state or phase checkpoint remains unsatisfied;
- the saved path follows the required naming convention, and `Created` contains a full ISO 8601 timestamp with seconds and an explicit UTC offset.

Then respond with only a short summary of the specification's outcome and key boundaries, plus a clickable link to the saved plan. Do not paste the full specification into the response.
