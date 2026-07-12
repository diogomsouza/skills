# I/O and Serialization Review

Separate CPU, allocation, buffering, network, storage, and remote-service latency. Optimize the dominant cost instead of assuming an API-shaped pattern is the bottleneck.

## HTTP

### Client and handler lifetime

Repeated HttpClient or handler creation can prevent connection reuse or exhaust sockets. Confirm whether IHttpClientFactory, dependency injection, a shared handler, or another owner manages lifetime before reporting.

### Streaming responses

ResponseHeadersRead and stream processing can reduce buffering for large responses. Confirm response size, consumer behavior, disposal, cancellation, error handling, and whether the full payload is ultimately required in memory.

### Concurrency and retries

Check connection limits, backpressure, retry amplification, timeouts, cancellation, and remote-service quotas. Do not improve local throughput by overwhelming a dependency.

## File and stream I/O

Async I/O helps scalable concurrent workloads but is not automatically faster for one operation. Confirm concurrency, file sizes, platform, buffering, and whether APIs are genuinely asynchronous.

Memory-based Stream overloads can reduce adapter allocations on supported targets. Report them only in a recurring measured path.

Avoid tiny reads and writes when batching or larger buffers produce a demonstrated benefit. Do not increase buffers without considering memory concurrency and pooling ownership.

## JSON and serialization

### Options lifetime

Repeated JsonSerializerOptions construction can lose metadata caches. Confirm construction frequency and whether shared options remain immutable after first use.

### Source generation

System.Text.Json source generation can help Native AOT, trimming, startup, and high-throughput serialization. It adds generated metadata and maintenance cost. Recommend it when deployment constraints or measurements justify it.

### Payload and object shape

Inspect payload size, materialization, encoding, naming policies, converters, reference handling, and intermediate buffers. Preserve wire compatibility.

## Formatting and encoding

TryFormat, span overloads, and UTF-8 APIs can reduce temporary objects when data is written directly to a compatible destination. Avoid manual buffer management for cold or low-volume paths.

## Candidate searches

    rg -n --glob '*.cs' --glob '!**/bin/**' --glob '!**/obj/**' 'new HttpClient\(|IHttpClientFactory|ResponseHeadersRead|new FileStream\(|ReadAsync\(|WriteAsync\(|new JsonSerializerOptions|JsonSerializer\.|Encoding\.' .

Trace ownership, payload sizes, concurrency, and target framework before reporting.
