# Async and Concurrency Review

Evaluate async code in the context of scheduler behavior, request concurrency, I/O latency, cancellation, and resource limits. Syntax alone does not establish a performance problem.

## Review questions

- Is the operation I/O-bound, CPU-bound, or mixed?
- Does it block a request, UI, scheduler, or limited worker thread?
- What is the maximum concurrency and input size?
- Is cancellation propagated through downstream calls?
- Are tasks observed, awaited, and bounded?
- Does the change reduce throughput or only change single-call latency?

## Candidate patterns

### Sync-over-async

Inspect Result, Wait, and GetAwaiter().GetResult calls. Confirm the receiver type and execution context. Prefer an async call chain when blocking consumes scarce threads or creates a deadlock or reentrancy path.

### Task.Run wrappers

In reusable libraries, do not wrap synchronous I/O or CPU work in Task.Run merely to expose an async API. In application code, Task.Run may be appropriate to keep UI work responsive or isolate CPU work when the scheduler and cancellation behavior are understood.

### ValueTask

Recommend ValueTask only when profiling shows Task allocation matters and synchronous completion is common. Account for its larger return value, consumption rules, combinator friction, and implementation complexity.

### Async state machines

Avoid recommending manual task forwarding solely to remove an async state machine. First check exception timing, using or finally scopes, cancellation, stack traces, and whether a benchmark shows meaningful overhead.

### Producer and consumer flows

Channels, bounded queues, and semaphores can provide backpressure. Recommend them when existing throughput, memory, or external-service pressure demonstrates a need. Do not replace a simple bounded flow with infrastructure for theoretical scalability.

### Contention and false sharing

Require profiler, counter, or benchmark evidence before suggesting lock restructuring, padding, partitioning, atomics, or thread-local state. These changes are architecture and correctness sensitive.

### Cancellation

Missing CancellationToken propagation can waste work after callers abandon an operation. Treat it as a performance finding only when abandoned work is material in the relevant workload.

## Candidate searches

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' 'async void|Task\.Run|ValueTask|\.Result|\.Wait\(|GetAwaiter\(\)\.GetResult\(\)|Task\.WhenAll|SemaphoreSlim|lock \(' .

For each hit, trace the call path and establish workload evidence before reporting.
