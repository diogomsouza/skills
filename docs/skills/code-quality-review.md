# Code Quality Review

**Find code that no longer earns its place, and make focused improvements supported by evidence.**

Code Quality Review examines whether code is necessary, understandable, and appropriately simple for its current purpose. It works across programming languages and gives priority to unused, unreachable, and obsolete code, especially leftovers introduced by a recent change.

The workflow combines usage tracing with maintainability analysis. It aims to explain why a piece of code is unnecessary or costly to maintain, what would be affected by changing it, and the smallest correction that addresses the problem.

## Match the review to the request

The scope can be a diff, selected files, a module, or an entire repository. Investigation may follow callers or registrations outside that boundary when necessary to establish a finding, but that does not authorize unrelated cleanup.

| Request | Expected behavior |
| --- | --- |
| Review code quality | Inspect and report findings without editing source |
| Audit dead code in a module | Trace usage within the requested scope and identify confirmed removals or unresolved candidates |
| Clean up confirmed issues | Apply related corrections and validate them |
| Review a recent change | Distinguish new problems, leftovers caused by the change, and unrelated existing issues |

No particular analyzer, editor, or companion document is required. The skill uses available compiler diagnostics, analyzers, symbol references, and source inspection, and explains limitations when stronger tooling is unavailable.

## Establish whether code is unused

A declaration with no obvious caller is a starting point for investigation. The skill first identifies legitimate roots such as executable entry points, exported APIs, commands, routes, jobs, framework callbacks, and test or maintenance utilities.

It then traces candidate code back to those roots. A helper called only by another unreachable helper may still be dead code. Conversely, a function with no direct text references may be used through reflection, dependency injection, configuration, serialization, or a framework convention.

Before recommending removal, the workflow checks relevant indirect consumers and side effects. Removing an unused variable must not accidentally remove an expression with a required effect. Deleting an apparently unused parameter must not break an interface, callback, override, or external contract.

The resulting evidence falls into three categories:

| Conclusion | Meaning |
| --- | --- |
| Confirmed within the reviewed scope | Usage and removal-safety checks support the finding |
| Candidate requiring investigation | A specific consumer, configuration, side effect, or compatibility question remains open |
| Legitimately used | An applicable path or contract explains why the code exists |

Published APIs and migration compatibility may remain necessary even without local callers. Unavailable external evidence limits the conclusion; it does not establish safe removal.

## Review maintainability without creating busywork

After prioritizing dead code, the skill examines clarity, simplicity, responsibilities, duplication, error handling, and meaningful consistency.

Findings need a concrete consequence. Two implementations of the same business rule can create a correction burden if they diverge. A method that combines unrelated responsibilities can make a particular change difficult to isolate. A fallback can hide a realistic failure that callers need to handle.

Method length, a preferred design pattern, or personal naming taste is not enough. A long method may remain coherent, and extracting every small step can make straightforward code harder to follow. The skill recommends abstraction or extraction when it clarifies a meaningful rule, removes harmful duplication, improves testability, or isolates a dependency.

## Apply corrections and verify the result

When cleanup is authorized, edits stay connected to the findings. The workflow preserves established architecture, useful comments, external names, signatures, and serialization contracts. It removes support made obsolete by its own corrections only after checking the remaining consumers.

Validation starts with the smallest relevant checks and expands when the affected behavior or a concrete failure requires it. Depending on the change, useful evidence may include compilation, lint, symbol analysis, existing focused tests, or manual reproduction.

A passing build supports the change but does not prove that reflection or external consumers were checked. The final response keeps those distinctions visible and separates changes already made from recommendations.

## Read the review result

Findings identify the location, causal evidence, practical consequence, focused correction, and any uncertainty. Severity and confidence are separate: a strongly established unused helper is not automatically a high-impact issue.

Every final review also summarizes checks actually performed, including unused, unreachable, and obsolete code. Areas may have findings, no substantiated issues within scope, inconclusive evidence, or checks that were not performed. A clean result in one area does not imply exhaustive coverage.

## Example requests

```text
Use $code-quality-review on the current diff. Focus on code made obsolete by
these changes and report findings only.
```

```text
Use $code-quality-review to clean up confirmed dead code in the import module.
Preserve its public API and validate the affected build.
```

For independent correctness assessment of a candidate implementation, see [Reviewer](../agents/reviewer.md). For test-suite retention and removal rules, see [Test Audit](test-audit.md).

## Source and related guides

- [Skill definition](../../codex/skills/code-quality-review/SKILL.md) — evidence standards, maintainability criteria, cleanup boundaries, and reporting.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->