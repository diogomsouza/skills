---
name: test-audit
description: "Use before creating or changing tests, and when reviewing or auditing test suites. Audits remove prohibited or unjustified tests and validate by default; explicit report-only requests stay read-only. Prevent UI/presentation tests, redundant proof, and test-only production scaffolding."
---

# Test Audit

Keep the smallest test surface that protects critical behavior difficult to
verify reliably through ordinary product use. Apply the same criteria when
creating, changing, or auditing tests, across products and frameworks.

## Invocation and scope

- **Authoring:** apply the gate below before writing or repairing affected
  tests, even when the user did not name this skill. Feature development does
  not trigger an unrelated project-wide audit.
- **Audit:** a request such as "Faça uma auditoria nos testes usando a skill
  test-audit" authorizes inspection, removal, simplification, cleanup of unused
  exclusive support, and validation. Continue from discovery into edits without
  asking for a separate removal approval or stopping at recommendations.
- **Report only:** an explicit restriction such as "apenas analise", "não altere
  arquivos", or "report only" keeps the task read-only.
- **Campaign:** for a percentage target, maximum reduction, or retirement of
  redundant test layers across a subsystem, also read [CAMPAIGN.md](CAMPAIGN.md).

Use the user's scope; otherwise audit all tests in the current project
identified by the active workspace or task. Ask only if the project cannot be
identified. Questions about this skill and edits to it do not trigger a
repository audit. Preserve existing user changes. Cleanup does not itself
authorize commits, publishing, or unrelated changes to product behavior.

Do not create or update audit reports, decision logs, notes, ledgers, or audit
inventory files, including temporary files. Do not append audit decisions to
existing documentation. Evaluate the evidence without producing a decision
register; communicate the outcome only in the final chat response. Normal
runner logs and necessary updates to executable test registrations remain valid.

## Hard exclusion: interface and presentation

Do not create or retain automated tests of presentation or ordinary screen
interactions. This includes:

- colors, styles, icons, spacing, layout, control dimensions, visual trees,
  markup, CSS classes, and screenshot/render snapshots;
- button appearance, hover/focus/selection appearance, visibility/enabled flags,
  bindings, presentation change notifications, and presentation-only properties;
- labels, titles, tooltips, localized display strings, status messages, and
  formatting of progress or duration;
- ordinary form/field validation, required-field messages, selection display,
  and whether a draft enables a button;
- animation, visual cursor smoothing, display interpolation, drag continuity,
  scrolling appearance, and other visual feedback, even when implemented as
  deterministic math without rendering.

Verify these through use of the running product: computer use, browser
interaction, or a human check. Do not recreate the same assertions as snapshots,
source greps, visual regression, integration, or E2E suites.

No retention argument overrides this exclusion: previous bugs, cheap execution,
coverage targets, public properties, or documented appearance requirements do
not justify even one representative presentation test.

### Classify the assertion, not the location

A UI folder, ViewModel class, or user-initiated action can contain critical
non-presentation behavior. Judge what the test actually proves:

| Prohibited assertion | Potentially valuable critical proof |
|---|---|
| A progress indicator is smooth or displays 100% | Completion cannot precede durable commit |
| A delete button is disabled during work | A conflicting delete cannot destroy data owned by an active operation |
| A textbox displays a required-field warning | Invalid external input cannot bypass authorization or corrupt data |
| A success/error label has particular text | Failure preserves committed data and permits recovery |
| A window has a particular tree or size | Resource and thread ownership prevent crashes or leaks |

The critical proof must pass the gate below. Assert it at the command/domain
boundary rather than through styles, labels, flags, or property setters.
An integration test may drive the UI to verify a critical persisted or domain
effect; driving the UI does not make presentation assertions eligible.

### Remove completely

In an executable audit, remove every prohibited assertion within scope,
including disabled or dormant tests. Do not skip, quarantine, comment out,
exclude from CI, relocate, or rename tests to evade deletion. A numerical
target never permits leaving prohibited assertions behind.

For mixed tests, remove presentation assertions and their exclusive setup;
preserve independently justified critical proof at its owning boundary.
Delete the whole test if nothing eligible remains. Remove exclusive unused
snapshots, fixtures, helpers, registrations, dependencies, and production test
hooks after checking callers; preserve product behavior and shared support.

Choose a short live product check for each removed category, reusing existing
manual scenarios where possible. No replacement automated UI proof or new QA
framework is required. If the product cannot run, report the live check as
unexecuted; this does not block removal or imply that verification passed.

## Gate for creating and retaining tests

Apply the hard exclusion first. An eligible test must answer all four questions:

1. **Critical effect:** what material failure does it prevent, and why would
   ordinary use or a short manual check fail to detect it reliably?
2. **Independent proof:** what observable invariant or contract does it enforce,
   and what credible regression would make its assertions fail?
3. **Distinct coverage:** why would existing tests miss that failure? Prefer one
   primary owner at the strongest practical boundary. Another layer needs a
   distinct risk, such as transport or lifecycle behavior that owner cannot reach.
4. **Real boundary:** does it exercise production behavior without reproducing
   the answer in mocks or adding exports, flags, wrappers, or injection hooks
   needed only by tests? Use the real boundary instead of introducing such seams.

A missing answer rejects a proposed test. Investigate existing tests before
deleting uncertain cases; do not invent a retention rationale or delete them
merely to increase counts. Extend an existing case table when it adds distinct
proof; do not replay the same regression at every layer.

