# grok-worker

Grok Worker coordinates bounded implementation assignments performed by Grok through the official Cursor CLI. It is a Codex coordinator for an external executor. The repository configuration selects `gpt-5.6-luna` with medium reasoning for coordination and requires Grok 4.7 with High reasoning and Fast disabled for implementation.

It passes the authorized workspace, owned files, constraints, and validation requirements to the Cursor ACP executor, follows observable progress, and inspects the resulting changes and checks. A completed executor turn alone does not prove that the requested behavior is correct.

The runtime needs Python 3, the official Cursor CLI, a valid Cursor login, and `tools/cursor-acp/cursor_acp_executor.py` under the active Codex configuration directory. That executor is an external prerequisite and is not included in this repository. Coordination and implementation use their respective Codex and Cursor account usage rules.

Use this role for implementation assignments. It must not silently substitute its own implementation or another model. Its handoff identifies Grok, the Cursor session, changed files, checks actually performed, and limitations, including uncertain partial changes after an interrupted or failed run.

- [Agent configuration](../../codex/agents/grok-worker.toml)
- [Repository catalog](../../readme.md)

<!-- Context: 2026-10-18-skills-and-agents-catalog; Created: 2026-10-18T06:38:13-03:00 -->
