# Phase Lifecycle And Completion

Root records transitions in the [ledger](progress-template.md) before dependent work. Update state, evidence, and next actions together; check the changed portions.
On write or readback failure, reconcile durable state before continuing.

## Transitions

| State | Meaning and next transition |
| --- | --- |
| Pending | Dependencies satisfied: enter In Progress before work. |
| In Progress | Execution and ownership release pass: enter Done. |
| Done | Enter In Review before acceptance validation or verifier launch. |
| In Review | Acceptance evidence passes: enter Accepted. Candidate corrections return to In Progress. |
| Accepted | Phase acceptance criteria passed. |
| Blocked | Record cause and prior activity; resume that activity after resolution, never jump directly to Accepted. |
| Not Applicable | An unstarted phase was removed with a scope-consistent reason and checkpoint. |

Read-only discovery may move directly from `In Progress` to `In Review`. An active phase cannot be discarded while ownership, writes, or obligations remain unresolved.
Resolve those first, then record a justified disposition.

Acceptance requires mapped requirements, the selected verification mode, released writers, and current candidate evidence where applicable. Reopen an accepted phase to In
Progress before affecting accepted behavior; use In Review for evidence-only reevaluation. Each phase closes through the procedure below.

## Mandatory Phase Commit

At the end of every phase, commit all task-owned changes before dependent work starts. The commit scope comprises deliverables and current-run coordination records.
Inspect tracked and untracked files and stage only authorized paths, using explicit paths for any ignored run records that must be included.

Exclude unrelated changes, other runs' records, pre-existing staged content, and active writers' files. Preserve the user's index and worktree. Root serializes ledger
updates and checkpoint creation so concurrent phases cannot mutate the snapshot being committed. If the accepted delta cannot be isolated safely, block closure.

Skip only with `Skipped: no task-owned changes` or `Skipped: no Git repository`, after checking the relevant condition. Never create an empty commit. Evaluate changes
after preparing required closure records; do not manufacture timestamp-only updates for an already closed phase. Missing Git executable, identity, permissions, failing
hooks, or a commit prohibition is a blocker, not absence of a repository. Do not change Git configuration, disable hooks, or push to satisfy the gate.

## Close And Compact

After acceptance evidence passes, record `Accepted` (or a justified `Not Applicable` disposition) with the phase outcome, evidence, released ownership, and next actions,
preserving the detailed Progress Log. Commit that snapshot with the task delta, identifying the run and phase in the commit message. Closure requires both the acceptance
record and its verified commit, unless a skipped disposition applies. The ledger need not store its own commit hash; use Git history to locate the committed phase record
on resume.

Do not release dependencies on a failed or uncertain commit. Record the error and resume from the last verified checkpoint. Reuse a successful checkpoint after an
interruption; revalidate deliverable changes made by hooks before accepting them.

After confirming the phase commit, replace that phase's log entries with exactly one summary row, then read back before starting any dependent phase. Without Git, compact
after confirming the phase's acceptance evidence and skipped disposition. A verified no-change closure may reuse its existing summary. Independent phases already running
may continue; root serializes log edits.

The summary identifies the phase, outcome, candidate, commit or skipped disposition, essential verification evidence, agent dispositions, and carried risks. Its Evidence
/ Result cell obeys the 500-character limit in the progress template. Use recoverable references for detail; keep unresolved obligations in the current contracts or risks
before removing their log entries. Place the summary at the phase's closure time and preserve other phases' entries. Run-level events remain separate.

Compaction is a working-tree update included in the next task commit, or the terminal commit for the last phase. Do not amend the phase commit containing the detailed
log. If interrupted after commit but before compaction, complete and verify the summary before releasing dependencies. When a phase reopens, retain its prior summary and
append new events; its next closure commit preserves both before replacing them with one updated summary.

## Complete The Run

Final assurance follows [verification](verification.md). Before goal completion require:

- every phase closed, with its checkpoint and source-coverage evidence;
- final assurance passed for the current reproducible candidate;
- all required agents terminal, ownership released, and no pending evidence or blocker;
- limitations and residual risks ready for the user handoff.

Record `Complete goal and finalize ledger` in `Next Actions` and read it back. Keep that action pending while calling the goal completion tool under its contract. If
completion fails, preserve the unfinished state and report the blocker; never manufacture success. Goal `blocked` updates must obey the runtime's recurrence rules.

After goal completion succeeds, record its authoritative status and usage, final candidate, evidence, and risks. Set ledger status to `Ready For Final`, clear active
ownership and selections, and only then set `Next Actions` to `None`. Check changed portions and deliver outcome, files, validation, risks, and ledger locator. Include
reliable goal token usage and elapsed time when available; never estimate missing metrics.

Before delivering, commit any remaining task-owned terminal ledger changes using the same commit protocol; no commit is needed if nothing changed. A completed runtime
goal does not prove this final persistence step succeeded. On commit failure, report the pending checkpoint and retry it on resume without repeating goal completion.

If interrupted between goal completion and ledger finalization, reconcile the completed goal with terminal evidence and finish that ledger update. Revalidate candidate
identity and ownership before reemitting a pending handoff; reuse valid evidence rather than rerunning accepted work. If the candidate drifted, report the mismatch and
follow the tool's permitted goal lifecycle before further execution.
