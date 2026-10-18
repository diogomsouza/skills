# test-audit

Test Audit governs both test authoring and test-suite cleanup. Its purpose is to retain the smallest test surface that protects critical behavior difficult to verify reliably through ordinary product use.

Before creating or changing a test, it checks the material failure being prevented, the independent contract being proved, the coverage that existing tests lack, and whether the test exercises a real production boundary. It excludes automated presentation and ordinary screen-interaction assertions, including layout, styling, display strings, and visual feedback. Critical domain effects may still qualify even when initiated through a UI.

An audit request authorizes inspection, removal, consolidation, cleanup of exclusive unused support, and validation within scope. Explicit report-only requests remain read-only. The skill preserves justified critical proof, investigates uncertain cases, and separates product defects from stale expectations and environment failures.

Percentage targets or broader test-pruning campaigns use the additional campaign procedure. The final chat response reports changes, retained proof, actual checks, and limitations. The workflow does not create audit reports or decision ledgers, and it does not authorize commits or publishing by itself.

- [Source definition](../../codex/skills/test-audit/SKILL.md)
- [Campaign procedure](../../codex/skills/test-audit/CAMPAIGN.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
