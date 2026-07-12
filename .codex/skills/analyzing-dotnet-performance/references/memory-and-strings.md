# Memory and String Review

Optimize allocations only when they are frequent or large enough to affect the measured workload. Prefer simple managed code until evidence justifies lifetime-sensitive APIs.

## Establish the allocation source

Use existing allocation profiles, BenchmarkDotNet memory diagnostics, GC counters, dumps, or a reproducible loop. Identify allocation type, size, frequency, lifetime, and call path.

## Candidate patterns

### String slicing

Substring, Split, Trim, Replace, case conversion, and chained formatting allocate strings. Span-based alternatives help only when downstream APIs accept spans and the data does not need to outlive the source.

Do not introduce spans across async boundaries or store them in heap objects.

### Repeated concatenation

String concatenation in a loop can produce repeated copying. Confirm iteration counts and output sizes. Prefer StringBuilder, string.Create, or direct streaming when they make the code clearer and measurements support the change.

### Comparison and normalization

Choose StringComparison for semantic correctness first. Ordinal comparison often fits identifiers and protocol values; linguistic text may require culture-aware behavior. Do not change semantics for speed.

### Formatting

TryFormat, interpolated-string handlers, and writing into spans can remove temporary strings when the destination already supports buffers or spans. Avoid stack buffers and manual sizing for cold formatting code.

### stackalloc

Use only for small, bounded, synchronous temporary buffers. Review loop placement, recursion, input-controlled sizes, and total stack use. Prefer heap allocation when size is large or uncertain.

### ArrayPool and MemoryPool

Consider pooling for repeated medium or large temporary buffers with measurable GC pressure. Require clear ownership, try/finally return, logical-length handling, and sensitive-data policy. Do not pool tiny or long-lived buffers by default.

### UTF-8 literals and static data

UTF-8 literals and static immutable data can avoid repeated transcoding or construction. Recommend them only when the same data is recreated in a confirmed recurring path.

### params and temporary arrays

Overloads or params ReadOnlySpan may help heavily used APIs on supported language and runtime versions. Weigh API complexity and compatibility against one small allocation.

## Candidate searches

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' '\.Substring\(|\.Split\(|\.Replace\(|\.ToLower\(\)|\.ToUpper\(\)|stackalloc|ArrayPool|MemoryPool|params |\+=' .

Inspect types, loops, lifetimes, and target framework before reporting.
