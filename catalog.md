# Shared Resource Catalog

This is the canonical routing index for shared resources. Consult it after
`AGENTS.md`, then load only the rows whose trigger matches the current request.
`rules/agent-rules.yaml` is a machine-readable mirror; this catalog wins if the
two ever differ.

| Trigger | Type | Read before acting |
| --- | --- | --- |
| Every session | Persona | `personas/default.md` |
| Ticket identifier at conversation start, or ticket-like task | Skill | `skills/ticket-work.md` |
| Missing material requirement, consequential choice, or scope change | Rule, then skill | `rules/decision-matrix.md`, then `skills/clarify.md` |
| Investigation, unfamiliar code, factual uncertainty, or external lookup | Rule, then skill | `rules/research-policy.md`, then `skills/research.md` |
| Code, configuration, documentation, or file changes requested | Skill | `skills/task-execution.md` |
| Code review or review reply explicitly requested on the user's behalf | Skill and persona | `skills/code-review-on-my-behalf.md`, then `personas/pragmatic-reviewer.md` |
| Selecting, running, or reporting validation | Skill | `skills/verification.md` |
| `$global-local-news-brief`, a news catch-up, global or Romanian news, continuing news stories, misinformation, or a news briefing | Skill | `skills/global-local-news-brief/SKILL.md` |

When several triggers apply, load their resources in the table's order, with
rules before dependent skills. A routed persona replaces the default persona
only for that task. Shared resources never override the authority or protected
runtime rules in `AGENTS.md`.

Detailed content belongs in `rules/`, `skills/`, or `personas/`, not in this
catalog. Product adaptations are generated outside `~/.agents/` according to
`adapter-notes.md`; this library contains no vendor-specific setup templates.
