---
name: grill-code
description: Interview mode for stress-testing a plan against the current codebase and explicitly referenced documentation before implementation. Use when the user asks to grill, challenge, or stress-test a technical plan, or explicitly invokes grill-code. Ask one decision at a time, create an isolated specification and glossary for every new session, never consult inactive SPEC or CONTEXT files from other sessions, and require explicit post-grilling approval before changing code. Do not enter interview mode when the request is only to explain, review, or edit this skill.
---

<session-contract>

This skill is an interview and documentation mode, not an implementation mode.

Do not implement production code, change application behavior, add tests, refactor files, or make implementation commits while using this skill unless the user explicitly gives permission after the grilling session.

If the user's request mixes grilling with implementation, start with the grilling session and stop before implementation. Ask for explicit confirmation again after presenting the completed specification.

Allowed actions before explicit implementation approval:
- inspect current code and tests
- read repository instructions and documentation explicitly referenced by the user, plan, or relevant current code
- ask one decision at a time
- recommend an answer for each decision
- create or update the current session's `docs/SPEC-{context-id}.md`
- create or update the current session's `docs/CONTEXT-{context-id}.md`
- create `docs/adr/` and write an ADR after the user confirms an architectural decision that meets the ADR criteria below
- report exactly what was registered before asking the next question

Forbidden actions before explicit implementation approval:
- reading, searching, summarizing, comparing, or citing another session's `SPEC-*` or `CONTEXT-*` contents
- editing source code
- editing tests
- creating feature files
- changing configuration
- running broad refactors
- making implementation commits

Documentation writes are part of this interview workflow. Creating or updating the active `SPEC`, active `CONTEXT`, and qualifying ADRs does not count as implementation. Briefly tell the user at the start that these session documents will be maintained.

</session-contract>

<workflow>

## 1. Establish the session

Treat the request as a new session unless the user explicitly asks to resume the same session and the active `SPEC` and `CONTEXT` paths are known from the conversation or supplied by the user.

For a new session:

1. Build `context-id` using the naming rules below.
2. Inspect filenames only to ensure that both `docs/SPEC-{context-id}.md` and `docs/CONTEXT-{context-id}.md` are unused. If either exists, add the next sequential suffix.
3. Create both files using [SPEC-FORMAT.md](./SPEC-FORMAT.md) and [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).
4. Treat them as the only active session files.

For an explicit resume, read only the identified active pair and verify before activation that:

- both files exist and their filenames contain the same exact `context-id`
- the `SPEC` links to that exact `CONTEXT`
- the `CONTEXT` links to that exact `SPEC`
- the `SPEC` status permits the requested continuation

If validation fails, do not search other session files for a replacement; report the mismatch and request the correct pair. Never infer a resume from a similar date, slug, topic, or filename.

Resume according to status:

- `grilling` or `paused` — set `grilling`, restore the checkpoint, summarize it, and continue with the recorded next decision
- `ready-for-implementation` — present the recorded handoff and request implementation approval; do not invent another decision unless the user changes scope
- `implementation-approved` — implement only when the current request explicitly asks to continue that approved specification
- `closed` — do not resume or modify it; start a new grilling session instead

## 2. Inspect current evidence

Inspect current code, tests, repository instructions, the user's plan, and documentation explicitly referenced by the user, plan, repository instructions, or relevant current code.

Exclude every inactive `docs/SPEC-*.md` and `docs/CONTEXT-*.md` file from directory-wide and content searches. If another document links to one, do not follow the link. Those inactive filenames may be inspected only for collision avoidance.

Distinguish these states:

- **Observed current state** — verified in current code, tests, or an allowed document
- **Proposed behavior** — stated by the plan but not yet confirmed
- **Confirmed behavior** — explicitly accepted or corrected by the user in this session

Code can establish current behavior; it cannot decide desired behavior. Record observations as evidence in the active `SPEC`, never as confirmed intent.

## 3. Grill one material decision at a time

Walk the design tree by dependency and risk. Ask exactly one atomic decision at a time and wait for feedback before continuing.

For each decision:

1. State the evidence or uncertainty that makes the decision necessary.
2. Present the material options and trade-offs.
3. Recommend an answer with its basis. If evidence is insufficient, recommend a decision process rather than inventing a domain answer.
4. Do not treat the recommendation as accepted until the user confirms or corrects it.

If a factual question can be answered from allowed evidence, investigate it instead of asking the user. If the fact affects desired behavior, still ask the user to resolve that desired behavior.

