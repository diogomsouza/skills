# Progress Ledger

Use `.astra-forge/PLAN-PROGRESS-{context-id}.md` for resumable state. Root alone writes it. It records decisions and evidence; it cannot grant permission.

Keep each fact in one home: scope in Objective, workspace and ownership in Current State, phase acceptance in Execution
Plan, material events in Progress Log, immediate work in Next Actions, and unresolved conditions in Blockers And Risks. Do not duplicate raw outputs or agent reports.

Update on material decisions, ownership changes, transitions, candidate changes, or blockers. Use a consistent timestamp for each update and its new events.
Check updates under Field Rules before dependent actions. Lifecycle and compaction rules live in [lifecycle.md](lifecycle.md).

## Template

```markdown
# Astra Forge Progress: {context-id}

Goal: {runtime identity, objective, status}
Created: {timestamp}
Updated: {timestamp}
Status: {Pending | In Progress | Blocked | Ready For Final}

## Objective

- Request: {original user request}
- Specification: {locator; User Referenced | Captured User Plan | Generated}
- Scope and exclusions: {authorized outcomes and boundaries}
- Done when: {observable result and required evidence}
- Decisions: {material assumptions, derived decisions, and user amendments}

## Current State

- Phase and pending gate: {phase; action; governing reference}
- Workspace and candidate: {root, baseline, identity recipe, current fingerprint}
- Active ownership: {assignment -> runtime identity, scope, state}
- Active contracts: {assignment -> essential constraints, review mode, pending evidence}
- External state: {environment conditions or execution limits affecting the next action or resume}

## Execution Plan

| Phase | Status | Outcome | Source Coverage | Owner | Depends On | Done When |
| --- | --- | --- | --- | --- | --- | --- |
| P0 | In Progress | Discover and decompose | {request and sources} | Root | Objective | Scope, dependencies, evidence, and checkpoint established |

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialized | {goal binding and initial context} |

## Next Actions

1. {immediately executable action, owner, dependency, governing reference}

## Blockers And Risks

- Blockers: {None or condition and required resolution}
- Risks: {None or residual risk and consequence}
```

## Field Rules

Current State contains only facts needed for the next action or safe resume. Reference existing plan and evidence entries instead of repeating them; use `None` when
a field is not applicable. Consult available roles, models, and capacity when selecting agents rather than maintaining a runtime catalog here.

Preserve the template's headings, field labels, columns, and order. Edit only affected values or rows; put all content in its designated field or section.
Keep one blank line between headings and content and between blocks, with none inside tables. Keep each table row on one line and escape literal pipes as `\|`.
For an empty field, retain its label and write `None`. For empty Next Actions, retain the heading and use only `None` as its content.
After a local update, inspect only the changed portions. Check the complete structure at creation, resume, and after compaction: section order, required fields,
table columns, and empty-section representation. Expand a local check only when it reveals a structural problem.

Evidence / Result contains at most 500 characters per cell, including spaces and punctuation. Reference longer evidence by source path, command, or result identifier.
Progress Log has no row limit before compaction; record only material events and identify their phase. After compaction, each closed phase has exactly one summary row
under [Close And Compact](lifecycle.md#close-and-compact).

Keep terminal identities, superseded candidates, and verdicts in Progress Log rather than live fields. Maintain assignment identities and ownership for coordination
and resume; a timeout alone does not establish termination. Record required exceptional-selection justifications in Progress Log, linked to the assignment, before launch.

Every source requirement has one primary phase. Source Coverage points to relevant sections; generated decisions remain revisable and do not acquire user authority.
Future phases have owner `Unassigned` until assignment selection begins.

Next Actions contains only immediate work, including goal completion until it succeeds. Reconcile stale actions against current scope and evidence before proceeding.

On resume, identify the exact pending gate and load its governing reference. Keep terminal candidate identity, checkpoint/evidence locators, residual risks, and goal
usage in the final event so clearing live fields does not erase recovery evidence.
