# Code Reviewer Security

**Trace changed security boundaries and establish whether required protections still hold.**

Code Reviewer Security independently reviews changes affecting confidentiality, integrity, availability, privacy, authorization, or isolation. It covers application security as well as sensitive infrastructure such as installers, privileged services, drivers, elevation, and software supply chains.

The review begins with the actual assets, identities, trust boundaries, and plausible attacker control involved in the change. Findings need a reachable causal path and a failed protection; security terminology or an alarming scanner message is not sufficient evidence.

## Choose a security-relevant scope

Use the role when a change modifies a protection or a path that depends on one. Examples include token validation, access to tenant-owned resources, path handling in an elevated installer, secret-bearing diagnostics, or artifact verification in an update flow.

The caller supplies the objective and scope. Otherwise, the role reviews staged, unstaged, and untracked changes. It reads applicable guidance, security requirements, threat models, and consumers, resolving missing context from evidence without inventing deployment assumptions.

Ordinary functional or maintainability problems belong to [Reviewer](reviewer.md), unless they directly affect an in-scope security guarantee.

## Follow identities and untrusted data to effects

The agent traces untrusted inputs and identities through validation, transformations, control changes, sensitive operations, and outputs. Alternate entry points matter because a protection on the main path may not cover a bulk operation or background job.

Authorization is assessed for the identity, action, resource, and tenant when the effect occurs. Cached permissions, revocation, and stale state can change that answer after an earlier check.

The review also compares what was validated with what is eventually used after decoding, normalization, redirects, path resolution, or deserialization. This exposes cases where a validated string and the actual target no longer have the same meaning.

For example, validating a destination before resolving links may not establish that an elevated write remains inside an allowed directory. The review must inspect the full resolution and use path and any existing controls before confirming such a defect.

## Apply checks that match the boundary

| Boundary | Relevant concerns |
| --- | --- |
| Authentication and sessions | Token authenticity, issuer, audience, purpose, expiration, revocation, and replay |
| Authorization and isolation | Resource ownership, tenant boundaries, alternate paths, and changes in permissions |
| Injection and browser behavior | Parameterization, contextual encoding, command construction, deserialization, and cross-origin controls |
| Network and filesystem | Attacker-controlled destinations, redirects, resolved paths, links, and privileges |
| Cryptography | Appropriate constructions, key lifetimes, randomness, nonce constraints, and authentication |
| Privacy and secrets | Exposure or retention in responses, logs, telemetry, caches, storage, and diagnostics |
| Availability and memory safety | Input-controlled allocation, expansion, recursion, resource retention, and unsafe access |
| Supply chain | Sources, resolved versions, lockfiles, build permissions, artifact verification, installation, and rollback |

The agent applies relevant checks rather than treating the table as proof that every category was assessed. Advisory findings require authoritative applicability evidence for the actual versions and conditions.

## Preserve independence and sensitive evidence

The [configuration](../../codex/agents/code-reviewer-security.toml) uses a read-only sandbox and forbids editing. The agent does not create or recommend new tests. It can inspect existing checks and run permitted ones only when useful and possible without changing files or external state.

Code and authoritative documentation can establish a defect without exploit execution. Conversely, passing tests and scanner alerts do not decide the verdict on their own. Suspected issues are challenged against framework guarantees, upstream validation, downstream controls, and actual configuration.

The handoff cites sensitive locations without reproducing secret values. It distinguishes static reasoning, supplied evidence, and checks actually executed.

## Interpret the result

A confirmed security defect identifies the reachable input or access condition, causal location, failed protection, affected asset or boundary, consequence, and focused correction. Severity P0–P3 reflects the actual impact, reach, required access, recoverability, and workarounds.

| Verdict | Meaning |
| --- | --- |
| `ACCEPT` | Required obligations are established and no in-scope security defect is confirmed |
| `REJECT` | A confirmed in-scope security defect exists, regardless of severity |
| `BLOCKED` | No defect is confirmed, but essential access, information, or evidence is missing |

A confirmed defect takes precedence over an evidence gap. Suggestions remain separate and do not automatically expand the task into generic hardening. An accepted review is a conclusion about the reviewed scope, not a claim that the entire product is secure.

## Example assignment

```text
Review the changes to the elevated update installer.
Assess how the supplied archive, destination paths, and verified artifact identity
reach privileged writes. Inspect rollback and diagnostics where they affect
security guarantees. Remain read-only and identify the evidence for each finding.
```

A useful handoff gives the implementing task enough information to reproduce the reasoning and correct the failed protection without guessing at the threat or affected boundary.

## Source and related guides

- [Agent configuration](../../codex/agents/code-reviewer-security.toml) — security scope, evidence, severity, and verdict criteria.
- [Reviewer](reviewer.md) — general correctness and regression review.
- [Repository catalog](../../readme.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->