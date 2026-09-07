# Progress template

Copy the Markdown block into the run's progress file. Keep the seven sections in this order. Use ledger.md for state transitions and cleanup. Store each fact once: goal
in the header, specification/scope in Objective, current evidence in Current State, delegated assignments in Active Assignments, phase criteria/status in Execution Plan,
closed outcomes in Progress Log. Use None for known-empty fields and a single None row for an empty table. Actual assignments require concrete Model / Effort values under
ledger.md; Unknown or Unverified is allowed only for other missing facts. Add implementation phase rows as P0 investigation establishes them; replace example values with
actual facts. Dates include the timezone offset. Use this template only for a new run, not to reset
resumed progress.

```markdown
# Astra Cortex Progress: {context-id}

Goal: {actual identity or exact objective} — {actual status}
Task: {short task name}
Created: {actual date/time}
Updated: {actual date/time}
Status: Pending

## Objective

- Request: {original user request or exact durable source}
- Specification: {exact locator, or Pending during initial P0}; origin: {User Referenced / Saved Plan / Generated / Pending}
- In scope: {approved outcomes}
- Out of scope: {exclusions}
- Done when: {overall result and acceptance evidence}
- Amendments: None

## Current State

- Current phases and gates: P0 — Pending; ledger initialized, investigation not started
- Working set: {workspace, protected changes and relevant external state}
- Current evidence: {goal creation or reuse evidence; reviewed content and validation references}
- Open review/correction obligations: None
- Assumptions and decisions: {invocation/eligibility basis; material assumptions or decisions}
- Final assurance: {required cumulative evidence; pending}

## Active Assignments

| Assignment | Phase | Agent / Role | Model / Effort | Responsibility | State |
| --- | --- | --- | --- | --- | --- |
| None | — | — | — | — | — |

## Execution Plan

Phase status: Pending | In Progress | Done | In Review | Accepted | Blocked | Not Applicable

| ID | Status | Work Item | Source Coverage | Owner | Depends On | Done When | Checkpoint Plan |
| --- | --- | --- | --- | --- | --- | --- | --- |
| P0 | Pending | Investigate and define phases | Objective and relevant project sources | Root | None | Scope mapped to feasible phases, dependencies and evidence | Exact specification delta, or justified skip |

## Progress Log

| Date / Time | Phase | Summary | Evidence / Checkpoint |
| --- | --- | --- | --- |
| {actual initialization time} | P0 | Initialized | Goal verified; investigation pending |

## Next Actions

1. Start P0 investigation and maintain phase status under ledger.md's common lifecycle.

## Blockers And Risks

- Blockers: None
- Risks: None
```

Header Status is Pending, In Progress, Blocked or Ready For Final. Goal status is the actual runtime status, not a second phase verdict. Current State holds only live
facts; clear resolved obligations. Current evidence holds the goal receipts and content identity; Final assurance holds cumulative validation results and references those
facts without copying them. Use ledger.md for Next Actions and final normalization. Resolve a Pending specification before P0 closes. Future phase owners are Unassigned;
active owners identify the responsible party, with assignment details kept only in Active Assignments. An empty assignment table does not imply missing work delegation or
require creating agents.
