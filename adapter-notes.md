# Product Adaptation Contract

This shared library deliberately contains no vendor-specific setup templates.
An agent must determine its own current, supported startup-instruction mechanism
when the user explicitly asks it to configure the product.

## Create an adaptation

1. Read `~/.agents/AGENTS.md` before configuring anything.
2. Identify the product's actual user-global persistent-instruction mechanism.
   Do not infer it from the vendor name, model name, or another product.
3. Preserve existing instructions and create a timestamped backup before editing
   an existing configuration file.
4. Add or update one minimal bridge using the resolved absolute home path:

```markdown
<!-- BEGIN BOOTSTRAPPED AGENT RULES -->
Before doing any work in each new session, read and follow
`<ABSOLUTE_HOME>/.agents/AGENTS.md`. Load only its catalog resources relevant to
the request. Treat `<ABSOLUTE_HOME>/.agents/` as protected and follow its exact
change-control procedure for every direct or indirect agent mutation there.
<!-- END BOOTSTRAPPED AGENT RULES -->
```

5. Keep product-specific commands, translations, generated state, and detailed
   notes in the product's normal user-level area—not under `~/.agents/`. If no
   suitable notes location exists, use
   `~/.agent-notes/<agent-id>/shared-agents-adapter.md` as documentation; the
   product still needs a supported startup mechanism that loads the bridge.
6. Verify in a new session that the bridge loaded automatically and that the
   absolute `~/.agents/AGENTS.md` path is readable.
7. Report the configuration changed, backup location, verification result, and
   any limitation or restart requirement.

If the product cannot persist startup instructions or cannot read the local
path, state that limitation and stop. Do not invent an integration, copy the
shared library into product configuration, or claim the rules are active.

An adaptation may translate product-specific capabilities but may not weaken,
override, or silently fork the shared rules. Never store credentials, private
state, or generated product data under `~/.agents/`.