Security, persistence, recovery, transactions, concurrency, critical domain
calculations, protocols, migrations, and release contracts can qualify.
A category name, public API, documented default, or static/slow execution
neither establishes nor disproves value. Each test must meet the gate.

For bug regressions, demonstrate failure on pre-fix code for the intended
reason and success after the fix. If that comparison is unavailable, disclose
the limitation; do not claim demonstrated regression protection.

### Patterns requiring scrutiny

- assertion-free probes, self-comparisons, identity copiers, or expected values
  computed by the implementation under test;
- copied inventories, manifests, export lists, exact source/import greps, or
  tests of private predicates and collaborator call shapes;
- duplicate cases, provider-local replays of shared behavior, or suites that
  repeat stronger proof through mocks;
- ignored parameters, parameters with no effective variation, and test-support
  branches no case reaches;
- tests preserving exports, globals, wrappers, or otherwise dead production
  code whose only callers are tests;
- mocks implementing the asserted outcome or treating distinct APIs identically;
- fixtures supplying receipts, admission decisions, or callback ordering the
  owner should produce; persistence checked against a store the path never writes;
- capability flags asserted without exercising the behavior they promise;
- negative cases passing through the wrong guard or an unreachable path, or
  names promising behavior the inputs and assertions never exercise.

Check all uses before simplifying parameters or support branches. Remove those
that serve no meaningful distinction; do not add cases merely to justify them.
A single data row alone does not invalidate a justified shared structure.

Remove unjustified proof; repair or relocate valuable proof coupled to
implementation. A test should survive refactoring that preserves its protected
contract. Source inspection qualifies only when it independently protects a
critical contract, is the cheapest reliable check, and tolerates unrelated
identifier or implementation changes. None of these exceptions permit UI tests.

## Audit workflow

### Discover and decide

Read applicable repository instructions and inspect the working tree. Discover
the actual test runner, CI routing, supported filters, validation commands, and
OS/SDK/hardware/concurrency prerequisites rather than assuming them.
Determine the starting state so audit metrics exclude pre-existing user changes.

Inventory every test file in scope, including ignored or disabled suites.
Read complete tests and parameter cases, their production owners, and
overlapping proof. Trace callers, CI routing, dependencies, or history where
needed to resolve value or safe support removal; an obvious UI exclusion needs
no historical investigation.

Evaluate each candidate against the relevant evidence:

- **Remove UI:** location, prohibited assertions, any critical proof to preserve,
  exclusive support, and relevant live check.
- **Remove/consolidate other tests:** actual failure detected, remaining proof
  or why automation is unjustified, affected callers/support, and validation.
- **Retain/repair:** critical contract, credible failure, and distinct proof.

Resolve uncertain cases against production behavior. If evidence remains
unavailable, identify the specific blocker and affected tests rather than
claiming a complete audit. Generic coverage or "test everything" conventions
do not override the UI exclusion; report conflicting gates.

### Apply and verify

Edit in coherent batches around production owners. Establish any required
keeper proof before deleting its only predecessor. Remove obsolete exclusive
support rather than preserving aliases. Update existing CI routing and executable
test registrations for moved/deleted suites. Do not add replacement tests to offset
deletion counts or alter production behavior to satisfy a brittle assertion.

In an executable audit, close every in-scope finding, including reviewer
suggestions, as applied, rejected with concrete evidence, or blocked with a
specific impediment. Apply confirmed, feasible cleanup; a suggestion label or
preservation approval is not a reason to leave it unresolved.

For a failing retained test, distinguish a product defect, stale expectation,
and environment failure using evidence. Never delete valuable proof just
because it fails. Fix regressions introduced by the cleanup; report unrelated
pre-existing defects unless their repair is already authorized.

Do not edit files while checks are running against them. Run the smallest
relevant retained tests first, then repository-required build, analysis, and
broader checks. If removing a source grep, exercise the owning script or
supported dry-run when applicable. Check the diff for whitespace errors.

Review the final diff for lost critical proof and confirm every scoped file
was assessed and all prohibited assertions and exclusive unused support were
removed. Also check that identified excess has no unresolved findings;
preserving critical proof alone does not establish cleanup completeness.
For substantial removals, use an independent preservation reviewer
when available; otherwise make a separate review pass and disclose that limit.
Perform the relevant live checks when the product is available.

Do not restore UI tests or change coverage exclusions to satisfy coverage
gates. Compare coverage only with consistent collection settings and scope;
report intentional losses and unverified targets. Separate passed, failed,
skipped, and environment-blocked checks. Simulations do not establish hardware
qualification.

Finish after the full scoped inventory is assessed, justified changes are
applied, and validation is complete, or report the concrete remaining blocker.

## Handoff

In the final chat response, summarize removed categories, meaningful support
cleanup, retained critical proof, and validation actually performed. State any incomplete removals,
unexecuted live checks, rejected findings and their reasons, or other blockers.

For audits with changes, report deleted test files, removed cases when
determinable, and net line changes for tests/support separately from production.
Distinguish whole-test removals from assertions removed in retained tests.
Count parameterized rows separately; moving, renaming, repacking, or disabling
tests does not count as removal. Derive metrics from the inventory and audit
diff without rerunning suites solely for counting. Label static counts and
explain unavailable counts rather than presenting estimates as exact.

Coverage and runtime comparisons are required only when requested or otherwise
required by campaign or repository policy. Do not generate unrelated metrics,
documentation, or follow-up work.
