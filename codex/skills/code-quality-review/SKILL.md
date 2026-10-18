---
name: code-quality-review
description: "Review code quality in any programming language, prioritizing unused, unreachable, and obsolete code. Use for maintainability reviews, dead-code audits, and requested cleanup of a change, module, or repository."
---

# Code Quality Review

Assess whether code is necessary, understandable, and appropriately simple for its current purpose. Prioritize code that has become unused, especially leftovers from a change. Support findings with evidence and recommend the smallest useful correction.

Use this workflow across programming languages. Adapt analysis to the language and runtime; no particular analyzer, editor, service, or companion document is required.

## Scope and authority

- For a review-only request, report findings without editing source files. For authorized cleanup or implementation, make the related corrections and complete validation. Removing code made obsolete by your own changes is part of that implementation, without an additional permission step.
- Use the requested scope: a change, selected files, a module, or a repository. Infer an omitted scope from the working context and state material assumptions. Ask only when an unresolved ambiguity could substantially change the result.
- In a change review, inspect connected callers, registrations, and dependencies beyond the diff when needed. Separate newly introduced problems, leftovers caused by the change, and unrelated preexisting issues. Broad investigation does not authorize unrelated edits.
- Review first-party source. Inspect generated code, dependencies, configuration, and build artifacts when they provide usage evidence, but direct fixes to the maintained source rather than generated or vendored output.
- Keep the effort proportional to the scope and risk. Do not turn a small review into a repository-wide audit, security assessment, or performance study unless requested or necessary to substantiate a finding.

## Establish whether code is unused

### Map the reachable system

Identify the languages, runtimes, build targets, and application or library boundaries. Inspect available source, manifests, build settings, and registrations to understand execution and consumption.

Identify legitimate roots such as executable entry points, module initialization, exported APIs, framework callbacks, routes, jobs, commands, plugins, and test entry points. Include supported configurations and platforms relevant to the review. A feature flag that is currently off, an old file, or a deprecated API is not evidence of disuse by itself.

### Find candidates and trace their consumers

Look for unused functions, methods, classes, modules, fields, constants, imports, variables, parameters, and assignments; unreachable branches; obsolete alternative implementations; and commented-out implementations that no longer serve a documented purpose.

Prefer available compiler diagnostics, static analyzers, language-server references, and symbol-aware search. Supplement these with text search and direct inspection. Use analysis without automatic fixes for review-only requests. When suitable tooling is unavailable, continue with source inspection and disclose the resulting uncertainty.

A search result may be a declaration, comment, unrelated symbol with the same name, or test-only reference. Absence of text matches or a single analyzer warning is a candidate signal, not proof that removal is safe. Missing runtime coverage or telemetry also does not prove disuse.

Trace consumers back to legitimate roots. A function is not necessarily needed merely because another function calls it: an entire chain or cycle may be unreachable. Conversely, tests, fixtures, development utilities, and maintenance commands can be legitimate consumers. Tests for application code establish tested behavior, not necessarily a production requirement; investigate that distinction without treating all test-only code as waste.

### Check indirect use and removal safety

Before confirming a candidate, inspect plausible non-obvious consumers for the detected language and framework:

- Reflection, dynamic dispatch, string-based lookup, dependency injection, registries, event handlers, decorators, annotations, and framework lifecycle hooks.
- Configuration, templates, scripts, macros, code generation, conditional compilation, optional build targets, and foreign-language bindings.
- Public exports, external package consumers, interfaces, overrides, callback signatures, serialization fields, and persisted data contracts.
- Import-time or initialization side effects, constructor effects, and effects of expressions assigned to otherwise unused variables.

These are investigation routes, not a mandatory checklist for every symbol. Rule out the mechanisms that can realistically apply. For example, deleting an unused binding must not silently delete a call with required side effects, and removing an unused parameter must not break a required signature.

Do not infer that a published API is unused from the absence of local callers. Migration history and compatibility code may remain necessary for upgrades or external consumers. If the relevant boundary cannot be inspected, preserve that uncertainty.

### Classify the evidence

- **Confirmed within the reviewed scope:** usage tracing supports the finding, relevant indirect consumers and contracts have been checked, and no material removal-safety question remains unresolved. Explain the scope of that conclusion.
- **Candidate requiring investigation:** evidence suggests disuse, but a specific consumer, configuration, side effect, or compatibility obligation remains unresolved. State what evidence would resolve it; do not present it as safe to delete.
- **Legitimately used:** an applicable execution path or contract explains its presence. Do not report it as dead code.

Group an unreachable chain or several symptoms of the same cause into one actionable finding. Do not inflate a report by listing each member separately without a distinct reason.

## Evaluate maintainability

After prioritizing unused code, evaluate these criteria against concrete behavior and maintenance consequences:

| Criterion | Evidence worth reporting |
| --- | --- |
| Necessity | Unused code, redundant state or conditions, abandoned implementations, and speculative features or configuration. |
| Clarity | Misleading names, hidden effects, difficult control flow, or comments that contradict behavior. |
| Simplicity | Complexity or abstractions with no current benefit; layers that only obscure a straightforward operation. |
| Responsibility | Unrelated responsibilities or dependencies that make a concrete change harder to understand, isolate, or verify. |
| Duplication | A shared rule implemented independently in ways that create a plausible divergence or correction burden. |
| Error handling | Realistic failures that are hidden or mishandled, or defensive branches for unsupported hypothetical failures that add unnecessary complexity. |
| Consistency | Local inconsistencies that obscure meaning, violate a required contract, or make the changed code harder to maintain. |

