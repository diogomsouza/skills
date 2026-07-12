# Regex Performance Review

Choose regex construction and engine mode from pattern features, input trust, call frequency, startup constraints, and target framework. No mode is universally fastest.

## Candidate patterns

### Repeated construction

new Regex inside a recurring method can repeatedly parse or compile a pattern. Confirm frequency and whether the pattern is static, dynamic, cached elsewhere, or intentionally short-lived.

### GeneratedRegex

GeneratedRegex can improve startup, trimming, AOT compatibility, and repeated static-pattern use. Recommend it only for compile-time patterns on supported targets and after considering generated code, partial-type requirements, and project conventions.

### Compiled regex

RegexOptions.Compiled trades startup and code-generation cost for potential steady-state throughput. Evaluate the number of patterns, instance lifetime, deployment mode, and actual match volume. Do not replace it mechanically.

### Non-backtracking engine

RegexOptions.NonBacktracking provides predictable execution but does not support every regex feature and can change capture behavior. Verify pattern compatibility and tests before recommending it.

### Timeouts and untrusted input

For backtracking regex applied to attacker-controlled or large input, inspect timeout configuration and worst-case behavior. A concrete catastrophic-backtracking or denial-of-service path is a critical finding.

### Result shape

Use IsMatch when only a boolean is needed. Count or EnumerateMatches may avoid Match object creation when captures and Match APIs are unnecessary. Confirm the target framework and that the alternative preserves semantics.

### Span-based input

Span-oriented regex APIs can avoid substring allocation in synchronous parsing code. Confirm the source lifetime and API availability; spans cannot cross async boundaries or be stored on the heap.

## Candidate searches

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' 'new Regex\(|GeneratedRegex|RegexOptions\.Compiled|RegexOptions\.NonBacktracking|Regex\.Match|\.Matches\(|\.Success' .

Inspect pattern ownership, input boundary, captures, timeout, and call frequency before reporting.
