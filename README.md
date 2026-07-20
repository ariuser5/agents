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

## Configure an agent

Bootstrap does not modify model or editor configuration. After bootstrapping a
machine, paste the following prompt into Codex, Claude, Copilot, Gemini, or
another local coding agent:

```text
Configure your user-global persistent instructions to use my bootstrapped agent
rules.

1. Resolve my absolute home directory and verify that `<HOME>/.agents/global.md`
   exists. On Windows this will usually be under `%USERPROFILE%\.agents`; on
   macOS or Linux it will usually be under `$HOME/.agents`.
2. Read `<HOME>/.agents/global.md` and the relevant platform note under
   `<HOME>/.agents/adapters/` before changing configuration.
3. Determine the user-global instruction or memory location supported by the
   agent you are currently running as. Configure user scope only. Do not create
   or modify instruction files inside the current project or repository.
4. Preserve all existing user instructions. Before modifying an existing file,
   create a timestamped backup beside it. Add or update only this managed block:

   <!-- BEGIN BOOTSTRAPPED AGENT RULES -->
   Use `<ABSOLUTE_HOME>/.agents/global.md` as global persistent instructions.
   Resolve every referenced path from `<ABSOLUTE_HOME>/.agents`. Always apply
   `global.md`; when its routing table matches the current task, read and apply
   the named rule or skill before acting. Do not load every routed resource by
   default.
   <!-- END BOOTSTRAPPED AGENT RULES -->

5. Replace `<ABSOLUTE_HOME>` with the real absolute path. Do not leave `~`, an
   environment variable, or a placeholder in the installed instruction.
6. Verify that the resulting configuration contains exactly one managed block,
   that the referenced `global.md` is readable, and that existing instructions
   remain intact.
7. Report the configuration file changed, whether a backup was needed and where
   it was written, and whether a restart or new session is required.

If you cannot identify or modify your own user-global configuration, do not
guess and do not modify the project. Instead, tell me the exact manual steps and
the exact text I should add. If you need to choose between multiple materially
different global configuration mechanisms, ask me one focused question first.
```

Known native locations are documented under [`adapters/`](adapters/). The
routed setup is preferred because it keeps detailed playbooks out of the context
window until relevant. If an agent cannot read routed files on demand, configure
it to load all Markdown and YAML files under `.agents/rules` and `.agents/skills`
instead.

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
