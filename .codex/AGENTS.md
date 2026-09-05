# Global Coding Guidelines

These are default behavioral guidelines. Apply judgment:
for trivial, low-risk, and reversible tasks, proceed directly without
unnecessary questions or ceremony. Project-specific instructions take
precedence when they conflict with these defaults.

## 1. Think Before Coding

Before implementing a non-trivial change:
- Identify assumptions that materially affect the solution.
- If an ambiguity could lead to a substantially different implementation,
  ask or state the interpretation being used.
- Mention meaningful tradeoffs when multiple approaches are viable.
- Prefer the simplest approach that satisfies the request.

Do not interrupt straightforward tasks with unnecessary clarification.

## 2. Simplicity First

Implement the smallest clear solution that satisfies the requirement.
- Do not add features, configuration options, or extensibility that were
  not requested.
- Avoid speculative abstractions.
- Introduce abstractions when they improve clarity, testability, isolation
  of dependencies, or consistency with the existing architecture.
- Avoid unnecessary method fragmentation. Do not extract small blocks into 
  separate methods merely to make the main method shorter. Keep simple, 
  single-use steps inline when they are easy to understand in context, such 
  as loading a list, applying a straightforward filter, or assigning values. 
  Extract a method only when it improves readability, isolates a meaningful rule, 
  reduces duplication, or makes the code easier to test.
- Add error handling for realistic failure modes, not hypothetical ones.
- If the solution is significantly more complex than necessary, simplify it.

## 3. Surgical Changes

Keep diffs focused.
- Change only files and lines directly related to the task.
- Do not refactor adjacent code, reformat unrelated files, rename unrelated
  symbols, or remove existing comments without a task-related reason.
- Match the existing style and architecture unless explicitly asked to
  improve them.
- Remove imports, variables, and methods made obsolete by your own changes.
- Mention unrelated issues separately instead of fixing them silently.
- If an adjacent refactor is necessary for correctness, explain why.

## 4. Goal-Driven Execution

Define what success means and verify it.
- For bugs, reproduce the issue when practical, then confirm the fix.
- Run the smallest relevant validation first, then broader checks when
  justified.
- For tasks where automated tests are not appropriate, use another concrete
  verification method such as build, lint, query validation, migration
  review, or manual reproduction steps.
- Report what was verified and any checks that could not be executed.

For multi-step or high-risk tasks, state a brief implementation plan before
making changes.