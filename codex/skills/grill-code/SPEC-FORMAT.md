# `docs/SPEC-{context-id}.md` Format

This file is the resumable source of truth for one grilling session. It preserves confirmed behavior and the interview checkpoint without relying on the chat transcript.

## Initial structure

Create the file when a new session starts. Omit empty optional sections, but always keep `Status`, `Context`, `Objective`, `Session checkpoint`, and `Open decisions` current.

```md
# Order Cancellation Specification

Status: `grilling`
Context: [CONTEXT-2026-06-17-order-cancellation-rules.md](./CONTEXT-2026-06-17-order-cancellation-rules.md)

## Objective

Stress-test and define the proposed order cancellation behavior before implementation.

## Scope

### In scope

- Cancellation of unfulfilled order items

### Out of scope

- Refund settlement

## Sources inspected

- `PLAN.md` — plan explicitly referenced by the user.
- `DESIGN.md` — product constraint referenced by the plan.
- `src/orders/cancel.ts` — current implementation relevant to cancellation.

## Observed current state

- `src/orders/cancel.ts`: cancellation currently applies to an entire order.

## Confirmed decisions

- Partial cancellation targets one or more unfulfilled order items.
  - Rationale: fulfilled items can no longer be cancelled.
  - ADR: Not needed; this is product behavior rather than a hard-to-reverse architectural decision.

## Domain rules and responsibilities

- Ordering owns cancellation eligibility.

## Acceptance scenarios

- Given an order with one fulfilled and one unfulfilled item, when the customer cancels the unfulfilled item, then the fulfilled item remains unchanged.

## Open decisions

- Whether an item being fulfilled concurrently may still be cancelled.

## Deferred or blocked

- Refund timing — deferred to the payments specification.

## Session checkpoint

- Last resolved: Partial cancellation operates at item level.
- Next decision: Define concurrency behavior between fulfillment and cancellation.

## Implementation handoff

- Implementation sequence: ...
- Validation plan: ...
- Risks and accepted deferrals: ...
```

## Status values

- `grilling` — material decisions remain open
- `paused` — the user explicitly paused this session
- `ready-for-implementation` — all material items are confirmed or explicitly accepted as deferred or out of scope, and no unresolved blocker prevents implementation
- `implementation-approved` — the user explicitly approved implementation of this exact specification
- `closed` — the session no longer accepts changes without starting another grilling cycle

## Recording rules

- Treat plan statements as proposed until the user explicitly confirms them in this session.
- List every inspected content source under `Sources inspected`; never include inactive `SPEC` or `CONTEXT` files.
- Record code and test findings under `Observed current state`; never treat them as desired behavior by themselves.
- Record every confirmed decision, including reversible decisions that do not qualify for an ADR.
- Keep each decision atomic and include rationale when it prevents future ambiguity.
- Link a qualifying ADR from the corresponding decision. Otherwise state briefly why no ADR is needed only when that distinction is useful.
- Keep `Open decisions`, `Deferred or blocked`, and `Session checkpoint` current before asking the next question.
- Put confirmed terms and relationships in the paired `CONTEXT`; keep rules, responsibilities, scope, and behavior here.
- At handoff, make the specification self-contained enough to implement without reconstructing the chat transcript.

## Isolation and resumption

Each new grilling session creates a fresh `docs/SPEC-{context-id}.md`. Never inspect another session's `SPEC` or `CONTEXT` content to initialize it.

Resume this file only when the user explicitly resumes this exact session. Verify that the `SPEC` and `CONTEXT` filenames have the same `context-id` and link to each other before treating them as active.

On resume:

- For `grilling` or `paused`, set `grilling`, restore the checkpoint, summarize it, and continue with the recorded next decision.
- For `ready-for-implementation`, present the handoff and ask for implementation approval.
- For `implementation-approved`, continue implementation only when the current request explicitly asks for it.
- For `closed`, start a new grilling session instead of modifying this one.

After explicit implementation approval, persist `implementation-approved` before changing code. A material specification change invalidates that approval and returns the status to `grilling`. After implementation and validation finish, set `closed`.

Use the naming and collision rules in [SKILL.md](./SKILL.md).
