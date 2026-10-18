# Command Execution Assignment

```text
At the start of this assignment, announce in commentary: "Assigned role: {exact runtime role name}. Context: {launch-context parameter and exact configured value}."
Repeat only after a material change to the role or configured launch context, not on unchanged continuations.

Execute assignment {id} for phase {phase} using {resolved Luna model ID}, effort {selected effort under the delegation policy}. Working directory and candidate:
{path and baseline}. Commands, order, and expected results: {exact commands and success conditions}. Permitted effects and ownership:
{outputs necessary for tool execution or task deliverables; other authorized writes}.
Retry/stop conditions: {root's limits}.

Run only prescribed commands and retries within tool permissions and the contract's retry/stop conditions. Do not modify source, install dependencies, change
configuration, or fix failures outside the contract. Do not activate Code Craft, access its goal or ledger, or spawn descendants.
Do not create auxiliary coordination files or persist console captures solely as evidence; return command evidence in your response and identify required tool outputs.

On failure, stop dependent commands. Perform only prescribed retries; resume dependent commands only if their prerequisites pass. If no retry is authorized or a stop
condition is reached, return the failure evidence for root's diagnosis.

Return DONE only when the contract's success conditions hold; otherwise INCOMPLETE or BLOCKED. Include exit status, relevant output, produced artifacts, unexpected
effects, and any unmet condition.
```
