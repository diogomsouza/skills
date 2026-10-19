# Test-pruning campaign

Use this procedure for the campaign requests defined in [SKILL.md](SKILL.md).
Its scope, exclusions, evidence gate, removal rules, and validation apply
unchanged. This file adds accounting and coordination for large reductions.

## 1. Establish the baseline

Determine the starting revision and existing working-tree changes, test/support
line counts separately from production, expanded test case count, and baseline
results for retained or mixed tests. Purely prohibited UI tests need no execution
or repair before deletion; treat them as pending removal, never as passed.
Keep pre-existing failures, skips, and environment blockers separate.

Use the user's reduction and coverage targets; do not invent percentages.
Count parameterized cases separately from declarations: repacking cases into
fewer methods is not reduction.

When coverage tooling is available or a coverage target was requested, compare
baseline and final measurements with the same settings, exclusions, and scope.
Include line/branch measurements where supported and explain production
deletions that change the denominator. If collection is unavailable, state
the blocker and leave the coverage claim unverified. Numbers cannot substitute
for critical proof or override the UI exclusion.

## 2. Account for every test

Partition the inventory by production ownership. Each file belongs to one
lane; shared-boundary and integration proof can justify removal without
expanding deletion scope. Use read-only discovery agents for independent lanes
when useful and available, otherwise process them sequentially.

Assess every declaration and its actual assertions against the main skill's
gate to retain, repair, consolidate, or delete. Evaluate parameterized rows and
mixed assertions separately when their value differs. No decision register is
required or permitted by campaign mode.

Compare proof across layers before editing. Find suites that merely replay
a shared owner through mocks; name a keeper for each critical contract, any
assertions to transfer, retired files, and unused support the removal unlocks.
Resolve uncertainty with evidence rather than defaulting to retention or deletion.

## 3. Apply coherent batches

Work lane by lane, assigning shared support edits to one owner. Apply the
main skill's cleanup and validation rules; update executable test registrations
or enforced size baselines only when the changes require it.

Measure reduction after coherent batches. Meeting a target does not end the
full inventory assessment or mandatory UI removal. Once both are complete,
a numerical target may end further optional consolidation. If below target,
revisit redundant layers; for maximum reduction, exhaust justified candidates
rather than stopping at an intermediate percentage. Do not sacrifice valuable
proof to meet a quota.

Investigate retained-test failures when they block progress, using the main
skill's distinction between defects, stale expectations, and environment
problems. Unrelated product repairs need their own authorization.

## 4. Verify preservation

Have an independent reviewer compare removed assertions with their keepers
when available; otherwise perform a separate preservation pass and report that
limitation. Check for lost critical contracts, vacuous assertions, wrong guards,
prohibited assertions left behind, and unresolved findings under the main
skill's closure rule. Intentional removal of presentation
proof does not justify restoring UI automation.

When the review finds a lost critical contract, restore eligible proof at its
owner. Demonstrate that it detects the relevant failure with pre-fix code or a
targeted mutation. Isolate mutations from ongoing work and restore the original
source exactly, including existing user edits. If this check cannot run, report
the preservation claim as unverified.

If upstream integration is authorized and changes audited code, reassess the
affected tests, transfer eligible new proof into the keepers, and
rerun relevant checks on the integrated result.

## 5. Complete and report

Complete the main skill's validation and handoff. Add to the final chat response:

- baseline/final case counts and test/support versus production line counts;
- comparable coverage, achieved reduction, and concrete retention reasons or
  blockers for any shortfall;
- retired layers, their keepers, and preservation gaps resolved or unverified.

Completion requires a fully assessed inventory, all justified edits and
mandatory removals, and finished validation. A target shortfall supported by
specific retention evidence is acceptable; an unresolved blocker must remain
explicit.
