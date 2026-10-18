# code-quality-review

Code Quality Review assesses whether code is necessary, understandable, and appropriately simple. It works across programming languages and prioritizes unused, unreachable, and obsolete code, particularly leftovers from a change.

It traces callers and legitimate entry points, then checks indirect consumers such as reflection, dependency injection, configuration, generated code, and external APIs before treating code as safe to remove. A missing text match or analyzer warning alone is not proof of disuse.

Use it for a maintainability review, a dead-code audit, or authorized cleanup of a change, module, or repository. Findings distinguish confirmed problems, candidates requiring more investigation, and legitimate uses. Additional maintainability findings need concrete consequences and focused corrections.

A review-only request produces findings without source edits. When cleanup is authorized, the skill applies related corrections and validates them while preserving unrelated code and changes. It does not require a particular analyzer, editor, or companion document.

- [Source definition](../../codex/skills/code-quality-review/SKILL.md)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
