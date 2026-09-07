# Progress maintenance

For a new run, create `.astra-cortex/PROGRESS-{context-id}.md`, with context ID `YYYY-MM-DD-short-slug` and a suffix only for collisions, from
[progress-template.md](progress-template.md). Reuse the authoritative file on resume. On Windows, attempt `attrib +h ".astra-cortex"` from the workspace root after folder
creation; the leading dot alone does not hide it. Failure to set the attribute must not block the task.

Initialize and read back the file before phase work starts, with header Status Pending and P0 as the only phase, also Pending. Set the header Status to In Progress when
the run starts. All Execution Plan phases follow the same definitions and transitions below, including discovery, implementation and correction.

Maintain one authoritative Markdown file; do not add ledger-specific helper scripts, a JSON mirror or an agent-history archive. Keep the template's seven sections and
column shapes, subject to the prior-format recovery rule below. Replace placeholders with actual facts or explicit unknowns. Root maintains the file; it records
execution, not spawn permissions.

## Updates and states

Update affected sections when scope, ownership, phase status, review results, checkpoints or blockers materially change. Set Updated from the actual clock; read back the
changed sections before dependent work. Keep next actions current: zero to three concrete immediate steps, not a copy of the phase plan or a tool authorization gate.
Avoid full-file readbacks and raw tool output.

For each transition, update Updated, the affected Execution Plan rows, Current State, active ownership, Next Actions and Progress Log together in one edit. Record a
non-closing transition as a current event; use the compacted phase summary for Accepted or Not Applicable. Confirm readback before further dependent work. If writing
or verification fails, repair the record before advancing. Update only the phases affected by the event; parallel phases close independently.

Use phase status as follows:

- Pending: the phase is recorded, but its work has not started.
- In Progress: discovery, implementation or correction is underway, including rework following a rejected phase review.
- Done: phase execution and its required checks finished and writers released ownership; review or, for exploration, closure remains.
- In Review: acceptance evaluation is underway, including validation, delegated reviews, evidence reconciliation and the acceptance checkpoint.
- Accepted: phase criteria, required review and evidence, checkpoint, closing summary and ledger readback all passed.
- Blocked: an external condition or missing authority prevents the required activity; record the interrupted state and the resolution needed.
- Not Applicable: authoritative scope decisions establish that the phase is unnecessary, with existing changes accounted for and a dated closure summary.

Apply Pending -> In Progress -> Done -> In Review -> Accepted to phases requiring review. Exploratory phases, including P0, use Pending -> In Progress -> Done -> Accepted
without review. Record each transition immediately when its triggering event occurs and read back the changed sections before further work. Status records actual
execution; do not backdate transitions, reconstruct skipped states at closure or mark work as started in anticipation.

1. Add each new phase as Pending before executing it. When phase work starts, immediately change it to In Progress.
2. When execution and its required checks finish and candidate writers release ownership, record Done. Discovery and planning also pass through Done.
3. When acceptance review starts, immediately record In Review. Completing one assignment alone does not establish that the entire phase is Done or reviewed.
4. After an ACCEPT decision, keep In Review until the checkpoint requirement passes. Then record Accepted, the checkpoint evidence, compacted phase summary and updated
   next actions in one ledger edit and confirm readback. Exploratory phases remain Done while their completion evidence and checkpoint are confirmed, then close as
   Accepted in the same way, without an In Review state or review verdict. Only this completed closure releases dependent work.
5. After a REJECT decision for the phase, immediately return it to In Progress and retain the findings and missing evidence as correction obligations. Complete the
   corrections and execution checks, record Done, then start review and record In Review again. Follow acceptance.md to protect snapshots still under review.
6. Evidence gathering and reconciliation during an ongoing review remain In Review until the phase decision. Root records that decision from required reviews and
   evidence under acceptance.md; an assignment verdict alone does not close the phase. Do not defer recording an issued phase REJECT.
7. When accepted work is reopened for correction, record In Progress and identify affected dependents whose guarantees or evidence must also be reopened. Repeat
   the applicable cycle, including Done -> Accepted for exploration. For review-only revalidation of unchanged implementation, reopen In Review when that evaluation
   starts; preserve superseded evidence.
8. When blocked, record Blocked and the interrupted state. Once resolved, resume the required activity and its corresponding state without skipping remaining gates;
   never move directly from Blocked to Accepted.

