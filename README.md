# Agent Operating Standard

Vendor-neutral instructions, skills, personas, and workflows shared across
agent products through one protected runtime library.

## Architecture

- This Git repository is the maintained authoring source.
- `~/.agents/AGENTS.md` is the canonical runtime entrypoint read by agents.
- `~/.agents/` is a deployed copy and is immutable to agents by default.
- Each product keeps only a small external adapter in its own user-global
  configuration. Product-specific state and credentials stay outside the
  shared runtime.

The repository bootstrap deploys the library. It intentionally does not edit
Codex, Claude, Copilot, Gemini, ChatGPT, or other product configuration.

## Bootstrap

Windows PowerShell:

```powershell
.\bootstrap.ps1
```

Preview a Windows deployment without writing:

```powershell
.\bootstrap.ps1 -WhatIf
```

macOS, Linux, WSL, or Git Bash:

```sh
sh bootstrap.sh
```

Both scripts deploy these managed entries to `$HOME/.agents/`:

```text
AGENTS.md                  Canonical runtime entrypoint
global.md                  Legacy compatibility shim
catalog.md                 Canonical resource routing index
adapter-notes.md           Rules for product-specific adaptations
change-control.md          Protected-runtime authorization protocol
rules/
skills/
personas/
```

`managed-files.txt` is the reviewed deployment allowlist. The scripts first
verify that every listed source file exists, then create the required runtime
directories and copy or overwrite those files.

Bootstrap is intentionally copy-only. It does not delete unlisted or obsolete
runtime files, clean the destination, maintain deployment state, or modify any
product configuration. Repository metadata and support files are never copied.
Running bootstrap repeatedly is safe and simply reapplies the listed files.

Installed files should not be edited by hand or by an agent. Make shared
changes in this repository, review the diff, and deploy again. A user personally
running the trusted bootstrap is a deliberate deployment. An agent that runs or
causes it must first follow the exact one-time confirmation procedure in
`change-control.md`.

## Configure an agent product

After bootstrapping a machine, give the current agent product this prompt:

```text
Configure your user-global persistent instructions to use my bootstrapped shared
agent library.

1. Resolve my absolute home directory and verify that
   `<HOME>/.agents/AGENTS.md` exists. Read it and
   `<HOME>/.agents/adapter-notes.md` before changing configuration.
2. Determine the user-global instruction or memory location supported by the
   agent product you are currently running as. Configure user scope only. Do not
   create or modify an instruction file inside the current repository.
3. Do not modify `<HOME>/.agents/` or anything inside it. Preserve all existing
   product instructions and create a timestamped backup before modifying an
   existing native configuration file.
4. Add or update exactly one managed block, replacing `<ABSOLUTE_HOME>` with the
   resolved absolute path:

   <!-- BEGIN BOOTSTRAPPED AGENT RULES -->
   Before doing any work in each new session, read and follow
   `<ABSOLUTE_HOME>/.agents/AGENTS.md`. Load only its catalog resources relevant
   to the request. Treat `<ABSOLUTE_HOME>/.agents/` as protected and follow its
   exact change-control procedure for every direct or indirect agent mutation
   there.
   <!-- END BOOTSTRAPPED AGENT RULES -->

5. Do not leave `~`, an environment variable, or a placeholder in the installed
   block. If product-specific commands or phrasing are needed, record only that
   adaptation in the product's native configuration or an external adapter note;
   do not fork the shared library.
6. Verify in a fresh session that the native instruction was automatically
   loaded and that it can read the absolute `.agents/AGENTS.md` path. Report the
   native file changed, backup location, verification result, and whether a
   restart is required.

If this product cannot automatically load a durable instruction or read that
local path, do not guess and do not claim success. Tell me the exact supported
manual alternative and its limitation.
```

## Structure

```text
AGENTS.md                  Startup, authority, protection, shared defaults
catalog.md                 Trigger-to-resource routing
change-control.md          Exact confirmation-keyword protocol
adapter-notes.md           External adapter conventions
global.md                  Legacy redirect to AGENTS.md
managed-files.txt          Reviewed bootstrap deployment allowlist
rules/
  agent-rules.yaml         Machine-readable mirror of the catalog
  decision-matrix.md       When to ask and when to proceed
  research-policy.md       Search order and stopping conditions
skills/
  clarify.md               Focused clarification workflow
  code-review-on-my-behalf.md
                           Review and draft comments in the user's voice
  global-local-news-brief/
    SKILL.md               Global and Romanian news catch-up workflow
  research.md              Evidence-gathering workflow
  task-execution.md        Surgical implementation workflow
  ticket-work.md           Ticket context and session continuity
  verification.md          Smallest-useful-check workflow
personas/
  default.md               Default behavior and communication style
  pragmatic-reviewer.md
                           First-person review comment style
```

`catalog.md` is the canonical human/agent routing index.
`rules/agent-rules.yaml` mirrors it for tooling and must be updated in the same
change.

## Protected runtime

An agent cannot mutate any path under `~/.agents/` based on “yes,” “go ahead,”
general authorization, or prior consent. It must show the exact scoped change,
generate a fresh high-entropy confirmation keyword, and receive the exact
standalone response required by `change-control.md`. The authorization is
single-use and expires after 15 minutes, scope change, or session end.

This restriction includes indirect writes through bootstrap, synchronization,
formatting, or generation tools. It does not restrict normal, authorized edits
to this Git authoring repository.

## Machine-local and product-local notes

Keep mutable local adaptations outside the protected runtime:

```text
$HOME/.agent-notes/
  shared/AGENTS.md                       Optional machine-wide extension
  <agent-id>/shared-agents-adapter.md    Product-specific adaptation
```

The shared runtime may read `~/.agent-notes/shared/AGENTS.md` after its own
rules. Local notes may adapt paths, tools, and capabilities but cannot weaken
the protected-runtime policy or any higher-priority instruction. Bootstrap
never creates or modifies `.agent-notes/`.

## News briefing skill

`skills/global-local-news-brief/SKILL.md` is the shared workflow for curated
global and Romanian news catch-ups, continuing stories, and misinformation
checks. Bootstrap installs the workflow itself, not its mutable state.

The skill uses one private, versioned ledger in the separate `ai-agent-state`
repository. Each product stores only a small private locator in its own native
state area. Do not add the locator, ledger, credentials, or article text to this
repository or `~/.agents/`, and do not create provider-local fallback ledgers.

Invoking this routed skill authorizes only its documented ledger-only fetch,
fast-forward, update, commit, and push workflow. It does not authorize staging
unrelated files, force-pushing, or changing any other repository.

If a product requires native skill metadata for discovery, use a thin external
adapter that points to this shared `SKILL.md`. Retire full provider-local copies
after verifying the shared route; do not maintain two editable skill bodies.

## Personas and ticket continuity

The default persona applies unless the user or a routed skill selects another.
Personas affect behavior and presentation only; they cannot override rules,
evidence, permissions, or safety constraints.

Ticket-like work checks `~/Tickets` and `~/tickets` for matching `context.md`
files. Creating or updating ticket context always requires the user's approval;
if declined, the work remains session-bound.

## Editing

Keep `AGENTS.md` concise and always-on. Put routing metadata in `catalog.md`,
detailed policies in `rules/`, reusable workflows in `skills/`, behavioral
profiles in `personas/`, and the product adaptation contract in
`adapter-notes.md`. Update `managed-files.txt` whenever a deployed file is
added, renamed, or removed.

## License

[MIT](LICENSE)
