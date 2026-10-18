# Integration And Verification

## Bind Evidence To The Candidate

Root reconciles the cumulative diff, attributes changes, preserves unrelated work, and checks acceptance evidence. Route substantive review under [mandatory model
routing](delegation.md#mandatory-model-routing). Suspend writes to the complete candidate in the workspace before review.
Include the design document when present; it is part of the reviewed deliverable, not live coordination state. Bind the review to the specification's recorded content
identity and explicit user amendments. Reconcile unexplained source changes before using them as acceptance authority.

Independent phases may write only outside the frozen candidate and any dependencies or shared state that can affect its evidence. Root must also leave the included
design document unchanged. If the candidate covers the whole product, pause all product writers for the review. Do not narrow required coverage to keep writers running.

Record the workspace, review scope, and baseline in Current State, using existing project revision or artifact references when available. This skill does not require
an additional candidate digest. Inspect the diff and relevant files, including untracked files and required ignored outputs, before review and acceptance. On resume,
check for changes before reusing evidence. Project-required integrity checks remain applicable.

## Review A Phase

Use the [lifecycle](lifecycle.md) to enter `In Review`. Confirm execution evidence and applicable cumulative validation. Reuse successful checks when candidate scope,
environment, and provenance remain valid. Repeat only for a change, failure, or unresolved concern; final assurance does not itself require rerunning an unchanged suite.
Check implementation conformance and the design's compatibility with original requirements and explicit user amendments. Following the design alone cannot establish
acceptance; apply the source authority rules in [planning](planning.md#specification-and-design).

Acceptance covers all verification obligations recorded for the phase, across its assignments. Root authorship does not change the verification mode or substitute
root's implementation checks for required independent review. For independent modes:

1. End implementation ownership and bind the workspace, candidate scope, baseline, evidence, relevant source requirements, and bounded review contract.
2. For new review assignments, select fresh verifiers through [delegation](delegation.md), with no inherited conversation, root deliberations, prior reports, or verdicts.
3. Keep the candidate unchanged until every required contract returns. Replace or serialize an unavailable verifier; block if required coverage cannot be completed.
4. After all required contracts return, inspect the diff, relevant files, and bound requirement sources once before acceptance. Resolve unexpected changes and
   revalidate affected evidence under [Correct And Revalidate](#correct-and-revalidate). An uncontrolled writer or unexplained drift prevents reliance on the review batch
   until its provenance is reestablished. Otherwise aggregate findings and classify them before authorizing one coherent correction wave.

Verifiers inspect behavior, consumers, failure paths, and evidence within their contracts. They may investigate suspected drift and report it; root owns the final binding
decision. Do not require redundant validation merely for independence.

Reject only for evidenced failure of an applicable requirement or in-scope guarantee. A preferred design is not a defect. Missing new tests alone is not rejection
evidence; an indispensable missing check must identify the obligation it cannot establish and why existing checks or another concrete method are insufficient.

Missing evidence that prevents a verdict without establishing a material violation yields `BLOCKED`, not `REJECT`. A required `BLOCKED` review leaves acceptance pending
until the missing condition is resolved and the review completes.

## Correct And Revalidate

Classify findings as planning, execution, integration, or newly discovered risk; a finding may expose more than one. Before authorizing the correction wave, root checks
the violated guarantee across affected callers, equivalent states, and adjacent transitions, then defines a coherent correction boundary and updates deficient contracts.
Apply the [scope rules](planning.md#scope-and-changes); new specialist review still requires the consequence-based selection gate.

Before corrections, reopen affected accepted phases and return the correcting phase to `In Progress`. Review-only evidence work stays `In Review`. Root specifies the
correction boundary and selects its executor under [delegation](delegation.md#select-the-executor), preserving the ownership-transfer rules when the writer changes.

Reopening a phase does not require repeating its entire review portfolio. Rerun rejecting contracts and contracts whose surfaces or guarantees may be affected;
carry forward unaffected evidence with a brief delta-based justification. Judge impact by affected guarantees, not diff size; never present an old verdict as a review
of subsequent changes.

Keep each selected verifier on the same review assignment throughout the phase, including scope updates, corrections, reopening, and closure. Reassess the review
configuration under [delegation](delegation.md#mandatory-model-routing) when discoveries materially change reasoning difficulty, uncertainty, coupled guarantees, or
required verification depth. Preserve the assigned reviewer when its configuration remains suitable; replace it only if unavailable, incompatible with the required
role/configuration, or no longer independent. Replacements follow the same independence rules as new review assignments. A rejection alone does not justify changing
the model or effort, and a configuration change does not reduce required review coverage.

Continue while the next correction has scope, authority, and checkable evidence. If a guarantee fails again after a correction attempt, findings recur across its callers
or states, or validation repeatedly fails before exercising the target behavior, pause dependent correction work. Before another attempt, briefly record in the existing
ledger the invalid assumption or missing rule, the corrected rule or evidence strategy, and affected equivalent paths. Revise deficient contracts or assignments;
update the design under [planning](planning.md#specification-and-design) only when a shared decision changes. Repeated rejection alone justifies neither more compute nor abandonment.

## Final Assurance

After implementation phases close, root checks cumulative coverage and interactions. A planned final integration phase performs this work within its own `In Review`
state; it need not already be accepted. When valid cumulative evidence establishes the final obligations, root confirms coverage without creating another phase or
launching another reviewer. Reuse completed final assurance while its candidate binding and coverage remain valid.

First address evidence gaps through reproducible checks within root's authority and the applicable verification mode. Missing evidence alone does not require another
reviewer; if a check cannot run, keep its obligation pending. These checks do not replace required independent review.

Require independent general review when final obligations still need substantive judgment, or an applicable contract requires independent review not yet satisfied by
valid evidence. Assess unresolved guarantees and cross-phase interactions under [Select Verification Before Writes](delegation.md#select-verification-before-writes).
High risk alone does not require repeating a review that already establishes those guarantees for the current candidate.
Add a specialist only for an outstanding in-scope guarantee meeting the existing specialist-selection rules, whether it concerns existing behavior, a change, or a new interaction.
Select final reviewers under the model-routing policy.

When independent final review is needed, use a dedicated final-assurance phase, or the planned final integration phase when it covers those obligations. Do not reopen
an implementation phase merely to host cumulative final review. Record the outstanding guarantees, why existing evidence is insufficient, and the acceptance evidence
in that phase's Outcome and Acceptance. Bind reviewer assignments to it in `In Review` before launch; follow the normal lifecycle to reach that state.

If final review finds defects in accepted implementation, reopen the affected implementation phases for correction and their required revalidation and checkpoint
commits. Mark the final review phase `Blocked`, recording `In Review` as its prior state, while it awaits those corrections. After the affected phases close again,
bind the corrected candidate and resume the same final review assignments in `In Review`, revalidating affected contracts and retaining valid unaffected evidence.
If a final integration phase owns the correction itself, use its normal `In Progress` correction cycle instead. Reviewer replacement remains subject to
[Correct And Revalidate](#correct-and-revalidate).

Review the complete deliverable for the recorded final obligations without repeating unrelated accepted investigations. Close the final review phase through the
normal lifecycle once its obligations pass; its accepted evidence satisfies final assurance without another review at run completion. Complete the goal only through
[lifecycle](lifecycle.md).
