---
name: global-local-news-brief
description: Produce an evidence-based catch-up briefing of important global and Romanian news, tailored to the period the user has missed. Use when the user invokes $global-local-news-brief or asks to catch up on recent news, global headlines, Romanian news, ongoing stories, misinformation, or a news briefing. Read and update one compact shared ledger so Codex, ChatGPT, and other assistants can avoid duplicate briefings while reconnecting material ongoing stories.
---

# Global & Romania News Brief

Create a concise, contextual briefing from reliable current reporting. Cover global developments and Romania separately; explain cross-border effects when they matter. This is a catch-up, not a headline dump.

## Shared ledger

Use one canonical shared ledger, never a provider-local fallback. The default is `news/brief-ledger.json` in a private GitHub repository named `ai-agent-state`; accept a different private, versioned JSON store only when the user explicitly supplies it. Each assistant must be connected to the same repository/account with read and write access.

Keep only a per-environment repository locator, never a local copy of the ledger. In Codex, store it at `%USERPROFILE%\.codex\state\global-local-news-brief\repository.json`; on other assistants use their smallest durable private configuration surface. Its shape is:

```json
{"repo_path":"C:\\path\\to\\ai-agent-state","ledger_path":"news/brief-ledger.json"}
```

If this locator does not exist in the current machine or environment, ask: “Where can I access your `ai-agent-state` repository in this environment? Give me a local clone path or the private repository URL.” Save the answer only after confirming it resolves to the intended repository. If the current assistant cannot read and write that exact shared file through an available connector, say so and do not create a separate local ledger. Never put credentials, tokens, personal data, or full article text in the ledger.

Use this compact JSON shape. Omit empty fields. Keep `summary` under 280 characters and URLs only when they will help refetch a continuing story.

```json
{
  "v": 1,
  "updated_at": "2026-08-03T12:00:00Z",
  "last_success_utc": "2026-08-03T12:00:00Z",
  "topics": [
    {"id": "ro-danube-energy-2026-07", "first": "2026-07-28", "seen": "2026-08-03", "briefed": "2026-08-03", "status": "active", "title": "Low Danube disrupts Cernavodă output", "summary": "Drought cut cooling water; one unit stopped and energy measures followed.", "urls": ["https://example.org/report"]}
  ],
  "claims": [
    {"id": "ro-bystroe-causation-2026-08", "seen": "2026-08-03", "verdict": "false", "claim": "Bîstroe Canal caused the low Danube and Cernavodă shutdown.", "url": "https://example.org/fact-check"}
  ]
}
```

On each successful update, remove topics and claims with `seen` older than 14 calendar days; retain up to 18 topics and 12 claims, removing oldest inactive entries first. Do not write the ledger if research or sourcing is materially incomplete.

Use the storage provider's revision, SHA, ETag, or equivalent optimistic-concurrency control. Immediately before writing, reread the ledger. If it changed, merge by topic/claim `id`, preserve the newest timestamps, apply pruning, and retry once. Do not overwrite a newer version blindly.

## Git synchronization

When the locator is a local Git clone, synchronize the shared ledger automatically after every successful update:

1. Verify the configured directory is a Git worktree and that `news/brief-ledger.json` is the configured target. Do not mark an untrusted or unrelated directory as safe automatically; explain the issue and ask the user to approve the Git trust configuration.
2. Fetch the remote and fast-forward the checked-out shared branch before reading the ledger. Do not reset, discard, stash, or stage unrelated changes. If fast-forwarding is unsafe or fails, report the conflict and leave the worktree unchanged.
3. Research and write the ledger as described above. Stage **only** the ledger file. If it did not change, do not create an empty commit or push.
4. Commit and push automatically. Use a concise subject and a structured body:

```text
news-brief: <agent>/<model> — <reason>

agent: <assistant product or agent name>
model: <runtime model label, or unavailable>
reason: <e.g. daily catch-up through 2026-08-04>
changes: updated news/brief-ledger.json; topics +2/~1; claims +1; pruned 0
```

Use only runtime-provided agent/model identifiers; never invent them. State the actual topic/claim/prune counts in `changes`. Do not include source URLs, private user data, or full news text in the commit message.
5. If the push is rejected because the remote advanced, fetch, re-read the shared ledger, merge by ID and newest timestamp, amend or create a corrected ledger-only commit, and retry once. If it still fails, report the conflict; do not force-push.

When the locator is a repository URL rather than a local clone, use its connected provider API with equivalent revision-safe update semantics. If automatic commit/push is unavailable in that environment, report that limitation before producing a briefing that would leave shared state stale.

## Research workflow

1. Read the shared ledger, creating it only after a successful first briefing. Set `now` in the user's local time.
2. Set the primary time window:
   - No usable ledger: the previous 14 calendar days, inclusive.
   - Otherwise: from the day after `last_success_utc` through `now`, with a one-day overlap for corrections. Never search more than 14 days back unless a new development requires a short recap of a ledger topic.
   - If no material verified developments occurred, say so plainly rather than padding the briefing.
3. Search broadly first, then verify each candidate with primary sources or high-quality reporting. Prioritize reputable wire services, public authorities, international organizations, and established Romanian outlets. Use at least two independent sources for consequential or contested claims where feasible. Date-stamp reporting and distinguish an event from a statement, plan, allegation, or forecast.
4. Select for consequence, novelty, durability, and user relevance. Avoid celebrity, routine crime, sports, and political rhetoric unless they materially affect public life, security, the economy, or an ongoing major story.
5. Compare each candidate against `topics` and `claims`:
   - New, material story: include it and create/update a topic.
   - Development of a ledger topic: refetch that topic from the stored URLs and current reliable sources. Brief the new development first, then give a 1–3 sentence “why this matters / the story so far” recap.
   - Previously briefed but still consequential: re-mention only if there is a material change, a concrete consequence, or necessary context for a new related event.
   - Merely similar or speculative: do not force a connection.
6. Fact-check separately. List only claims that a credible fact-checker or authoritative institution has specifically debunked or clearly contradicted. Mark unverified reports as unverified—not “fake.” For each item state the claim, verdict, basis, and source.
7. Before replying, update the shared ledger only after the briefing is complete. Set `updated_at` and `last_success_utc` to the time research finished, refresh `seen`/`briefed`, merge duplicates, prune it, and use conflict-safe write semantics.

## Output

Lead with the time period covered and a one-sentence assessment of the main pattern, if one exists. Use these sections only when they contain material items:

1. **Global** — 3–7 items.
2. **Romania** — 3–7 items.
3. **Continuing stories** — only when context from a past briefing materially improves understanding. State what changed, then compactly connect it to the earlier story.
4. **False or misleading claims** — only confirmed debunks in the covered window; separate global and Romania when both exist.

For every substantive item, give a succinct explanation of what happened, why it matters, and a direct Markdown source link. Attribute uncertainty precisely. Do not claim completeness: call it a curated briefing of the important, verified developments.

## Quality bar

- Correct causal mistakes. A real event and a false explanation for it are separate items; report both when relevant.
- Do not amplify a false claim in the headline without immediately labelling it false.
- Prefer developments over commentary. Treat official claims as claims until independently established when appropriate.
- Preserve the distinction between Romania and its neighbours; include regional context where it affects Romania.
- Keep background proportional: enough for the user to grasp the causal chain, no repeated history.
