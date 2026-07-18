# `docs/CONTEXT-{context-id}.md` Format

This file is the session-local glossary and relationship map for one grilling specification. It is not canonical across sessions. It may record confirmed relationship cardinalities and dialogue that clarifies vocabulary, but it must not contain lifecycle rules, eligibility rules, processing behavior, responsibilities, or implementation decisions.

## Incremental structure

Create the file when a new session starts with only the title, description, and link to its paired `SPEC`. Add the remaining sections only when confirmed content exists; never invent content or add empty placeholders to complete the template.

```md
# Order Cancellation Context

Session-local language for the order cancellation specification.

Specification: [SPEC-2026-06-17-order-cancellation-rules.md](./SPEC-2026-06-17-order-cancellation-rules.md)

## Language

**Order**:
A customer request for one or more products.
_Avoid in domain language_: Purchase, transaction

**Customer**:
A person or organization that places orders.
_Avoid in domain language_: Client, buyer, account

**Partial Cancellation**:
A cancellation that targets fewer than all items in an **Order**.

## Relationships

- An **Order** belongs to exactly one **Customer**
- A **Partial Cancellation** applies to exactly one **Order**

## Example dialogue

> **Dev:** "What do we call a cancellation that affects only one item in an **Order**?"
> **Domain expert:** "Use **Partial Cancellation** when fewer than all items in the **Order** are affected."

## Flagged ambiguities

- "account" was used for both **Customer** and **User** — resolved: they are distinct concepts in this specification.
```

## Rules

- Include only terms and relationships confirmed in the active grilling session.
- Define what a term is, not what it does, in one concise sentence.
- Choose one preferred term and list misleading alternatives under `_Avoid in domain language_` when useful.
- Record a relationship only when its meaning and any stated cardinality are confirmed.
- Include only domain-specific concepts, not general programming concepts.
- Group terms under subheadings only when natural clusters emerge.
- Add an example dialogue only after enough related terms are confirmed. Use it to clarify vocabulary and relationships, not to introduce workflow or eligibility rules.
- Record resolved language conflicts under `Flagged ambiguities`.
- Put lifecycle invariants, responsibilities, workflows, eligibility, processing behavior, scope, and implementation decisions in the paired `SPEC`, never here.

## Isolation and location

Each new grilling session creates a fresh `docs/CONTEXT-{context-id}.md` paired with `docs/SPEC-{context-id}.md`.

Do not read or reuse another session's context when starting a new session. Inspect existing context filenames only to select a unique pair of paths. Reopen a context only when explicitly resuming that exact session.

Use the naming and collision rules in [SKILL.md](./SKILL.md).
