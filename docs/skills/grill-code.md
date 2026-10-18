# Grill Code

**Challenge a technical plan until its behavior, language, and implementation boundaries are clear.**

Grill Code is a modified version of [grill-with-docs](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs) by Matt Pocock, adapted for this repository's Codex workflow.

The skill turns a plan into a focused interview supported by the current codebase. It examines material decisions, exposes competing interpretations, and records confirmed answers while the conversation progresses. The result is a specification and a domain glossary that preserve the session's conclusions.

It is especially useful when a request sounds straightforward but hides choices about ownership, eligibility, concurrency, recovery, or domain language. Existing code supplies evidence about today's behavior; the user still decides what the planned behavior should be.

## Resolve one decision at a time

For each material decision, the skill states the evidence or uncertainty, explains viable options and tradeoffs, and recommends an answer with its basis. It then waits for the user's response.

For example, a plan to “cancel an order” may mean cancelling the entire order, only unfulfilled items, or work that has already been dispatched. Those meanings imply different responsibilities and failure behavior. The interview should resolve that distinction before specifying how cancellation is implemented.

Facts discoverable from the code are investigated directly. Recommendations do not become accepted decisions until the user confirms or corrects them. The user can also mark an item deferred, out of scope, or blocked; a blocker that prevents viable implementation keeps the session open.

## Keep behavior and vocabulary in the right documents

Every new session creates an isolated pair of files with the same context identifier.

| Artifact | What belongs there |
| --- | --- |
| `docs/SPEC-{context-id}.md` | Objective, scope, observed behavior, confirmed decisions, responsibilities, acceptance scenarios, risks, implementation handoff, and the next interview decision |
| `docs/CONTEXT-{context-id}.md` | Confirmed domain terms and relationships, including confirmed cardinalities |
| `docs/adr/` entries, when justified | Rationale for qualifying architectural decisions |

The specification and glossary link to each other. The glossary defines what a term means and how concepts relate. Lifecycle rules, eligibility, processing behavior, and implementation choices stay in the specification.

An ADR is created only when a confirmed decision is hard to reverse, would be surprising without context, and resulted from a real tradeoff. Other decisions remain in the specification. This keeps architectural records useful without creating one for every answer.

After each answer, the skill updates the relevant active documents before asking the next question and briefly reports what was recorded.

## Separate evidence from intent

The workflow distinguishes three kinds of information:

- **Observed current state:** behavior established by the current code, tests, or allowed documentation.
- **Proposed behavior:** a statement from the plan that the user has not yet confirmed in the session.
- **Confirmed behavior:** a decision explicitly accepted or corrected by the user.

This distinction prevents today's implementation from silently determining tomorrow's requirements. It also prevents a suggested answer from becoming a requirement simply because it appeared in the conversation.

When the user uses a term inconsistently with the active glossary, the skill calls out the conflict and resolves its meaning. The glossary is local to that session, so another session may deliberately define the same term differently.

## Start fresh or resume an identified session

A new session never reads, searches, compares, or derives conclusions from inactive `SPEC-*` or `CONTEXT-*` files. Their names can be inspected only to avoid filename collisions. A link from another document does not make an inactive session an allowed source.

Resumption requires an explicit request for the same session and the exact active paths. The pair must exist, share the same context identifier, and link to each other.

| Specification status | Resume behavior |
| --- | --- |
| `grilling` or `paused` | Restore the checkpoint, return to grilling, and continue the recorded decision |
| `ready-for-implementation` | Present the completed handoff and request implementation approval |
| `implementation-approved` | Continue implementation only when the current request explicitly asks for it |
| `closed` | Start a new grilling session |

An invalid pair is reported rather than replaced with another session that happens to look related.

## Hand off before changing code

The interview can inspect code and tests and maintain its active documents. It does not change source, configuration, or tests or make implementation commits before explicit post-interview approval.

Once all material items are confirmed or appropriately deferred and no blocker prevents implementation, the skill records the final scope, decisions, acceptance scenarios, risks, implementation sequence, and validation plan. It marks the specification ready and presents links to the active documents.

The user then approves implementation of that exact specification. This checkpoint still applies when the original request asked for both grilling and implementation. A material scope change after approval invalidates the earlier approval and returns the changed decision to grilling.

## Example requests

```text
Use $grill-code to challenge our partial-order cancellation plan.
Inspect the current cancellation code and the attached proposal before asking questions.
```

```text
Resume the grill-code session in docs/SPEC-2026-10-18-order-cancellation-rules.md
and its paired docs/CONTEXT-2026-10-18-order-cancellation-rules.md.
```

The second example illustrates explicit paths; replace them with an existing active pair. For a saved implementation specification without the dedicated grilling interview, see [Tech Spec](tech-spec.md). For explanatory system documentation, see [System Spec](system-spec.md).

## Source and related guides

- [Skill definition](../../codex/skills/grill-code/SKILL.md) — interview, isolation, approval, and resumption rules.
- [Specification format](../../codex/skills/grill-code/SPEC-FORMAT.md) — recorded decisions and resumable state.
- [Glossary format](../../codex/skills/grill-code/CONTEXT-FORMAT.md) — vocabulary and relationship boundaries.
- [ADR format](../../codex/skills/grill-code/ADR-FORMAT.md) — architecture-decision records.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->