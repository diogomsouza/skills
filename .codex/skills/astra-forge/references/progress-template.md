# Progress Ledger

Use `.astra-forge/PLAN-PROGRESS-{context-id}.md` for resumable state. Root alone writes it. It records decisions and evidence; it cannot grant permission.

Keep each fact in one home: scope in Objective, workspace and ownership in Current State, phase acceptance in Execution
Plan, material events in Progress Log, immediate work in Next Actions, and unresolved conditions in Blockers And Risks. Do not duplicate raw outputs or agent reports.

Update on material decisions, ownership changes, transitions, candidate changes, or blockers. Use clock-derived ISO 8601 timestamps with time and UTC offset for Created,
Updated, and Time. Preserve Created and historical times; use the same current timestamp for Updated and the new events in each update.
Check updates under Field Rules before dependent actions. Lifecycle and compaction rules live in [lifecycle.md](lifecycle.md).

## Template

```markdown
# Astra Forge Progress: {context-id}

Goal: {runtime goal identity}
Created: {timestamp}
Updated: {timestamp}
Status: {Pending | In Progress | Blocked | Ready For Final}

## Objective

- Request: {concise task description and source reference}
- Specification: {locator; User Referenced | Captured User Plan | Generated}
- Scope and exclusions: {specification reference and any additional authorized boundaries}
- Done when: {observable result and required evidence}
- Decisions: {current execution decisions not already recorded in the specification}

## Current State

- Workspace and candidate: {root, baseline, identity recipe, current fingerprint}
- Active ownership: {assignment -> runtime identity, scope, state}
- Active contracts: {assignment -> essential constraints, review mode, pending evidence}
- External state: {environment conditions or execution limits affecting the next action or resume}

## Execution Plan

| Phase | Status | Outcome and Acceptance | Source Coverage | Depends On |
| --- | --- | --- | --- | --- |
| P0 | In Progress | Define scope, dependencies, and acceptance evidence; complete phase closure | {request and sources} | Objective |

## Progress Log

| Time | Event | Evidence / Result |
| --- | --- | --- |
| {timestamp} | Initialized | {goal binding and initial context} |

## Next Actions

1. {phase, immediate action, pending condition, governing reference; owner or dependency only if otherwise unclear}

## Blockers And Risks

- Blockers: {None or condition and required resolution}
- Risks: {None or residual risk and consequence}
```

## Field Rules

Current State contains only facts needed for the next action or safe resume. Reference existing plan and evidence entries instead of repeating them; use `None` when
a field is not applicable. Consult available roles, models, and capacity when selecting agents rather than maintaining a runtime catalog here.

Preserve the template's headings, field labels, columns, and order. Edit only affected values or rows; put all content in its designated field or section.
Keep one blank line between headings and content and between blocks, with none inside tables. Keep each table row on one line and escape literal pipes as `\|`.
Append log rows immediately after the table's last row, before its trailing blank line; the next section's heading is not the insertion point.
For an empty field, retain its label and write `None`. For empty Next Actions, retain the heading and use only `None` as its content.
After a local update, read back changed fields and rows with adjacent lines to verify placement, separators, and agreement with the phase status and pending action.
Check the complete structure at creation, resume, after compaction, and before goal completion: section order, required fields, timestamps, table continuity and columns,
cell limits, phase summaries, and empty-section representation. Expand other local checks only when they reveal a problem.

Evidence / Result contains at most 500 characters per cell, including spaces and punctuation. Reference longer evidence by source path, command, or result identifier.
Progress Log has no row limit before compaction; record only material events and identify their phase. After compaction, each closed phase has exactly one summary row
under [Close And Compact](lifecycle.md#close-and-compact).

Keep terminal identities, superseded candidates, and verdicts in Progress Log rather than live fields. Maintain assignment identities and ownership for coordination
and resume; a timeout alone does not establish termination. Record required exceptional-selection justifications in Progress Log, linked to the assignment, before launch.

Every source requirement has one primary phase. Source Coverage points to relevant sections; generated decisions remain revisable and do not acquire user authority.
Record assigned responsibility only in Active ownership. Consult the runtime for the goal's current status.

Next Actions identifies the exact pending step for each actionable phase, including goal completion until it succeeds. Reconcile stale actions before proceeding.

On resume, identify the exact pending gate and load its governing reference. Keep terminal candidate identity, checkpoint/evidence locators, residual risks, and goal
usage in the final event so clearing live fields does not erase recovery evidence.
