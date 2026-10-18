# code-reviewer-security

This agent independently reviews changes affecting security boundaries or guarantees. Its scope includes authentication, authorization, tenant isolation, privacy, cryptography, secrets, untrusted input, privileged operations, installers, services, drivers, elevation, and software supply chains.

It identifies affected assets and trust boundaries, traces attacker-controlled inputs to sensitive effects, and checks whether existing controls cover plausible failure paths. Findings must connect a reachable trigger to a violated protection and concrete consequence. Ordinary functional and maintainability defects belong to [reviewer](reviewer.md) unless they affect a security guarantee.

The configuration uses a read-only sandbox and forbids file edits. The agent assesses the supplied scope, requirements, code, and evidence independently, keeping confirmed defects separate from suggestions and unresolved verification.

Its verdict is `ACCEPT`, `REJECT`, or `BLOCKED`. A confirmed in-scope defect causes rejection; a missing prerequisite for a required review obligation causes a blocked verdict when no defect is confirmed.

- [Agent configuration](../../codex/agents/code-reviewer-security.toml)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