Do not equate quality with small methods, a preferred paradigm, a design pattern, or arbitrary limits on line counts and complexity metrics. A long method can be coherent, and similar snippets need not share an abstraction.

Keep simple, single-use steps inline when they remain clear, such as loading a list, applying a filter, or assigning a value. Recommend extraction when it clarifies intent, isolates a meaningful rule, removes harmful duplication, improves testability, or isolates a dependency. Explain that benefit instead of prescribing fragmentation.

Do not manufacture findings from personal style preferences or invent future requirements to justify a rewrite. When multiple remedies are viable, explain a meaningful tradeoff and prefer the smallest clear solution.

## Apply authorized corrections

- Change only code related to the requested work. Preserve established architecture and behavior unless changing them is part of the request. Mention unrelated issues separately.
- Remove imports, variables, and methods made obsolete by the correction, including newly orphaned helpers when the same usage checks support removal.
- Do not add speculative features, extensibility, configuration, or error handling. Introduce an abstraction only for a demonstrated benefit.
- Preserve useful comments, external names, signatures, overrides, interface implementations, and serialization contracts. Explain adjacent changes that are required for correctness.
- Keep uncertain candidates separate from actionable removals. A cleanup request does not turn missing evidence into proof of disuse.

### Formatting and naming when editing

Preserve the surrounding language-specific style and use these defaults when no consistent style is established. Language syntax, required tooling, and externally imposed contracts take precedence. Do not perform separate formatting passes, rename unrelated symbols, or report cosmetic differences as substantive defects.

- Use four spaces rather than tabs where the language and toolchain allow it. Use spaces around operators and after commas, one statement per line, and blank lines between members and logical steps.
- Use descriptive, role-specific names. Prefer camelCase for local variables, parameters, and private fields without a leading underscore, and PascalCase for types and members where those conventions fit the language. Preserve idiomatic naming in languages with different conventions.
- In C#, prefix interfaces with `I`, qualify instance member access with `this.`, put opening braces on a new line, and use braces for control-flow bodies. Place `System` using directives first, followed by other using directives in alphabetical order.
- In C++, qualify instance member access with `this->` where supported, place opening braces on the same line, and attach pointer and reference symbols to the type. Preserve existing include order, macro bodies, and raw string contents.

## Validate and report

For implemented corrections, run the smallest relevant validation first and complete the checks needed for the affected behavior and contracts. Depending on the change, this may be compilation, lint, symbol analysis, existing focused tests, or manual reproduction. Reproduce a reported bug when practical before confirming its fix.

Do not add tests merely to assert that deleted text or symbols are absent. Add or change tests when they verify a meaningful behavior or contract affected by the correction. A passing build or test suite supports a change but does not independently prove the absence of dynamic or external consumers.

Broaden or repeat validation only when another change, failure, or concrete unresolved concern justifies it. Report checks that could not run and configurations or consumers that remain outside the inspected scope. Never claim the entire system is free of dead code after reviewing only part of it.

Present actionable findings first, ordered by practical impact. For each finding, provide:

- A precise file and line location, with the relevant symbol when helpful.
- The issue and the evidence that establishes it, including relevant callers, registrations, or diagnostics.
- The concrete consequence and the smallest recommended correction.
- Confidence and any limitation on the conclusion, kept separate from severity. Dead code is not automatically a high-severity issue.

Separate unresolved candidates from confirmed findings, and briefly identify the reviewed scope and validation performed. Distinguish changes already made from recommendations. When there are no substantiated findings, say so plainly without inventing cleanup work or implying exhaustive coverage.

### Summary of checks performed

Include a concise summary of checks performed in every final review, after findings and unresolved candidates. Include checks that found no issues, even when other checks produced findings. During the review, keep track of the areas actually inspected, the methods used, their results, and material limitations so this summary reflects work performed.

Use a short bullet list rather than a table. Write each item as **Area:** result and material limitations, using one or two short sentences. Do not add separate scope or method fields. Always include an explicit entry for unused, unreachable, and obsolete code. Include the other maintainability criteria actually evaluated, plus requested or relevant checks that were skipped or could not be completed. Group related checks only when their coverage and results remain clear.

Use these result distinctions, phrased in the user's language:

- **Findings reported:** reference the corresponding findings without repeating their full descriptions.
- **No issues found in the reviewed scope:** the stated check was performed and produced no substantiated finding. State any sampling or coverage limit; this is not proof that the entire system has no such issue.
- **Inconclusive:** investigation was attempted, but missing evidence or an unresolved question prevents a conclusion. Identify what remains unresolved, including any candidate awaiting investigation.
- **Not checked:** the check was not performed. Briefly explain why, such as being outside the requested scope or requiring unavailable tooling.
- **Not applicable:** the area does not apply to the reviewed code; state the concrete reason.

Mention scope or method in the summary only when needed to qualify the result, such as partial coverage, inspection without runtime verification, or unexamined external consumers. Keep detailed search procedures, file lists, and commands in the findings or validation notes only when useful. A successful build, passing tests, or zero compiler warnings alone does not establish that a dead-code review was performed.

Do not populate the summary from this skill's checklist without evidence that the checks occurred. An area can contain confirmed findings while coverage remains partial or other candidates remain unresolved; retain both facts. Never turn a skipped, blocked, or inconclusive check into a clean result. Keep the summary proportional to the review instead of listing every file or symbol inspected.
