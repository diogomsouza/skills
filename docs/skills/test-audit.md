# Test Audit

**Keep tests that protect critical behavior and remove proof that adds cost without a justified purpose.**

Test Audit governs both test authoring and existing-suite cleanup. It aims for the smallest test surface that protects material failures difficult to detect reliably through ordinary product use.

The workflow evaluates what each assertion actually proves. A high coverage number, a familiar test pattern, or the folder containing a test does not establish its value. A justified test protects an independently defined contract and detects a credible failure that existing proof would miss.

## Choose the operating mode

| Request | Workflow |
| --- | --- |
| Create or change tests | Apply the authoring gate before writing affected tests |
| Audit a suite | Inspect, remove, simplify, clean up exclusive unused support, and validate within scope |
| Analyze or report only | Keep the task read-only and report findings |
| Reach a reduction target or retire redundant layers | Apply the main rules plus the campaign procedure |

During feature development, the gate applies to affected tests; it does not start an unrelated repository-wide audit. An audit without a specified narrower scope uses the current project when it can be identified.

An ordinary audit request already authorizes justified removal and validation. It does not authorize commits, publishing, or unrelated changes to product behavior. Questions about the skill itself do not activate an audit.

## Understand the presentation exclusion

The skill prohibits automated tests of presentation and ordinary screen interactions. Examples include layout, colors, icons, visual trees, styles, labels, display formatting, button visibility, presentation bindings, ordinary field-validation messages, and animation or visual interpolation.

These checks are performed through the running product, browser interaction, or a human check. Moving the same assertion into a snapshot, source grep, integration test, or E2E suite does not make it eligible.

The boundary is the assertion, not the UI's involvement:

| Presentation assertion to remove | Critical behavior that may qualify |
| --- | --- |
| A progress indicator displays 100% | Completion cannot be reported before durable commit |
| A delete button is disabled during work | A conflicting operation cannot destroy data owned by active work |
| A field displays a required-value message | Invalid external input cannot bypass authorization or corrupt data |
| An error label contains particular text | Failure preserves committed data and permits recovery |

A test may drive a UI to verify a critical persisted or domain effect. That critical proof must still pass the gate below, and presentation assertions remain excluded.

## Apply the four-part evidence gate

Every proposed or retained test must establish four things.

1. **Critical effect.** Identify the material failure and why ordinary use or a short manual check would not reliably reveal it.
2. **Independent proof.** Define the observable invariant or contract and a credible regression that would make the assertion fail.
3. **Distinct coverage.** Explain why existing tests would miss the failure. A second layer needs a distinct risk, such as transport or lifecycle behavior that the primary owner cannot exercise.
4. **Real boundary.** Exercise production behavior without reproducing the answer in mocks or introducing exports, flags, wrappers, or injection hooks needed only by tests.

Security, persistence, recovery, concurrency, calculations, protocols, and migrations can qualify, but their category names do not automatically justify a test.

For example, testing retry handling at several layers may repeat the same mocked answer. A stronger check may verify the committed effect at its owner, while a separate transport check remains justified only if it protects a different failure.

Missing evidence rejects a proposed test. Existing uncertain cases are investigated before removal; the skill does not invent a retention argument or delete valuable proof merely to increase a reduction count.

## Audit the complete scoped inventory

The workflow discovers the actual runner, CI routing, supported filters, and environment prerequisites. It records the starting state for comparison without creating an audit inventory file.

Every scoped test file, including ignored or disabled suites, is assessed. The review reads complete cases, production owners, and overlapping proof. It traces support code, registrations, dependencies, and callers where removal could affect other behavior.

Mixed tests need particular care. Presentation assertions and their exclusive setup are removed while independently justified critical assertions are preserved at the appropriate boundary. A whole test is removed if nothing eligible remains.

Exclusive unused snapshots, fixtures, helpers, registrations, dependencies, and production test hooks are cleaned up after consumer checks. Shared support and product behavior are preserved.

## Remove, consolidate, and validate

Changes are made in coherent batches around production owners. Required keeper proof is established before its only predecessor is deleted. Prohibited assertions are removed completely, including dormant ones; skipping, quarantining, or renaming them is not removal.

For retained failures, the skill distinguishes a product defect, a stale expectation, and an environment problem. A valuable test is not deleted just because it fails. Regressions introduced by cleanup are corrected; unrelated product defects are reported unless their repair is authorized.

Validation starts with relevant retained checks and completes repository-required build, analysis, or broader checks. Appropriate live product checks cover removed presentation categories when the product can run. An unavailable live check is reported as unexecuted and does not imply verification passed.

For substantial removals, an independent preservation review is used when available. Otherwise, the skill performs a separate pass and reports that limitation.

## Handle reduction campaigns honestly

The [campaign procedure](../../codex/skills/test-audit/CAMPAIGN.md) adds baseline and final accounting, cross-layer comparison, and preservation checks for larger reductions.

Parameterized rows count separately from declarations. Moving, renaming, repacking, or disabling tests does not count as removal. Coverage comparisons use consistent collection settings and explain changes in the production denominator.

A target does not excuse leaving prohibited assertions behind or skipping the inventory. Conversely, valuable critical proof is not sacrificed to meet a quota. A shortfall supported by specific retention evidence is acceptable; an unresolved blocker must remain visible.

## What the handoff contains

Results are communicated in the final chat response, without creating audit reports, decision logs, or ledgers. The handoff identifies removed categories, support cleanup, retained critical proof, actual validation, and unresolved limitations.

For changed suites, it reports deleted test files, removed cases when determinable, and net test/support line changes separately from production changes. Static counts and unverified runtime or coverage claims are labeled accurately.

## Example requests

```text
Use $test-audit to audit the import subsystem's tests and apply justified cleanup.
Preserve critical persistence and recovery proof.
```

```text
Use $test-audit to review this test suite in report-only mode.
Do not modify files.
```

```text
Use $test-audit for a campaign to reduce redundant tests across the storage layers.
Explain retained proof and any limits on the achievable reduction.
```

## Source and related guides

- [Skill definition](../../codex/skills/test-audit/SKILL.md) — exclusions, evidence gate, cleanup, validation, and reporting.
- [Campaign procedure](../../codex/skills/test-audit/CAMPAIGN.md) — reduction accounting and preservation across layers.
- [Code Quality Review](code-quality-review.md) — broader maintainability and dead-code analysis.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->