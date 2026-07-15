# Codex

Add the following to the user-global `~/.codex/AGENTS.md`:

```markdown
Use `~/.agents/global.md` as global instructions. Resolve its referenced paths
from `~/.agents`. Always apply `global.md`; when its routing table matches the
current task, read and apply the named resource before acting.
```
