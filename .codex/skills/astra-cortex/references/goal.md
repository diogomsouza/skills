# Runtime goal

Inspect the live goal contract and current goal. Reuse a matching unfinished goal; resolve a conflicting one with the user. Create only under applicable
user/system/developer authorization. Treat a UI or explicit skill invocation as goal-creation authority only when the actual request or live tool contract grants it; do
not assume every invocation does. Retain authority already granted without asking again. Set a token budget only when explicitly requested, and do not overwrite an
existing budget or runtime defaults merely to use this skill.

If authority or the tool is unavailable, explain the concrete obstacle and continue only independently authorized work outside this workflow. A progress file cannot
substitute for the runtime goal. Preserve its actual identity/objective and creation or reuse evidence. Use only goal operations exposed by the live environment; do not
invent tool names, receipts or state transitions. After an uncertain tool response, inspect the current state before retrying.

Complete only after the ledger.md readiness checks pass. A phase may be Blocked immediately; mark the runtime goal blocked only under its tool contract, including any
recurrence threshold. Do not infer user pause, budget or resume changes. If completion fails, leave the run open. If completion succeeds but the progress update fails,
verify the completed goal and final content, then retry only the progress update.
