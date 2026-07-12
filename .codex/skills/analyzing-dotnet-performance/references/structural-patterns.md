# Structural Performance Review

Structural optimizations affect design and public contracts. Require stronger evidence than for a local allocation fix. Never infer severity from the number of classes or missing keywords.

## Sealing classes

Sealing a true leaf class can enable devirtualization and communicate design intent. Recommend it for performance only when:

- the class is not intended or required to be inherited;
- the relevant virtual or interface dispatch is in a measured hot path;
- the target runtime cannot already devirtualize the call adequately; and
- the API compatibility cost is acceptable.

Do not scan a codebase and report every unsealed class. Framework proxies, tests, plugins, serializers, ORMs, mocking, and public extension points may require inheritance.

## Readonly fields and concrete types

Readonly fields and stable concrete types can help optimization and reasoning, but runtime behavior depends on tiered compilation, PGO, call shape, and target runtime. Require disassembly, benchmark, or profiler evidence before proposing architecture changes for devirtualization.

## Struct equality and hashing

IEquatable, readonly struct, and custom hashing can matter in collection-heavy workloads. Confirm boxing, comparer selection, copy size, mutation semantics, and lookup frequency. Large structs or incorrect equality implementations can make performance and correctness worse.

## Interface and virtual dispatch

Virtual dispatch is rarely the dominant cost outside very tight loops. Measure the call site and inspect runtime-generated code when possible. Prefer design clarity unless dispatch is demonstrated as material.

## Data layout and false sharing

Padding, explicit layout, vectorization, and cache-aware partitioning are specialized optimizations. Require representative multi-core benchmarks or hardware-counter evidence and review portability and memory-growth tradeoffs.

## Static initialization

Static constructors, field initialization, and generic static state can affect startup and beforefieldinit behavior. Change them only when startup traces identify the type initializer as material and semantic ordering remains correct.

## Candidate searches

Use searches only to locate types already implicated by measurements:

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' 'sealed class|abstract class|virtual |override |interface |readonly struct|IEquatable|StructLayout|static .*\(' .

Do not produce codebase-wide ratios or count-based findings.
