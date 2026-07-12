---
name: analyzing-dotnet-performance
description: Analyze C# and .NET performance using workload context, profiling or benchmark evidence, and targeted static inspection. Use for slow or allocation-heavy code, hot paths, async or thread-pool issues, regex, collections, serialization, I/O bottlenecks, or a requested .NET performance audit. Do not use for speculative optimization of cold code or database-only problems.
---

# Analyze .NET Performance

Find performance problems that matter in the actual workload. Treat static searches as candidate discovery, not proof. Never invent speedups, allocation savings, or severity from pattern counts alone.

## Operating Boundary

- If the user asks only for analysis, do not edit files.
- If the user asks for fixes, change only high-confidence bottlenecks and validate correctness and performance.
- Read applicable AGENTS.md, project files, target frameworks, build configuration, benchmarks, tests, and existing diagnostics.
- Preserve behavior, thread safety, compatibility, cancellation, disposal, and security.
- Do not recommend framework upgrades, unsafe code, pooling, spans, ValueTask, source generation, or low-level collection APIs unless the workload and tradeoffs justify them.

## Workflow

### 1. Establish the performance question

Identify:

- the operation or user-visible symptom;
- the hot path, expected call frequency, concurrency, and data sizes;
- the target framework, runtime, platform, and deployment mode;
- the success metric, such as latency, throughput, allocations, startup, memory, or I/O; and
- existing traces, counters, benchmarks, logs, dumps, or production evidence.

Inspect the repository before asking for facts that can be discovered locally. If workload context or measurements are missing, continue with a static candidate audit but label it clearly as unmeasured.

### 2. Prefer evidence already available

Use existing BenchmarkDotNet projects, profiler captures, dotnet-counters output, dotnet-trace data, application metrics, load tests, or reproducible timings before proposing changes.

When measurement is practical and authorized:

- measure the smallest representative scenario;
- use release or production-like configuration;
- warm up when the runtime or benchmark requires it;
- compare the same workload and environment before and after; and
- report variance and measurement limits.

Do not install new profilers or benchmark packages unless the user asks or the project already expects them.

### 3. Inspect the relevant code path

Read complete methods and follow callers, callees, allocation boundaries, async flow, collection sizes, serialization, and I/O behavior. Search narrowly with rg and exclude generated output such as bin and obj.

Example candidate search:

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' '\.Result|\.Wait\(|async void|new Regex\(|new HttpClient\(|new JsonSerializerOptions' .

Use an equivalent search tool only when rg is unavailable. A textual hit is never a finding until type, lifetime, frequency, and execution context are confirmed.

### 4. Load only relevant references

Always read [critical-patterns.md](references/critical-patterns.md) for stability and pathological-cost candidates.

Then load only the categories signaled by the code or workload:

- Async, Task, ValueTask, locks, or concurrency: [async-patterns.md](references/async-patterns.md)
- Strings, buffers, spans, formatting, or allocation pressure: [memory-and-strings.md](references/memory-and-strings.md)
- Collections, dictionaries, LINQ, or repeated enumeration: [collections-and-linq.md](references/collections-and-linq.md)
- Regex construction, matching, or untrusted patterns: [regex-patterns.md](references/regex-patterns.md)
- HTTP, files, streams, JSON, or serialization: [io-and-serialization.md](references/io-and-serialization.md)
- Devirtualization, sealing, structs, or dispatch: [structural-patterns.md](references/structural-patterns.md)

Do not load every reference for a narrow review.

### 5. Confirm each candidate

Before reporting, answer:

1. Does the code execute in the relevant workload?
2. Is it frequent, concurrent, allocation-heavy, blocking, or operating on large data?
3. Does the target framework already optimize this case?
4. Does the proposed alternative preserve semantics and lifecycle?
5. Is the expected impact measured, supported by direct evidence, or still hypothetical?
6. Does the change add complexity, pooling obligations, lifetime risk, or version constraints?

Reject candidates that are cold, one-time, generated, test-only, already optimized, semantically different, or unsupported by the target framework.

### 6. Prioritize honestly

Classify by evidence and impact:

- **Critical**: concrete deadlock, starvation, unbounded resource growth, denial-of-service path, or pathological cost with an identifiable trigger.
- **High**: measured bottleneck or strongly evidenced dominant cost in a confirmed hot path.
- **Moderate**: confirmed recurring cost with a proportionate, low-risk fix.
- **Measurement candidate**: plausible optimization that still needs profiling or a benchmark. Keep these separate from findings.

Do not escalate because the same syntax appears many times. Scale matters only when those sites participate in the measured workload.

## Output

Write in the user's language.

### Scope and evidence

- Files and workload reviewed.
- Target framework and relevant runtime assumptions.
- Measurements, traces, benchmarks, or static-only limitations.

### Findings

Group findings by severity. For each finding include:

- **Location:** path and exact line or narrow range.
- **Evidence:** call path, frequency, measurement, allocation source, blocking behavior, or resource lifetime.
- **Impact:** metric affected without unsupported numeric claims.
- **Fix:** smallest behavior-preserving change.
- **Tradeoff:** complexity, compatibility, pooling, lifetime, or correctness cost.
- **Validation:** exact benchmark, trace, counter, test, or scenario that proves the change.

### Measurement candidates

List unmeasured candidates separately with the evidence needed to promote or reject them. Do not present them as defects.

If no material issue is supported, say so and identify the next measurement that would reduce uncertainty.

## Fix Validation

When implementing an optimization:

1. Run the smallest relevant correctness tests.
2. Build the affected project in the configuration relevant to the workload.
3. Re-run the same measurement before and after.
4. Confirm the result is not measurement noise.
5. Check allocations, latency, throughput, memory, and concurrency behavior relevant to the change.
6. Revert or report the optimization as unproven when it does not produce a reliable benefit.

Never trade correctness or maintainability for an unmeasured micro-optimization.
