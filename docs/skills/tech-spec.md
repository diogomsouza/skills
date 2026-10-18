# tech-spec

Tech Spec creates a saved implementation specification for software to be built or changed. It turns a request for a new system, feature, bug fix, or maintenance change into a repository-grounded plan that a later implementation task can follow.

It establishes requirements, observable behavior, contracts, constraints, essential technical decisions, and concrete verification expectations. A contained change can use one implementation unit; larger changes can use cohesive phases with dependencies and completion criteria. Local implementation choices remain open when they preserve the agreed behavior and constraints.

Use it when the requested deliverable defines what to build or modify. System explanations, operational guides, and standalone test procedures belong to [system-spec](system-spec.md). Implementation-only requests and brief planning advice do not activate this workflow.

The default output is `docs/PLAN-SPECS-{context-id}.md`, including a creation timestamp. An independent reviewer must accept the current saved version before handoff. Specification authoring does not change production code, tests, or configuration. Already-authorized implementation may continue after acceptance unless the user required a separate checkpoint.

- [Source definition](../../codex/skills/tech-spec/SKILL.md)
- [Document reviewer](../agents/document-reviewer.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