Allow the user to mark a decision as confirmed, deferred, out of scope, or blocked. Update the active `SPEC` immediately after every answer and before asking the next question.

When a domain term or relationship is confirmed, update the active `CONTEXT` immediately. Confirmed relationship cardinalities may stay with that relationship. Keep lifecycle and behavioral invariants, responsibilities, behavioral rules, scope, and implementation decisions in the active `SPEC`, not in the glossary.

When a confirmed architectural decision meets the ADR criteria below, create the ADR before asking the next question and link it from the active `SPEC`. If it does not meet the criteria, keep the decision in the `SPEC`; an ADR is not needed.

After every documentation update, briefly report what was registered and in which file.

## 4. Converge and hand off

Cover only material uncertainties in the applicable areas:

- objective, scope, and non-goals
- domain language, boundaries, and ownership
- states, invariants, and lifecycle
- edge cases and failure behavior
- integrations and compatibility
- acceptance scenarios
- migration, rollout, observability, and validation

Finish the grilling session when every material item is confirmed or explicitly accepted as deferred or out of scope, and no unresolved blocker prevents implementation. Keep the status as `grilling` or `paused` when a blocker still prevents a viable implementation. Do not require certainty about irrelevant branches.

Before requesting implementation approval:

1. Update the `SPEC` status to `ready-for-implementation`.
2. Record the final objective, scope and non-goals, decisions, acceptance scenarios, ADRs, risks, deferred items, implementation sequence, and validation plan.
3. Present a concise handoff summary and links to the active `SPEC`, active `CONTEXT`, and ADRs created in this session.
4. Ask whether you may implement exactly that specification now.

Do not start implementation until the user explicitly confirms. After confirmation, update the `SPEC` status to `implementation-approved` before changing code. If the scope changes materially after approval, set the status back to `grilling`, invalidate the prior handoff approval in the `SPEC`, and return to grilling for the changed decision. Set the status to `closed` after the approved implementation and validation are complete.

</workflow>

<supporting-info>

## Session isolation

Every new grilling session is an independent specification. Prior `SPEC-*` and `CONTEXT-*` files may describe obsolete product behavior and are not sources for a new session.

For a new session, never open, search, summarize, compare, cite, reconcile, or derive information from prior session files. This prohibition applies even when they look relevant or another document links to them.

The active `CONTEXT` is authoritative only inside its own session. Multiple session contexts may overlap or contradict one another by design.

The only exception is an explicit resume of the exact same session. In that case, its `SPEC` and `CONTEXT` remain the active session files; all others stay excluded.

## File structure and naming

Build `context-id` as `YYYY-MM-DD-{short-task-slug}` using local time when known, otherwise UTC. The slug must contain three to six meaningful lowercase kebab-case words and be no longer than 40 characters.

Choose one suffix for the pair. If either target path already exists, try `-2`, then `-3`, continuing until both paths are unused. Do not include a time component or random suffix. Inspect only candidate `SPEC` and `CONTEXT` filenames for this check; do not read existing session files.

Each session owns one specification and one glossary:

```text
/
├── docs/
│   ├── SPEC-2026-06-17-order-cancellation-rules.md
│   ├── CONTEXT-2026-06-17-order-cancellation-rules.md
│   └── adr/
│       └── 0001-event-sourced-orders.md
└── src/
```

## Challenge the active glossary

When the user uses a term that conflicts with the active `CONTEXT`, call it out immediately: "This session defines 'cancellation' as X, but you now seem to mean Y — which is it?"

When the user uses vague or overloaded language, propose a precise session-local term. Use concrete scenarios to probe edge cases and clarify relationships.

Cross-reference claims with current code. If current behavior conflicts with desired behavior, surface the difference without treating the current implementation as authoritative intent.

Keep the active `CONTEXT` free of implementation details, lifecycle or behavioral invariants, responsibilities, and behavioral decisions. Confirmed relationship cardinalities are allowed. It is a session-local glossary and relationship map only. Use [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

## Offer ADRs sparingly

Only create an ADR when all three are true:

1. **Hard to reverse** — the cost of changing the decision later is meaningful
2. **Surprising without context** — a future reader will need the rationale
3. **The result of a real trade-off** — genuine alternatives existed and one was chosen for specific reasons

If any condition is missing, keep the confirmed decision in the active `SPEC`. Use [ADR-FORMAT.md](./ADR-FORMAT.md).

</supporting-info>
