# Runtime goal

Every Astra Cortex run requires a real runtime goal. Before substantial discovery, delegation, progress-file creation or implementation, inspect the live goal contract
and current goal. Reuse an unfinished goal only when its objective matches the request; resolve a conflicting unfinished goal with the user. If no matching goal exists,
derive the outcome, scope, exclusions and completion evidence from the request and authoritative sources. Fill technical gaps through bounded read-only inspection and
resolve material product or scope decisions with the user, then create the goal. On resume, if the matching progress file exists without a goal, recreate the goal before
continuing. Set a token budget only when explicitly requested, and do not overwrite an existing budget or runtime defaults merely to use this skill.

If the tool is unavailable, creation fails or a higher-priority runtime rule prevents creation, report the concrete blocker and do not proceed with the managed workflow.
A progress file cannot substitute for the runtime goal. Preserve its actual identity/objective and creation or reuse evidence. Use only goal operations exposed by the live environment; do not
invent tool names, receipts or state transitions. After an uncertain tool response, inspect the current state before retrying.

Complete only after the ledger.md readiness checks pass. A phase may be Blocked immediately; mark the runtime goal blocked only under its tool contract, including any
recurrence threshold. Do not infer user pause, budget or resume changes. If completion fails, leave the run open. If completion succeeds but the progress update fails,
verify the completed goal and final content, then retry only the progress update.