Start dependent work only after its prerequisites are Accepted or justified Not Applicable. Independent phases may run concurrently. Not Applicable cannot hide
unfinished required work. Phase status changes do not themselves authorize writes to content protected by an ongoing review or release assignment ownership.
Execution Plan is the phase acceptance record; assignments do not need a duplicate Accepted state. An explorer's handoff at any stage requires no separate review and
does not close its containing phase. Classify phase work by its actual scope: exploration within an implementation phase does not exempt that implementation from review.

## Active assignments

After spawning, resuming, completing, failing or cancelling an assignment, and before waiting for agents, reconcile the entire table against current runtime assignments.
Persist and read back the reconciled table before unrelated work. Every running assignment must have a row, subject to the explicit metadata-blocker handling below;
preserve other active rows when removing a finished one.
Use an empty table or None only after confirming that no active assignment or unconsumed handoff remains. If runtime status is unavailable, retain known rows and record
the uncertainty instead of clearing the table.

Active Assignments (Agent Selection in a prior-format file) is an observation table, not a selection policy. Record actual delegated assignments, including discovery and
review work: assignment, phase, agent identity/role, concrete effective model and reasoning effort, responsibility and current state. Immediately after spawn, verify the
pair from authoritative runtime data or the subagent's session metadata and record it before the next unrelated action. Recheck on resume or configuration change.
For an actual assignment, Model / Effort must contain both concrete values, never Unknown, Unverified, inherit or blanks. Do not infer them from an agent's claims or
the parent's settings alone. If the values cannot be verified, retain any existing row and explicitly record the assignment identity, responsibility, state and missing
metadata in Blockers And Risks. Mark assignment reconciliation incomplete and recover the metadata before claiming the table is current; do not insert invented values
or a None row to conceal the gap. This is a recording requirement, not a model-selection or pre-spawn approval policy.

When an assignment finishes, fails or is cancelled, consume the available result, confirm ownership release and retain evidence or unresolved obligations in Current State
or Blockers And Risks; then remove its row. Keep its actual state visible until that handoff is complete, even if the agent is idle. Omit idle agents only when they have
no outstanding assignment or handoff; removing a row does not require closing the underlying agent or thread. Decide lifecycle, reuse and further delegation under the
live environment. If work resumes, record the actual assignment
again. Update the phase Owner to its current responsible party or Root so a finished assignment does not retain apparent ownership.

## Bounded history

Progress Log uses the template's time-first table. During an open phase, keep only material events needed to explain its pending work. At closure replace its events with
one phase summary: outcome, decisive review/evidence, checkpoint or justified skip, and material residual limitations. Keep one row per closed phase in Execution Plan
order, followed by current material events. No completed-agent history or separate archive is required.

Use actual `YYYY-MM-DD HH:mm:ss ±HH:mm` timestamps in the task timezone, or UTC if unavailable. A closed summary uses its closure time; include the covered time range
only when useful for a long phase. Do not change closed-row times on resume or formatting. Unknown historical times stay unknown. On reopening, retain relevant previous
acceptance/checkpoint facts as superseded context in Current State; replace the old summary on reclosure, preserving necessary lineage.

Keep unresolved obligations in their current home rather than losing them during compaction. The closure edit follows Updates and states above; it cannot form a
transaction with Git, goal tools or runtime state.

## Recovery and final readiness

On resume, reconcile the file against the specification, live goal, Git, evidence and ongoing work. Resolve conflicting progress files or goals. An empty assignment table
does not prove all runtime work has stopped. Recover missing facts from evidence, disclosing reconstruction. Revalidate according to changes and uncertainty; do not rerun
unchanged passing checks merely because the run resumed. Reopen acceptance only where its evidence or guarantees are affected.

If the commit succeeded before closure failed, verify its exact phase delta and completion evidence, including required review, then close with that existing commit.
Do not create a duplicate. If a prior-format run is resumed, retain one authoritative state and migrate only when requested, preserving current obligations.

Before goal completion require all phases Accepted or justified Not Applicable, full requirement coverage, passing final evidence, valid checkpoints, no required blockers
or unfinished work, and no ongoing writes that can alter delivered content. Idle retained threads do not prevent completion when they have no outstanding obligations or
writes. At that point Next Actions may contain only goal completion and final progress normalization; these are not unfinished implementation. Record the actual
completion receipt and returned usage/elapsed time in Current evidence, and final validation in Final assurance. Update the header's goal status, clear Next Actions and
set Ready For Final only after completion succeeds. Retain final content/evidence references for resume. Reemit an unchanged completed handoff after revalidation without
redoing work. Final normalization cannot supply missing phase transitions, acceptance evidence or checkpoints. Confirm the normalized sections by readback before final
delivery; retain required unfinished assignments and obligations until they are actually resolved.
