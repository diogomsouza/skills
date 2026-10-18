# grill-code

Grill Code stress-tests a technical plan through an interview grounded in the current codebase and explicitly referenced documentation. It asks one material decision at a time, explains the available options and tradeoffs, and recommends an answer without treating that recommendation as accepted.

Each new session creates an isolated specification at `docs/SPEC-{context-id}.md` and a domain glossary at `docs/CONTEXT-{context-id}.md`. Confirmed decisions update those documents as the conversation progresses. Qualifying architectural decisions also receive an ADR. Inactive specification and context files from other sessions are excluded from investigation.

Use it when a plan needs to be challenged before development, especially when behavior, ownership, terminology, or failure handling remains uncertain. It separates observed behavior, proposed behavior, and decisions explicitly confirmed by the user.

The outcome is a documented plan and glossary ready for handoff once material blockers are resolved. Implementation requires explicit approval after the grilling session, including when the initial request also asked for implementation. Merely reviewing or editing the skill does not activate the interview.

- [Source definition](../../codex/skills/grill-code/SKILL.md)
- [Specification format](../../codex/skills/grill-code/SPEC-FORMAT.md)
- [Glossary format](../../codex/skills/grill-code/CONTEXT-FORMAT.md)
- [ADR format](../../codex/skills/grill-code/ADR-FORMAT.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
