# Document Reviewer

**Check whether a document fulfills its purpose and gives its reader a reliable basis for action.**

Document Reviewer independently assesses documentation, specifications, plans, proposals, and guides. It examines writing quality, coherence, ambiguity, completeness against the request, factual grounding, and suitability for the intended audience.

The role reads as the intended recipient. A document can be grammatically correct yet still omit a prerequisite, contradict a source, or leave an essential implementation decision unresolved. The review looks for those concrete consequences while respecting the document's actual purpose.

## Define what is being reviewed

A useful assignment identifies the saved candidate and version, audience, intended use, requested maturity, requirements, confirmed decisions, and supporting sources. The candidate alone cannot establish whether it includes everything the user asked for.

By default, the agent reviews the complete document. A narrower section or revision assignment still requires enough surrounding context to assess consistency.

For example, a final implementation specification may need to resolve a product decision that a proposal is deliberately presenting for selection. The same open question has different consequences in those two documents.

## Examine the document across six dimensions

| Dimension | What the agent checks |
| --- | --- |
| Writing and clarity | Meaning, terminology, definitions, grammar, references, units, and readable responsibility assignments |
| Coherence | Agreement between scope, requirements, examples, tables, diagrams, procedures, and completion criteria |
| Ambiguity | Plausible competing readings that lead to different decisions or actions |
| Completeness | Substantive coverage of requested outcomes, constraints, prerequisites, and essential boundaries |
| Grounding | Support for factual claims, paths, quantities, examples, and source authority |
| Fitness for use | Whether the intended reader can understand the subject or perform the intended work using the document and its references |

The agent reads the whole assigned scope rather than stopping at the first finding. It investigates sources to the depth needed for material claims without demanding exhaustive background research for a simple guide.

For implementation specifications, it also checks applicable contracts, state and data changes, failure behavior, dependencies, ownership, integration ordering, and achievable verification. A conceptual overview does not need implementation-level instructions merely because those dimensions matter elsewhere.

## Keep current behavior, proposals, and requirements distinct

The review checks whether observed facts, intended future behavior, examples, and assumptions are clearly distinguished.

Current code can establish how a system behaves today. It does not override an explicitly requested future change. Similarly, a source document's title does not automatically make it authoritative for every claim.

The agent compares the candidate with the actual request and confirmed decisions. It does not invent product requirements or ask for an idealized document unrelated to the user's purpose. If required evidence is unavailable, it identifies the affected obligation and the input needed to finish the review.

## Review repetition by its effect on the reader

Repeated information can be useful when it reinforces a condition beside an operation or lets a section stand on its own. The role does not treat repetition as a defect merely because another section contains similar wording.

It looks instead for duplicated rules that disagree, scattered conditions that obscure an instruction, or unnecessary restatement that creates reading effort without helping understanding.

A focused consolidation can be suggested when meaning and safeguards remain intact. Minimum length and stylistic compression are not review goals.

## Remain independent of authoring and execution

The [configuration](../../codex/agents/document-reviewer.toml) uses a read-only sandbox and forbids edits. The agent does not rewrite the candidate, implement its proposed software changes, or execute its examples and procedures.

The author owns corrections, product decisions, and user clarification. The reviewer supplies an independently reasoned assessment of the saved version.

During re-review, changed material and its effects on related sections are reassessed. An earlier acceptance does not automatically cover a revised candidate. Checks described in a document remain distinct from checks actually executed during authoring or development.

## Understand verdicts and findings

| Verdict | Meaning |
| --- | --- |
| `ACCEPT` | All required review obligations are established and no in-scope defect is confirmed |
| `REJECT` | At least one confirmed in-scope defect exists |
| `BLOCKED` | No defect is confirmed, but a missing prerequisite prevents required assessment |

A defect identifies its location, violated requirement or claim, evidence, reader consequence, and focused correction. Severity P0–P3 reflects that consequence. Suggestions and evidence gaps are reported separately.

For ambiguity, a finding must show the competing interpretations and their different outcomes. For an omission, it must identify the requirement making the missing information necessary. Formatting preferences and a different preferred section order do not establish a substantive defect by themselves.

## Example assignment

```text
Review the saved recovery guide for the on-call team.
Compare it with the requested scope, the current retry implementation, and the
documented operating constraints. Check that prerequisites and expected outcomes
are clear. Do not edit the document or execute its recovery procedures.
```

Both [System Spec](../skills/system-spec.md) and [Tech Spec](../skills/tech-spec.md) require independent review before handing off their current saved output. The agent also supports an explicit standalone document review.

## Source and related guides

- [Agent configuration](../../codex/agents/document-reviewer.toml) — review contract, investigation, evidence, and verdict rules.
- [Reviewer](reviewer.md) — implementation correctness.
- [Code Reviewer Security](code-reviewer-security.md) — security guarantees.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->