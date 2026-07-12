# Critical .NET Performance Candidates

Use this reference to identify stability risks and pathological costs. A search hit is only a candidate. Confirm the concrete execution path, workload, target framework, and resource lifetime before reporting.

## Sync-over-async

Candidate signals:

- Task.Result, Task.Wait, GetAwaiter().GetResult, or blocking waits around asynchronous I/O.

Confirm:

- the receiver is a Task or ValueTask;
- the path runs under request, UI, scheduler, or limited-thread execution;
- blocking can cause starvation, reentrancy, or deadlock; and
- an async call chain can be preserved end to end.

Do not report benign blocking in process startup or controlled console boundaries without demonstrating impact.

## Unbounded concurrency

Candidate signals:

- Task.WhenAll over unbounded inputs;
- fire-and-forget work created inside loops;
- queues without capacity or backpressure; and
- one task, connection, or buffer per item.

Confirm the maximum input size, cancellation behavior, failure aggregation, external-service limits, and memory growth. Prefer bounded concurrency or backpressure only when the workload requires it.

## Async-void and lost failures

Async void is appropriate for required event-handler signatures. Elsewhere, confirm whether exceptions escape observation or completion cannot be coordinated. Do not flag event handlers solely because they are async void.

## ValueTask misuse

Confirm repeated awaits, multiple AsTask conversions, result access before completion, or storage beyond the supported lifetime. ValueTask backed by IValueTaskSource can be consumed only as documented by the producer.

Do not recommend ValueTask as a fix unless synchronous completion is common on a measured hot path.

## Stack and pooled-buffer hazards

Report stackalloc only when size, loop placement, recursion, or input control creates a concrete stack-exhaustion risk.

For ArrayPool usage, verify:

- rented buffers are returned on every path;
- consumers use only the requested logical length;
- sensitive contents are cleared when required;
- references do not escape after return; and
- pooling reduces repeated meaningful allocations.

Pooling bugs are correctness issues, not optimizations.

## Pathological regex behavior

Treat regex as critical when attacker-controlled or large input can trigger catastrophic backtracking, excessive work, or unbounded execution. Verify pattern features, engine mode, timeout, and input boundary before recommending NonBacktracking or a rewrite.

## Connection and handle exhaustion

Check repeated construction and disposal of HttpClient, sockets, streams, timers, or native handles. Confirm the actual lifetime and whether IHttpClientFactory, a shared handler, or another owner already manages resources.

## Candidate searches

Run targeted searches and inspect every hit in context:

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' '\.Result|\.Wait\(|GetAwaiter\(\)\.GetResult\(\)|async void|Task\.WhenAll|stackalloc|ArrayPool|new HttpClient\(|new Regex\(' .

Do not report counts as severity. Report only verified paths with concrete impact.
