# Specification and phases

## Establish the source

- **User-supplied file:** read and reference that exact specification; do not create a copy.
- **Approved plan in the conversation:** save it in `docs/PLAN-SPECS-{context-id}.md`, preserving its decisions and scope rather than redesigning it.
- **Request without a file or plan:** resolve its meaning from the conversation and relevant project evidence, then create an implementation-ready specification at that
  path. Preserve the original request and state the intended behavior, boundaries and acceptance criteria.

An implementation request authorizes in-scope planning and execution subject to applicable instructions; saving a specification does not create an additional
user-approval gate. Record reasonable assumptions without presenting unresolved material scope choices as approved. Ask only for material product or scope decisions that
cannot be reasonably inferred, and continue unaffected authorized work while they remain unresolved. Record the source once in Objective, including its origin. Keep
approved scope stable; later user amendments need a dated source and a clear disposition of superseded requirements.

## P0 investigation

For a new run, make P0 the only active phase; this does not limit the number of discovery or planning assignments. Read the specification, project instructions, relevant
implementation, consumers, tests, working/staged changes and external dependencies. P0 may write the progress file and required specification, but no production
implementation.

Use that evidence to define independently acceptable phases, observable completion criteria, requirement coverage and earliest dependencies. If code investigation reveals
a conflict with the specification, resolve it before affected implementation; do not silently change scope. Review P0 for complete coverage, feasible validation and
coherent dependencies before closing it. If P0 creates the specification, checkpoint its exact delta under acceptance.md.

## Execution plan

Each requirement has a primary phase. Each phase has an outcome, source coverage, dependencies, acceptance criteria and an isolated checkpoint plan. Mark required versus
optional validation explicitly. Keep dependencies acyclic; every implementation phase depends directly or transitively on Accepted P0. Future phases are Pending and
Unassigned. Group inseparable invariants together; do not make one phase per file or agent.

Refine phase decomposition as evidence changes without expanding approved scope. Record newly discovered required work in an existing or new phase before executing it,
including its coverage, dependencies and validation. Review material planning changes and reopen affected acceptance when its supporting assumptions or evidence no longer
hold.

Identify useful parallelism between phases and within a phase, and record dependencies or shared-write constraints that require sequencing. The executing model decides
whether and how to use that parallelism; do not create artificial assignments to fill capacity. Protect unrelated work and existing staging. Account for shared files,
generated outputs, external state and the Git index when choosing isolation or sequencing. If phase deltas cannot be isolated, revise decomposition or sequencing before
implementation. Choose the execution mechanism; phase boundaries do not require one agent, branch or worktree per phase. Smaller sequential assignments may stay inside
one phase; completing one assignment does not complete that phase. Tests, documentation and packaging belong with the behavior they support.

For each implementation step, the responsible executor needs the relevant requirements, decisions, scope, preserved behavior and evidence obligations. The model decides
how to provide that context; this skill does not prescribe agent access or prompt construction. Review suggestions cannot expand scope. Tests follow user/project
requirements and proportional verification; do not weaken them to obtain acceptance. Once appropriate checks pass, broaden or repeat them only when changes, failures,
unresolved concerns or applicable requirements justify it.
