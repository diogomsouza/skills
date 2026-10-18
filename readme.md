# Skills and Agents

This repository collects the custom skills and agents I create for use across different AI tools. It currently contains the Codex collection; collections for other tools can be added as the repository grows.

A **skill** defines a reusable workflow for a particular task. An **agent** defines a delegated role with its own responsibilities, boundaries, and reporting rules. The descriptions below explain when each is useful and link to its source definition.

## Repository structure

```text
codex/
    skills/         Skill definitions and their supporting resources
    agents/         Agent role configurations in TOML format
docs/
    skills/         One description per skill, named <skill-name>.md
    agents/         One description per agent, named <agent-name>.md
code-craft.md       Extended guide to the Code Craft workflow
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
| [grill-code](docs/skills/grill-code.md) | Challenges a technical plan through a focused interview grounded in the current codebase. | [SKILL.md](codex/skills/grill-code/SKILL.md) |
| [system-spec](docs/skills/system-spec.md) | Writes and independently reviews system documentation, references, and operational or user guides. | [SKILL.md](codex/skills/system-spec/SKILL.md) |
| [tech-spec](docs/skills/tech-spec.md) | Writes and independently reviews an implementation specification for a software change. | [SKILL.md](codex/skills/tech-spec/SKILL.md) |
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

## Reading the collection

Start with a linked description to understand a skill or agent's purpose, scope, and expected result. Consult its source definition for the complete instructions and prerequisites. The catalog describes files maintained in this repository; availability in a running tool depends on that tool's local setup.

For a detailed explanation of orchestration, model selection, verification, and checkpoints, see the [Code Craft guide](code-craft.md).

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
