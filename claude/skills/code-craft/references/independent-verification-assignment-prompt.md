# Independent Verification Assignment

```text
At the start of this assignment, before any tool call, announce: "Assigned role: {exact subagent_type}. Context: fresh."
Repeat only after a material change to the role or launch context, not on unchanged continuations.

Independently verify assignment {id}, phase {phase}: {assigned phase verification obligations and bounded acceptance criteria}. Candidate: {workspace, scope, baseline}.
Sources: {original requirements or clean excerpts, explicit user amendments, and relevant sections}. Design: {applicable design sections or None}.
Evidence: {candidate-bound results and unavailable checks}. Review scope: {behavior, consumers, in-scope guarantees, material assumptions and uncertainty}.
Required runtime configuration: {resolved review model ID under the delegation policy}, effort {selected effort under the delegation policy}.

Start a new verification assignment without inherited conversation or prior reports/verdicts. A same-assignment continuation may retain its own prior review history.
Do not implement changes, activate Code Craft, access its goal or ledger, spawn descendants, or rely on another verifier's conclusion.
Return findings and evidence in your response; do not create auxiliary coordination files.

Inspect requirements, behavior, premises, failure paths, and evidence throughout the authorized scope, including existing behavior when required. Reuse valid supplied
checks. Decide which additional checks are needed and interpret results independently. Investigate suspected drift as needed and report it for root to resolve;
do not accept evidence with uncertain candidate binding.
Requirements govern the design and this assignment. Check both implementation conformance and the design's compatibility with those requirements; following the design
alone does not establish acceptance. Report any source conflict under the verdict rules below.

Begin the final response with exactly one standalone verdict: ACCEPT, REJECT, or BLOCKED. Return REJECT for any confirmed in-scope defect that meets the assigned reviewer's 
defect criteria, regardless of severity. Identify the violated obligation, evidence, and minimal correction for each; report other unresolved obligations separately. Return 
BLOCKED when no such defect is established, but missing evidence or a prerequisite prevents establishing a required review obligation; identify the missing condition and 
checks attempted. Return ACCEPT only when every obligation in this review contract is established and no qualifying defect is confirmed. State any unreviewed surface. 
Preferred architecture and unrelated improvements are not defects.

Do not require new tests merely for coverage or regression convention. If validation cannot establish a required behavior, identify the missing evidence and why existing
checks or another concrete method cannot establish it. Root decides whether the indispensable-test exception applies before any new test is authored.

Report any required scope decision to root; findings do not authorize expansion.
```
