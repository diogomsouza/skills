# Collections and LINQ Review

Review data shape, collection size, mutation, enumeration count, and call frequency before changing an API or replacing readable LINQ.

## Candidate patterns

### Capacity and materialization

Pre-size List, Dictionary, Queue, or Stack when a reliable count is available and repeated growth is material. Do not enumerate a source merely to obtain a count. TryGetNonEnumeratedCount can help when the target framework supports it.

### Duplicate lookup

ContainsKey followed by an indexer or repeated TryGetValue calls may duplicate hashing and lookup work. Confirm the same dictionary and key are used in a recurring path before consolidating.

### Multiple enumeration

Repeated enumeration can re-run deferred queries, I/O, or expensive projections. Establish whether the source is replayable, side-effecting, large, or already materialized before recommending ToArray or ToList.

### LINQ in hot paths

LINQ is acceptable in most code. Replace it only when profiles or benchmarks show iterator, delegate, sorting, grouping, or materialization cost matters. Preserve ordering, deferred execution, exceptions, comparer behavior, and short-circuit semantics.

### Frozen collections

FrozenDictionary and FrozenSet trade construction cost and immutability for lookup performance. Consider them for stable, read-heavy lookup tables after confirming target framework, initialization frequency, data size, comparer semantics, and measured benefit.

### Low-level dictionary access

CollectionsMarshal APIs can avoid lookups or copies but expose ref-lifetime and mutation hazards. Recommend them only for a proven hot path with tightly controlled dictionary lifetime. Never retain a ref across a mutation that may resize the dictionary.

### Collection expressions and spans

Collection expressions may target arrays, spans, or other collection builders. Confirm the actual target type and generated allocation before calling the syntax allocation-free.

### params allocations

Additional overloads or params ReadOnlySpan can reduce temporary arrays in high-frequency APIs. Weigh public API growth, overload resolution, language version, and compatibility.

### Static data

Hoist deterministic collections out of recurring methods only when construction is repeated and state is truly immutable. Watch for closures, per-request configuration, localization, and mutable values.

## Candidate searches

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' 'ContainsKey\(|TryGetValue\(|\.ToList\(|\.ToArray\(|\.Where\(|\.Select\(|\.OrderBy\(|\.GroupBy\(|new List<|new Dictionary<|FrozenDictionary|FrozenSet|CollectionsMarshal|params ' .

Do not rank findings by hit count. Trace the data and call path.
