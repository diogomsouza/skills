---
name: thermo-nuclear-code-quality-review
description: Perform an evidence-based, read-only maintainability audit of a branch, pull request, commit, diff, or selected files. Use only when the user explicitly invokes $thermo-nuclear-code-quality-review or asks for a thermonuclear, especially strict, or deep code-quality review. Do not use for routine reviews, implementation, or style-only feedback.
---

# Thermo-Nuclear Code Quality Review

Perform a demanding maintainability review without editing the code. Be strict about material structural regressions and equally strict about evidence, scope, and false positives.

## Review Contract

- Review only. Do not edit, format, stage, commit, or rewrite files.
- Use the exact scope supplied by the user.
- If no scope is supplied, review the current branch against the merge base of its default or upstream base branch. If no meaningful branch diff exists, review all staged, unstaged, and untracked changes.
- State the exact scope before presenting findings.
- Read applicable AGENTS.md, CONTRIBUTING.md, architecture guidance, and the most specific nested repository instructions.
- Report only problems introduced or materially worsened by the reviewed changes.
- Inspect complete changed files, relevant callers, consumers, tests, and canonical helpers before judging the diff.
- Run only non-mutating validation that materially improves confidence.

## Quality Standard

Working code is necessary but not sufficient. Look for concrete changes that make the system harder to understand, verify, extend, or operate.

Review these dimensions:

1. **Accidental complexity and branching**
   - Ad-hoc conditions inserted into shared or already busy flows.
   - Repeated feature checks, boolean combinations, sentinel values, or hidden states.
   - Duplicate paths that should use one canonical decision point.

2. **Ownership and boundaries**
   - Business or feature logic placed outside the layer that owns it.
   - Transport, persistence, rendering, or orchestration code absorbing domain rules.
   - Public or cross-module contracts weakened by loosely shaped data or leaking implementation details.

3. **Abstraction quality**
   - Thin wrappers, pass-through layers, generic machinery, or helpers that add concepts without reducing complexity.
   - Missing abstractions only when a concrete extraction would isolate a meaningful rule, remove duplication, or simplify testing.
   - Existing canonical helpers bypassed by a near-duplicate implementation.

4. **Types and invariants**
   - Optionality, casts, broad unions, nullable modes, or fallbacks that obscure a stronger invariant.
   - Invalid states made representable without a compatibility or framework requirement.
   - Validation repeated at consumers instead of established once at the correct boundary.

5. **Cohesion and growth**
   - A change that materially weakens file or module cohesion.
   - File growth that makes ownership, navigation, or testing meaningfully worse.
   - Compare before-and-after size and responsibilities; never block on a numeric line threshold alone.

6. **Orchestration and state changes**
   - Side effects interleaved with decision logic in ways that obscure failure behavior.
   - Related updates that can leave partial state.
   - Order-dependent or sequential flows whose invariants are unclear.
   - Recommend parallelism or atomicity only when independence or consistency requirements are proven.

7. **Verification and maintainability**
   - Missing tests for changed structural boundaries, state transitions, or behavior-preserving refactors.
   - Tests coupled to incidental implementation details.
   - Comments, naming, or formatting only when they violate an explicit project rule or materially hide behavior.

## Preserve Necessary Complexity

Do not assume simpler-looking code is better. Compatibility behavior, security checks, migrations, recovery paths, lifecycle state, platform differences, performance constraints, and public contracts may require explicit complexity.

Before recommending deletion or consolidation:

- identify the invariant or responsibility being protected;
- trace the affected execution path;
- prove the complexity is duplicated, accidental, unreachable, or misplaced; and
- explain how the proposed structure preserves behavior and compatibility.

If the evidence is insufficient, continue investigating or omit the finding. Do not turn uncertainty into a redesign request.

## Code-Judo Standard

Actively look for structural reframings that remove meaningful incidental complexity. Report a missed simplification only when you can identify:

- the current concepts, branches, or layers that are unnecessary;
- the specific owner, model, or control-flow change that replaces them;
- the invariant preserved by the alternative;
- the code or responsibilities that can be deleted; and
- why the result is materially easier to maintain.

Do not report vague suggestions such as "consider refactoring", speculative rewrites, or personal design preferences.

## Reporting Gate

A finding is reportable only when all conditions hold:

1. It is introduced or materially worsened by the reviewed scope.
2. It has concrete maintainability, architecture, operability, or verification impact.
3. The location and causal explanation are identifiable.
4. The remediation is actionable and proportionate.
5. Confidence is at least 80 out of 100.

Assign severity independently from confidence:

- **Blocker**: a structural regression with concrete near-term correctness, data, operability, or change-safety risk that must be fixed before merge.
- **Important**: a material maintainability or architecture regression that should be addressed before merge.

File length, unfamiliar structure, a cast, a wrapper, or additional branching is never a blocker by itself. Explain the actual impact.

## Output

Write in the user's language.

### Review scope

- Exact diff, branch range, commit, pull request, or files reviewed.
- Repository guidance consulted.
- Relevant validation inspected or run.

### Decision

Use exactly one:

- **REQUEST CHANGES** when at least one finding passes the reporting gate.
- **APPROVE** when no finding passes the reporting gate.

### Findings

Order findings by severity and then confidence. Use this shape:

**[Severity | confidence NN] Concise title**

- **Location:** path and exact line or narrow range.
- **Evidence:** changed code, surrounding contract, and causal explanation.
- **Impact:** concrete cost or failure mode.
- **Fix:** focused remediation that preserves behavior.
- **Code-judo:** include only when a proven reframing removes meaningful complexity.

If no finding qualifies, state that no high-confidence material maintainability regression was found. Do not append low-confidence nits.

## Final Check

Before returning:

- confirm the scope is exact;
- confirm every finding is change-related and confidence is at least 80;
- confirm complete files and relevant contracts were inspected;
- confirm necessary domain complexity was not mistaken for accidental complexity;
- confirm every requested change is actionable and proportionate; and
- confirm no file was modified during the review.
