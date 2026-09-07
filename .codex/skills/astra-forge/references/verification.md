# Integration And Verification

## Bind Evidence To The Candidate

Root reconciles the cumulative diff, attributes changes, preserves unrelated work, and checks acceptance evidence. Route substantive review under [mandatory model
routing](delegation.md#mandatory-model-routing). Freeze a reproducible candidate identity before review, with writers quiescent or an immutable snapshot.

Prefer a project-provided identity covering the complete deliverable. Otherwise record the root, included units, exclusions, canonical ordering, relevant metadata, and
content digests. Account explicitly for links, submodules, and external content; never silently traverse or omit them. The deliverable fingerprint excludes live
coordination state; commit scope is defined in [lifecycle](lifecycle.md).

Every deliverable change produces a new identity. Keep evidence attached to the identity it actually validated. Uncertain writers or unexplained drift invalidate affected
evidence; root resolves the mismatch before acceptance.

## Review A Phase

Use the [lifecycle](lifecycle.md) to enter `In Review`. Confirm execution evidence and applicable cumulative validation. Reuse successful checks when candidate scope,
environment, and provenance remain valid. Repeat only for a change, failure, or unresolved concern; final assurance does not itself require rerunning an unchanged suite.

For independent modes:

1. End implementation ownership and bind the candidate, baseline, evidence, relevant source requirements, and bounded review contract.
2. Select fresh verifiers through [delegation](delegation.md), with no inherited conversation, root deliberations, prior reports, or verdicts.
3. Keep the candidate unchanged until every required contract returns. Replace or serialize an unavailable verifier; block if required coverage cannot be completed.
4. Recheck candidate identity, aggregate findings, and classify them before authorizing one coherent correction wave.

Verifiers inspect behavior, consumers, failure paths, and evidence within their contracts. They may investigate suspected drift and report it; root owns the final binding
decision. Do not require redundant hashing or validation merely for independence.

Reject only for evidenced failure of an applicable requirement or affected guarantee. A preferred design is not a defect. Missing new tests alone is not rejection
evidence; an indispensable missing check must identify the obligation it cannot establish and why existing checks or another concrete method are insufficient.

## Correct And Revalidate

Classify findings as planning, execution, integration, or newly discovered risk. Update deficient contracts before writes; new specialist review still requires the
consequence-based selection gate. Separate in-scope defects from broader remedies.

Before corrections, reopen affected accepted phases and return the correcting phase to `In Progress`. Review-only evidence work stays `In Review`. Root specifies the
correction and delegates it, unless the direct-root exception below applies.

Rerun rejecting contracts and contracts whose surfaces or guarantees may be affected. Carry forward unaffected evidence only with an explicit delta-based justification;
never relabel an old verdict as a review of the new identity.

Reuse a verifier only for correction closure of the same assignment. A materially changed boundary, different phase, contaminated context, or fresh final review requires
a new identity.

Continue while the next correction has scope, authority, and checkable evidence. Persistent findings, excessive rework, or reopened phases require revisiting the design,
contract, evidence, or executor before another attempt. Repeated rejection alone is not grounds for more compute or abandonment.

## Direct Root Correction

Root may directly apply a small, localized correction to an existing implementation when the defect and exact fix are understood and another assignment or correction
round would add avoidable delay.

Use this exception only within the approved approach and scope, without new design, behavior, or substantial refactoring. Size is determined by affected behavior and
validation needs, not a line-count threshold. Delegate if the fix requires further investigation, has broad effects, or grows beyond the identified correction.

Before writing, obtain the implementer's explicit release of the affected ownership or confirm it has stopped and cannot write there. Wait for any active verification
batch to finish. Record the correction boundary, root ownership, and time-saving rationale in the existing ledger; notify any continuing implementer of the handoff.

Apply the normal correction transitions, candidate identity update, validation, affected review contracts, and phase commit. Use the model-routing policy for command
execution and review. Return updated ownership and candidate facts before an agent resumes.

## Final Assurance

After implementation phases close, review cumulative coverage and interactions. A final integration phase, when planned, performs this work within its own `In Review`
state; it need not already be accepted.

Require fresh independent general review for a high-risk cumulative candidate or a material cross-phase interaction not settled by phase evidence. Add a specialist only
for a changed boundary, new interaction, incomplete prior evidence, or authoritative requirement. Otherwise root confirms coverage from valid cumulative evidence; any
additional substantive review follows the model-routing policy.

Review the complete deliverable for final obligations without repeating unrelated accepted investigations. Final corrections reopen affected phases and require new phase
checkpoint commits. Complete the goal only through [lifecycle](lifecycle.md).
