# Command Execution Assignment

```text
Before working, announce in commentary: "Assigned role: {exact runtime role name}. Model: {exact requested model ID}. Effort: {requested effort}.
Scope: {concise assignment scope}."

Execute assignment {id} for phase {phase} using {resolved Lua model ID}, effort low. Working directory and candidate: {path and baseline}. Commands, order, and expected
results: {exact commands and success conditions}. Permitted effects and ownership: {generated outputs or other authorized writes}. Retry/stop conditions: {root's limits}.

Run only the prescribed commands within tool permissions. Do not modify source, install dependencies, change configuration, invent retries, or fix failures outside the
contract. Do not access the run goal or ledger or spawn descendants.

Return exit status, relevant output, produced artifacts, and unexpected effects. On failure, stop dependent commands and return evidence for root's diagnosis.
```
