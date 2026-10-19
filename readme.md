# Skills and Agents

This repository collects the custom skills and agents I create or adapt for use across different AI tools. It currently contains collections for Codex and Claude Code; collections for other tools can be added as the repository grows.

A **skill** defines a reusable workflow for a particular task. An **agent** defines a delegated role with its own responsibilities, boundaries, and reporting rules. Skills can guide the lead agent directly or coordinate delegated work; agent roles define how an assigned part of that work is carried out or reviewed.

The guides below explain the problem each skill or agent addresses, how its workflow operates, when to choose it, and what to expect from its output. Each guide includes examples and links to the maintained source definition. The definitions contain the operating instructions; the guides help readers understand and use them.

## Repository structure

```text
codex/
    skills/         Skill definitions and their supporting resources
    agents/         Agent role configurations in TOML format
docs/
    skills/         Detailed skill guides, named <skill-name>.md
    agents/         Detailed agent guides, named <agent-name>.md
readme.md           Repository overview and catalog
```

Each skill directory contains a `SKILL.md` and may include references, scripts, assets, or `agents/openai.yaml` metadata. Those YAML files describe the associated skill; the separate agent roles in this catalog are defined under `codex/agents/`.

## Codex skills

The repository contains **8 skills**.

| Skill | What it does | Definition |
| --- | --- | --- |
| [code-craft](docs/skills/code-craft.md) | Coordinates complex implementation through planning, bounded delegation, verification, and resumable checkpoints. | [SKILL.md](codex/skills/code-craft/SKILL.md) |
| [code-formatter](docs/skills/code-formatter.md) | Formats C# and C++ using its bundled executable when explicitly requested. | [SKILL.md](codex/skills/code-formatter/SKILL.md) |
| [code-quality-review](docs/skills/code-quality-review.md) | Reviews maintainability, prioritizing unused, unreachable, and obsolete code. | [SKILL.md](codex/skills/code-quality-review/SKILL.md) |
| [create-codex-instance](docs/skills/create-codex-instance.md) | Creates a separate Codex profile on Windows with a launcher, colored tray icon, and shortcuts. | [SKILL.md](codex/skills/create-codex-instance/SKILL.md) |
| [grill-code](docs/skills/grill-code.md) | Challenges a technical plan through a focused interview grounded in the current codebase. Adapted from [grill-with-docs](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs) by Matt Pocock. | [SKILL.md](codex/skills/grill-code/SKILL.md) |
| [system-spec](docs/skills/system-spec.md) | Writes and independently reviews system documentation, references, and operational or user guides. | [SKILL.md](codex/skills/system-spec/SKILL.md) |
| [craft-spec](docs/skills/craft-spec.md) | Writes and independently reviews an implementation specification for a software change. | [SKILL.md](codex/skills/craft-spec/SKILL.md) |
| [test-audit](docs/skills/test-audit.md) | Gates test authoring and audits suites to remove prohibited or unjustified tests while preserving critical proof. | [SKILL.md](codex/skills/test-audit/SKILL.md) |

## Codex agents

The repository contains **6 agents**. Implementation agents perform assigned work; review agents independently assess a candidate without editing it.

| Agent | Role | Configuration |
| --- | --- | --- |
| [code-reviewer-security](docs/agents/code-reviewer-security.md) | Reviews security boundaries, sensitive operations, and required protections. | [TOML](codex/agents/code-reviewer-security.toml) |
| [complex-code-worker](docs/agents/complex-code-worker.md) | Implements algorithmic, numerical, parser, protocol, native, and memory-model cores. | [TOML](codex/agents/complex-code-worker.toml) |
| [document-reviewer](docs/agents/document-reviewer.md) | Reviews documentation for clarity, completeness, factual grounding, and audience fit. | [TOML](codex/agents/document-reviewer.toml) |
| [grok-worker](docs/agents/grok-worker.md) | Coordinates implementation by Grok through the official Cursor CLI. | [TOML](codex/agents/grok-worker.toml) |
| [reviewer](docs/agents/reviewer.md) | Reviews non-trivial code changes for correctness, regressions, contracts, and failure handling. | [TOML](codex/agents/reviewer.toml) |
| [state-machine-worker](docs/agents/state-machine-worker.md) | Implements lifecycle and recovery behavior requiring explicit transition modeling. | [TOML](codex/agents/state-machine-worker.toml) |

## Choose a starting point

| What you need | Start here |
| --- | --- |
| Document the system, its context, and intended behavior | [System Spec](docs/skills/system-spec.md) |
| Use the system documentation to create an implementation specification | [Craft Spec](docs/skills/craft-spec.md) |
| Implement the technical specification with integration, verification, and checkpoints | [Code Craft](docs/skills/code-craft.md) |
| Find unused code or improve maintainability within a defined scope | [Code Quality Review](docs/skills/code-quality-review.md) |
| Evaluate or reduce a test suite, or decide whether a new test is justified | [Test Audit](docs/skills/test-audit.md) |
| Apply the bundled C# and C++ formatter | [Code Formatter](docs/skills/code-formatter.md) |
| Create a separate Windows Codex profile | [Create Codex Instance](docs/skills/create-codex-instance.md) |

The main development workflow follows **System Spec → Craft Spec → Code Craft**. Start by documenting the system with System Spec. Use that document as input to Craft Spec to define the software changes and their implementation requirements. Then use Code Craft to implement the accepted technical specification, carrying the work through integration, verification, and checkpoints. The remaining skills support focused tasks such as code review, test auditing, formatting, and environment setup.

The agent guides explain delegated responsibilities. For example, an algorithmic core can be assigned to `complex-code-worker`, lifecycle recovery can be assigned to `state-machine-worker`, and a completed change can be independently assessed by `reviewer`. Security and document review have dedicated roles. `grok-worker` coordinates an external implementation executor and has additional runtime prerequisites.

## Read and use the guides

Start with a linked guide to understand a skill or agent's purpose, scope, and expected result. Consult its source definition for the complete instructions and prerequisites. The catalog describes files maintained in this repository; availability in a running tool depends on that tool's local setup. Agent configurations do not make their external dependencies available automatically.

Examples in the guides are requests you can adapt after the corresponding skill or agent is available in your environment. Supply the objective, relevant paths or documents, constraints, and any restriction such as review only. Agent assignment examples describe the intended delegated work; they are not shell commands or configuration syntax.

Keep documentation under `docs/skills/` and `docs/agents/` aligned with the definitions under `codex/`. When adding an item, include a guide named after it and a catalog entry. Credit adapted work in its guide and retain links to the original source, as with `grill-code` above.

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
