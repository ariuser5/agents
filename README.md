# Agent Operating Standard

Vendor-neutral instructions, rules, and playbooks for coding agents.

The repository is a text bundle. Its bootstrap only copies that bundle to the
current user's home directory; configuring Codex, Claude, Copilot, Gemini, or
another agent to load it is intentionally left to the user.

## Bootstrap

Windows PowerShell:

```powershell
.\bootstrap.ps1
```

macOS, Linux, WSL, or Git Bash:

```sh
sh bootstrap.sh
```

Both commands copy the rules to:

```text
$HOME/.agents/
  global.md
  rules/
  skills/
  adapters/
```

Only those four allowlisted entries are copied. Repository metadata and support
files such as `.git`, `.gitignore`, `.gitattributes`, `README.md`, `LICENSE`, and
the bootstrap scripts are not copied.

Running bootstrap again overwrites matching bundle files with the current
repository versions. It does not delete additional files already under
`$HOME/.agents`.

## Register with an agent

Bootstrap does not modify any model or editor configuration. Add an instruction
like this to each agent's user-global memory or instruction file, replacing
`<HOME>` with the absolute home path when the agent does not expand `~`:

```markdown
Use `<HOME>/.agents/global.md` as global persistent instructions. Resolve every
referenced path from `<HOME>/.agents`. Always apply `global.md`; when its routing
table matches the current task, read and apply the named rule or skill before
acting.
```

Examples of native configuration locations are documented under
[`adapters/`](adapters/):

- Codex: `~/.codex/AGENTS.md`
- Claude Code: `~/.claude/CLAUDE.md` or `~/.claude/rules/`
- Copilot CLI: `~/.copilot/copilot-instructions.md`
- VS Code Copilot: a user-profile `*.instructions.md` file
- Gemini CLI: `~/.gemini/GEMINI.md`

If an agent cannot read routed files on demand, use this stronger fallback:

```markdown
Load `<HOME>/.agents/global.md` and all Markdown and YAML resources under
`<HOME>/.agents/rules` and `<HOME>/.agents/skills` as global instructions.
```

The routed version is preferred because it keeps detailed playbooks out of the
context window until they are relevant.

## Structure

```text
global.md                 Always-on entrypoint and routing table
rules/
  agent-rules.yaml        Authority, triggers, resources, and defaults
  decision-matrix.md      When to ask and when to proceed
  research-policy.md      Search order and stopping conditions
skills/
  clarify.md              Focused clarification workflow
  research.md             Evidence-gathering workflow
  task-execution.md       Surgical implementation workflow
  ticket-work.md          Ticket context and session continuity
  verification.md         Smallest-useful-check workflow
adapters/                 Human-readable platform setup notes
```

## Ticket continuity

Ticket-like work checks `~/Tickets` and `~/tickets` for a matching folder and
`context.md`. The agent asks before creating or updating task context. If context
creation is declined, the work remains session-bound.

At material decisions, milestones, blockers, or handoff, the agent offers a
short proposed context update. This makes unfinished tasks resumable without
turning `context.md` into a conversation transcript.

## Editing

Keep `global.md` short and limited to always-on routing. Put detailed policies
under `rules/` and reusable workflows under `skills/`.

## License

[MIT](LICENSE)
