# GitHub Copilot

Add the following to a personal Copilot instruction file, such as
`~/.copilot/copilot-instructions.md` for Copilot CLI or a user-profile
`*.instructions.md` file for VS Code:

```markdown
Use `~/.agents/global.md` as global instructions. Resolve its referenced paths
from `~/.agents`. Always apply `global.md`; when its routing table matches the
current task, read and apply the named resource before acting.
```
