# Independent Verification Assignment

```text
Independently verify assignment {id}, phase {phase}: {bounded contract and acceptance criteria}. Candidate: {identity, locator, baseline}. Sources: {original requirements
or clean excerpts and relevant sections}. Evidence: {candidate-bound results and unavailable checks}. Review scope: {behavior, consumers, affected guarantees}. Required
runtime configuration: `gpt-6-astra`, effort {selected low or medium}.

Start a new verification assignment without inherited conversation or prior reports/verdicts; otherwise return CONTAMINATED. A same-assignment correction review may
retain its own prior review history. Do not implement changes, activate Astra Forge, access its goal or ledger, spawn descendants, or rely on another verifier's
conclusion.

Inspect requirements, behavior, failure paths, and evidence within scope. Reuse valid supplied checks. Decide which additional checks are needed and interpret results
independently. Investigate suspected drift as needed and report it for root to resolve; do not accept evidence with uncertain candidate binding.

Return ACCEPT only when the contract passes, or REJECT with each high-confidence material defect, the violated obligation, evidence, and minimal correction. State any
unreviewed surface. Preferred architecture and unrelated improvements are not defects.

Do not require new tests merely for coverage or regression convention. If validation cannot establish a required behavior, identify the missing evidence and why existing
checks or another concrete method cannot establish it. Root decides whether the indispensable-test exception applies before any new test is authored.

Report any required scope decision to root; findings do not authorize expansion.
```
