# Progress maintenance

For a new run, create `.astra-cortex/PROGRESS-{context-id}.md`, with context ID `YYYY-MM-DD-short-slug` and a suffix only for collisions, from
[progress-template.md](progress-template.md). Reuse the authoritative file on resume. On Windows, attempt `attrib +h ".astra-cortex"` from the workspace root after folder
creation; the leading dot alone does not hide it. Failure to set the attribute must not block the task.

Maintain one authoritative Markdown file; do not add ledger-specific helper scripts, a JSON mirror or an agent-history archive. Keep the template's seven sections and
column shapes, subject to the prior-format recovery rule below. Replace placeholders with actual facts or explicit unknowns. Root maintains the file; it records
execution, not spawn permissions.

## Updates and states

Update affected sections when scope, ownership, phase status, review results, checkpoints or blockers materially change. Set Updated from the actual clock; read back the
changed sections before dependent work. Keep next actions current: zero to three concrete immediate steps, not a copy of the phase plan or a tool authorization gate.
Avoid full-file readbacks and raw tool output.

Phase path: Pending -> In Progress -> Done -> In Review -> Accepted. Persist In Progress before implementation; Done only after phase implementation and execution checks
finish and writers can no longer change its review candidate. Enter In Review before acceptance review. P0 may move In Progress -> In Review after discovery/planning,
including after corrections to that planning. An assignment handoff or a review verdict is evidence, not an automatic phase transition.

Start a dependent implementation phase only after its prerequisites are Accepted or justified Not Applicable. Independent phases may be active concurrently; dependencies
do not impose an order on unrelated discovery or assignments within an active phase. Not Applicable needs an authoritative scope reason, disposition of any existing
changes, and its own dated closure summary; it cannot hide unfinished required work. After REJECT, retain In Review while gathering findings or missing evidence. Move to
In Progress only before a correction writes candidate content, then use the implementation path or P0 exception. Before changing accepted behavior, reopen affected phases
and dependents whose guarantees or evidence are affected. Blocked records the interrupted gate and required resolution; resume that gate without skipping the remaining
transitions. Never backdate or invent transitions.

## Active assignments

Active Assignments (Agent Selection in a prior-format file) is an observation table, not a selection policy. Record actual delegated assignments, including discovery and
review work: assignment, phase, agent identity/role, concrete effective model and reasoning effort, responsibility and current state. Immediately after spawn, verify the
pair from authoritative runtime data or the subagent's session metadata and record it before the next unrelated action. Recheck on resume or configuration change.
For an actual assignment, Model / Effort must contain both concrete values, never Unknown, Unverified, inherit or blanks. Do not infer them from an agent's claims or
the parent's settings alone. If the values cannot be verified, report a tracking blocker with the assignment identity; never invent values or silently omit the assignment.
This is a recording requirement, not a model-selection or pre-spawn approval policy. Root-only execution leaves the table empty; it does not require creating agents.

When an assignment finishes, fails or is cancelled, consume the available result, confirm ownership release and retain evidence or unresolved obligations in Current State
or Blockers And Risks; then remove its row. Keep its actual state visible until that handoff is complete. Keep idle agents out of the table; removing a row does not
require closing the underlying agent or thread. Decide lifecycle, reuse and further delegation under the live environment. If work resumes, record the actual assignment
again. Update the phase Owner to its current responsible party or Root so a finished assignment does not retain apparent ownership.

## Bounded history

Progress Log uses the template's time-first table. During an open phase, keep only material events needed to explain its pending work. At closure replace its events with
one phase summary: outcome, decisive review/evidence, checkpoint or justified skip, and material residual limitations. Keep one row per closed phase in Execution Plan
order, followed by current material events. No completed-agent history or separate archive is required.

Use actual `YYYY-MM-DD HH:mm:ss ±HH:mm` timestamps in the task timezone, or UTC if unavailable. A closed summary uses its closure time; include the covered time range
only when useful for a long phase. Do not change closed-row times on resume or formatting. Unknown historical times stay unknown. On reopening, retain relevant previous
acceptance/checkpoint facts as superseded context in Current State; replace the old summary on reclosure, preserving necessary lineage.

Close each phase in one ledger edit: status, summary, cleanup and next actions. Keep unresolved obligations in their current home rather than losing them during
compaction. No edit spans a transaction with Git, goal tools or runtime state.

## Recovery and final readiness

On resume, reconcile the file against the specification, live goal, Git, evidence and ongoing work. Resolve conflicting progress files or goals. An empty assignment table
does not prove all runtime work has stopped. Recover missing facts from evidence, disclosing reconstruction. Revalidate according to changes and uncertainty; do not rerun
unchanged passing checks merely because the run resumed. Reopen acceptance only where its evidence or guarantees are affected.

If the commit succeeded before closure failed, verify its exact phase delta and reviewed content, then close with that existing commit. Do not create a duplicate. If a
prior-format run is resumed, retain one authoritative state and migrate only when requested, preserving current obligations.

Before goal completion require all phases Accepted or justified Not Applicable, full requirement coverage, passing final evidence, valid checkpoints, no required blockers
or unfinished work, and no ongoing writes that can alter delivered content. Idle retained threads do not prevent completion when they have no outstanding obligations or
writes. At that point Next Actions may contain only goal completion and final progress normalization; these are not unfinished implementation. Record the actual
completion receipt and returned usage/elapsed time in Current evidence, and final validation in Final assurance. Update the header's goal status, clear Next Actions and
set Ready For Final only after completion succeeds. Retain final content/evidence references for resume. Reemit an unchanged completed handoff after revalidation without
redoing work.
