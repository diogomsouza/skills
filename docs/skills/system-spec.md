# System Spec

**Turn system knowledge into documentation readers can understand and use.**

System Spec creates or revises saved documentation for a defined audience and purpose. It can explain architecture, describe an existing feature, teach a user workflow, document operations, or provide a reproducible test procedure.

The skill investigates the relevant repository and sources before writing. It makes a clear distinction between observed implementation, approved design, and intended future behavior, so readers can tell whether a statement describes what exists or what is planned.

## Choose the document by its purpose

A document's title does not decide whether this workflow applies. What matters is the work its reader needs to do.

| Reader's need | Appropriate deliverable |
| --- | --- |
| Understand components and their responsibilities | Technical reference or architecture description |
| Learn an existing feature | User guide |
| Operate or recover a system | Operational procedure |
| Check an existing workflow | Test documentation with actions and expected results |
| Implement a new behavior or software change | Use [Tech Spec](tech-spec.md) instead |

System documentation can discuss an existing, recently changed, or planned system. Planned capabilities must be identified as planned; documentation cannot imply that writing about a feature implemented it.

## Ground the explanations in evidence

The workflow first establishes purpose, audience, scope, and completion conditions. It inspects the relevant entry points, components, contracts, configuration, dependencies, and existing documentation to the depth needed for accurate explanations.

Current code is evidence of implementation behavior. Requirements and approved designs may establish different intended behavior. When those sources disagree, the skill explains or resolves the conflict instead of silently choosing one based on its file type or title.

Focused, safe exploratory checks can help establish a fact. They do not authorize changes to production code, shared data, configuration, or live systems. A check performed while writing also does not prove that every procedure described in the document has been executed.

Material references are placed beside the explanations they support. The reader should be able to see what a source establishes without navigating an unrelated evidence inventory.

## Resolve uncertainty without turning writing into an interview

Discoverable facts are investigated before asking the user. Questions are reserved for an unresolved choice that materially changes the document's purpose, scope, factual interpretation, or usable instructions.

When a question is necessary, it presents the discovered issue, its consequence, viable options, and a recommendation. The skill asks one atomic decision at a time and waits for the answer. Routine choices about wording and equivalent presentation remain with the author.

A fact does not become true merely because it is called an assumption. For example, a recovery guide cannot describe an operation as reversible unless sources or suitable evidence establish that property.

## Write for the intended reader

There is no mandatory section tree. A concise reference, a teaching guide, and an operational runbook need different organization and levels of detail.

The document includes the context, examples, constraints, and explanations that support its purpose. Procedures make prerequisites, ordering, inputs, expected results, and material failure conditions explicit. Safeguards belong beside the operation that needs them.

For example, a guide to resuming an interrupted import should explain how to identify the interrupted run, what state must still exist, what resumption does, and how completion or failure is observed. It should not require the reader to invent those conditions.

Full definitions are kept in one canonical place, with references or brief reminders where they help readers consult sections independently.

## Save and independently review the result

The default filename is `docs/SPECS-{context-id}.md`. A context identifier and creation timestamp identify the document, and a new request does not overwrite a colliding file. An explicit revision updates the same active document.

Before handoff, an independent reviewer receives the saved candidate, its version, the actual requirements and decisions, and the relevant sources. It reads the document as its intended recipient and checks completeness, clarity, coherence, grounding, and fitness for use.

Confirmed blocking defects are corrected and the current saved version is reviewed again. Missing required evidence remains a blocker. The author cannot replace the reviewer's explicit `ACCEPT` with self-review or acceptance of an older version.

## Understand the implementation boundary

During authoring, the skill does not change application behavior, production code, tests, or configuration. For documentation-only requests, the task ends after the accepted document is handed off.

When the user also authorized other work, that work may continue after document acceptance, while preserving any explicit checkpoint the user requested. Independent document review is not a new request for user permission to perform work already authorized.

## Example requests

```text
Use $system-spec to document how the current import pipeline handles retries
and interrupted runs. Write for the on-call team and include concrete recovery steps.
```

```text
Use $system-spec to create a user guide for the existing export feature.
Explain available options and how users can confirm an export completed.
```

The handoff links the saved document, summarizes its purpose and boundaries, and identifies material limitations. A written procedure is kept distinct from a procedure actually exercised during authoring.

## Source and related guides

- [Skill definition](../../codex/skills/system-spec/SKILL.md) — evidence, writing, save, and review requirements.
- [Document Reviewer](../agents/document-reviewer.md) — the independent documentation-review role.
- [Tech Spec](tech-spec.md) — specifications directing software changes.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->