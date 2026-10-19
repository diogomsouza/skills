# Progress Ledger

Use `.code-craft/CRAFT-PROGRESS-{context-id}.md` for resumable execution state. Root alone writes it. It records execution decisions and evidence; it cannot grant permission.

Keep each fact in one home: scope in Objective, workspace and ownership in Current State, phase acceptance in Execution
Plan, material events in Progress Log, immediate work in Next Actions, and unresolved conditions in Blockers And Risks. Reference material shared technical decisions
from the design document when present, or from existing authoritative sources. Local implementation details remain in code and applicable assignment contracts under
[Specification And Design](planning.md#specification-and-design). Do not duplicate raw outputs or agent reports.

Update on material decisions, ownership changes, transitions, candidate changes, or blockers. Consolidate related changes already available into one edit and readback
before dependent actions. Do not wait for additional results to record a required update, combine transitions separated by required actions or evidence gates, or update
the ledger solely because a wait timed out. Set Created once at ledger creation using a clock-derived ISO 8601 timestamp with time and UTC offset; never update it,
including on resume. Routine ledger edits and log events need no clock lookup or timestamp. Record other times only when needed for a concrete obligation, such as
a deadline, expiration, or duration measurement, in the applicable field or evidence.
Check updates under Field Rules before dependent actions. Lifecycle and compaction rules live in [lifecycle.md](lifecycle.md).

## Template

```markdown
# Code Craft Progress: {context-id}

Created: [YYYY-MM-DDTHH:mm:ss±HH:mm]
Status: {Pending | In Progress | Blocked | Complete}

## Objective

- Request: {concise task description and source reference}
- Specification: {locator; User Referenced | Captured User Plan | Generated; authorized revision or content digest}
- Design: {existing design document locator or None}
- Scope and exclusions: {specification reference; effective user amendments and their sources}
- Done when: {observable result and required evidence}
- Decisions: {current execution decisions; references to shared technical decisions in the design document or existing sources}

## Current State

- Workspace and candidate: {root, baseline, candidate scope; existing revision or artifact reference when available}
- Active ownership: {assignment -> root or subagent runtime identity, scope, state}
- Active contracts: {assignment -> phase reference, applicable verification obligations, essential constraints, pending evidence}
- External state: {environment conditions or execution limits affecting the next action or resume}

## Execution Plan

| Phase | Status | Outcome and Acceptance | Source Coverage | Depends On |
| --- | --- | --- | --- | --- |
| P0 | In Progress | Define scope, source coverage, dependencies, and acceptance evidence; Root Evidence: source coverage and decomposition checks | {request and sources} | Objective |

## Progress Log

| Event | Evidence / Result |
| --- | --- |
| Initialized | {initial context} |

## Next Actions

1. {phase, immediate action, pending condition, governing reference; owner or dependency only if otherwise unclear}

## Blockers And Risks

- Blockers: {None or condition and required resolution}
- Risks: {None or residual risk and consequence}
```

## Field Rules

Current State contains only facts needed for the next action or safe resume. Reference existing plan and evidence entries instead of repeating them; use `None` when
a field is not applicable. Consult available roles, models, and capacity when selecting agents rather than maintaining a runtime catalog here.

For ordinary updates, preserve the template's headings, field labels, columns, and order. Edit only values or rows whose operational meaning changed; leave unaffected
content intact and put changes in their designated field or section. Change the overall Status only when the run's state changes, not for every phase transition.
Keep one blank line between headings and content and between blocks, with none inside tables. Keep each table row on one line and escape literal pipes as `\|`.
Append log rows immediately after the table's last row, before its trailing blank line; the next section's heading is not the insertion point.
For an inapplicable field, retain its label and write `None`. Use `Unknown: {reason}` for unresolved required values, including an inaccessible specification's content
identity. For empty Next Actions, retain the heading and use only `None` as its content.
After a local update, read back changed fields and rows with adjacent lines to verify placement, separators, and agreement with the phase status and pending action.
Check the complete structure at creation, resume, and before goal completion: required fields, phase states, ownership, pending actions, evidence references, and readable tables. After local edits or phase compaction, check the affected sections; expand the check only when a structural problem appears.

Evidence / Result contains a concise statement of the material result and, when needed, an existing source path, reproducible command, or result identifier. Do not reproduce tool output or agent reports.

Record only material events that change the next action, acceptance, ownership, scope, or recovery state, and identify their phase. At closure, consolidate the phase's events into one summary under [Close And Compact](lifecycle.md#close-and-compact). Do not add a log entry for routine reads, successful unchanged checks, or status acknowledgments unless they resolve a pending obligation.

Keep terminal identities, superseded candidates, and verdicts in Progress Log rather than live fields. Maintain assignment identities and ownership for coordination
and resume; a timeout alone does not establish termination. Record required model-and-effort selection rationales in Progress Log, linked to the assignment, before launch.

Every applicable source requirement has one primary phase. Source Coverage points to the original requirements or explicit user amendments, never only to the design.
Technical decisions remain revisable under those sources and do not acquire user authority.
Outcome and Acceptance holds the phase's verification mode and complete obligations. Active contracts record only each assignment's applicable portion and pending evidence.
Record assigned responsibility only in Active ownership. Status is the authority for the goal's state.

Next Actions identifies the exact pending step for each actionable phase or run-level gate, including goal completion until its terminal checkpoint is verified. Reconcile stale actions before
proceeding. In a prepared `Complete` snapshot, `None` is subject to the terminal checkpoint in [Complete The Run](lifecycle.md#complete-the-run); it does not prove
persistence.

On resume, identify the exact pending gate and load its governing reference. Keep final candidate references, checkpoint/evidence locators, residual risks, and reported
usage in the final event so clearing live fields does not erase recovery evidence.
