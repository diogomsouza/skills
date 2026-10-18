# system-spec

System Spec creates or revises saved system documentation for a defined purpose and audience. It covers technical references, architecture descriptions, user guides, operational procedures, and test documentation.

It investigates the repository and relevant sources, resolves material uncertainties, and chooses a structure suited to the document. Explanations distinguish observed implementation, approved design, and intended future behavior. Procedures include the prerequisites, actions, and expected results needed by the reader.

Use it when the deliverable explains a system, how to use or operate it, or how to verify it. A specification directing a future software change belongs to [tech-spec](tech-spec.md).

The default output is `docs/SPECS-{context-id}.md`, with a context identifier and creation timestamp. The current saved document must receive independent review and an explicit `ACCEPT` before handoff. Authoring itself does not change application code, tests, or configuration. When the request also authorizes other work, that work can continue after document acceptance, subject to any explicit user checkpoint.

- [Source definition](../../codex/skills/system-spec/SKILL.md)
- [Document reviewer](../agents/document-reviewer.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
