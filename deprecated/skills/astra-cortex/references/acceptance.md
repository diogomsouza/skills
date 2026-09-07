# Review, correction and acceptance

## Applicability and evidence

Exploratory work, including P0 and explorer assignments in any phase, requires no review or ACCEPT/REJECT review verdict. Consume its findings and confirm that the
required questions, evidence and deliverables are complete. For P0, this includes specification coverage, feasible phase decomposition, dependencies and validation.
If exploration is incomplete, return it to In Progress and finish the missing work. Use ledger.md's exploratory closure path without a review stage. An implementation
phase containing exploration still requires review of its implementation.

For phases requiring review, identify the exact reviewed content using Git or another reproducible method, including new files, deletions and relevant generated/external
artifacts. Keep coordination state and unrelated user work out of implementation
deltas. Root remains responsible for conformance of the integrated result, not only isolated outputs.

Review an identifiable, stable snapshot. Unaffected work may continue; the entire workspace need not stop. When reviewed content or relevant dependencies change,
invalidate affected evidence and rerun the necessary checks. Integration must preserve the validity of evidence before it can be reused. A commit of identical content or
routine ledger bookkeeping does not alone invalidate review. No bundled scripts or mandatory hashing procedure are required.

## Review contract

Every phase requiring review receives an explicit ACCEPT or REJECT decision with its scope and evidence. Dispensable phases follow the justified Not Applicable rule in
ledger.md instead of a fictitious implementation review. Perform the review directly or delegate it, according to the environment's independence requirements and your
judgment. Self-review is allowed when those requirements permit it; implementation or a completion claim alone is not review evidence. Inspect behavior, consumers,
regressions, relevant failure paths and requirements, not merely formatting or the changed lines.

Report a defect only when all of these hold:

- It violates an approved requirement, acceptance criterion or directly affected guarantee.
- Its cause and location are identifiable, its impact is material and its correction is actionable.
- Evidence supports confidence of at least 80 out of 100. Confidence is a reviewer assessment, not a measured probability; classify severity separately.

Report all qualifying defects, merging duplicates by root cause. Each finding includes severity, confidence, location, causal evidence, impact and a focused in-scope
correction. Exclude style preferences, speculative improvements, unrelated pre-existing debt and unapproved expansion.

REJECT when any qualifying defect remains or required validation is missing. Distinguish an evidence gap from a confirmed bug; specify the check needed to resolve it.
ACCEPT only when no qualifying defect remains and required evidence supports the phase criteria. This is not a guarantee that all possible bugs have been found. Optional
unavailable checks may be risks; they must not be relabeled as required failures or used to waive required evidence. A concern below the defect-confidence threshold does
not waive a required check; record material unresolved uncertainty as an evidence gap or residual risk, as appropriate.

## Correction cycle

Choose how to schedule review and correction without losing findings or mixing evidence from different snapshots. Before changing shared content under review, finish the
required reviews of that snapshot or explicitly supersede it and invalidate affected pending results. Preserve unresolved findings across revisions. Unrelated work does
not impose a mandatory wait before correction.

On a phase REJECT, apply ledger.md's correction transitions and map remedies to scope. Provide qualifying findings and missing evidence to the executor; choose assignment
reuse or replacement as appropriate. Review affected behavior after correction and execution checks, and carry forward other evidence only when the delta cannot affect
it. Exploratory work follows its completion path without review.

Repeat until acceptance conditions pass. Persistent defects or churn require revisiting the implementation approach and assumptions, not merely repeating identical fixes.
Before changing accepted behavior, reopen affected phases and any dependents whose guarantees or acceptance evidence are affected. Missing authority or evidence keeps the
phase open or Blocked; do not accept simply to end a correction cycle.

## Checkpoint and closure

After required review passes, remain In Review for the checkpoint; exploratory phases remain Done. Commit exactly the phase delta where permitted. Inspect staging,
preserve unrelated changes and staging, and protect the selected content and shared Git index from concurrent changes during the checkpoint. Choose the isolation or
coordination mechanism; unrelated implementation need not stop. Verify that the commit matches the content whose required evidence passed. If hooks or integration
change it, repeat the affected execution checks and required review before acceptance. An existing commit satisfies the checkpoint only when its exact phase delta and
content are verified.
Never commit the live progress folder or aggregate unrelated phases. Follow project conventions; do not push, weaken hooks or alter Git configuration to force a
checkpoint.

Record the exact commit, or justify a skip only for no Git worktree, no phase-local delta or commits prohibited by applicable instructions or permissions. Hook failures,
conflicts and other operational errors are not justified skips. After a successful checkpoint or justified skip, close the phase under ledger.md. A failed checkpoint or
ledger update retains the unfinished closure; record Blocked when its resolution requires an external change. Never use a commit or an agent verdict alone as proof of
phase acceptance.

After all phases close, check the cumulative result and all specification requirements. Review material cross-phase interactions not already covered; reuse valid evidence
and rerun checks when changes, failures, unresolved concerns or applicable requirements justify it. Final assurance is a completion check, not an extra implementation
phase. Apply ledger.md readiness before completing the goal.
