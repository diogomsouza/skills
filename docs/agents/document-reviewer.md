# document-reviewer

This agent independently reviews documentation, specifications, plans, proposals, and guides. It evaluates writing quality, coherence, ambiguity, completeness against requirements, factual grounding, and suitability for the intended audience and purpose.

It compares the saved candidate with the actual request, confirmed decisions, applicable guidance, and available sources. It checks that current behavior, planned behavior, examples, and assumptions are distinguishable. For procedures, it assesses whether readers have the prerequisites and instructions needed to follow them correctly.

The configuration uses a read-only sandbox. The agent does not edit the document, implement its proposed changes, or execute its procedures. The author owns corrections and any clarification with the user. Code correctness reviews and security audits belong to the corresponding code-review agents.

Its verdict is `ACCEPT`, `REJECT`, or `BLOCKED`, supported by concrete findings or missing evidence. Use it before handing off a document or when an explicit documentation review is requested.

- [Agent configuration](../../codex/agents/document-reviewer.toml)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
