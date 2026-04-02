---
name: xai-grok
description: "Freshness-first intel: Grok /v1/responses with real-time X/Twitter search (x_search) + web_search (faster-than-web)."
license: MIT
metadata: {"openclaw": {"emoji": "🛰️", "requires": {"bins": ["bash", "curl", "jq"], "env": ["XAI_API_KEY"]}, "primaryEnv": "XAI_API_KEY"}}
---

# xAI Grok API (Inference) — Responses + X Search

Use this skill when you want to query **xAI Grok** directly, especially when you need:
- **Real-time X/Twitter search** via `x_search`
- **Fast-moving best practices / breaking changes** (often hit X before web indexes)
- **Real-time web search** via `web_search`

Treat X results as **leads** → confirm “truth” in **official docs / code-as-spec** before shipping changes.

## Install

```bash
git clone git@github.com:rblakemesser/portable-skills.git && cd portable-skills && make install SKILL=xai-grok
```

This skill is **curl-first** (via `exec`) so it works without modifying the host runtime.

## SSOT (official docs)

- Inference (Responses/Chat endpoints): https://docs.x.ai/developers/rest-api-reference/inference/chat
- X Search tool (`x_search`): https://docs.x.ai/developers/tools/x-search
- Web Search tool (`web_search`): https://docs.x.ai/developers/tools/web-search
- List available models (Inference): https://docs.x.ai/developers/rest-api-reference/inference/models

## Setup / requirements

- Requires env var: `XAI_API_KEY`
- Base URL (conceptual): `https://api.x.ai/v1`

Fail-loud behavior:
- If `XAI_API_KEY` is missing, stop and say exactly: **“Missing XAI_API_KEY (xAI Grok).”**

## Execution pattern

Use normal URLs and keep the shell shape boring:

- Write JSON payloads to a file and POST them with `--data-binary @file`.
- Quote the exact error if `curl`, `jq`, or the API call fails.
- Use the simplest command that works; do not contort commands around old allowlist-era limitations.

## Core patterns

### 1) Sanity-check auth + model entitlement

List models (also confirms the key works):

```bash
bash -lc 'curl https://api.x.ai/v1/models -H "Authorization: Bearer $XAI_API_KEY"' | jq .
```

If xAI returns a “no credits/licenses” error, your key is valid but the team/account needs credits.

### 2) Plain response (no tools)

Step A — write payload (example file: `artifacts/xai_payload.json`):

```json
{
  "model": "grok-4-1-fast-reasoning",
  "input": [
    {"role": "user", "content": "Summarize the latest about xAI in 5 bullets."}
  ]
}
```

Step B — call Responses:

```bash
bash -lc 'curl https://api.x.ai/v1/responses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $XAI_API_KEY" \
  --data-binary @artifacts/xai_payload.json'
```

### 3) X/Twitter real-time search (`x_search`)

Use when you need what people are saying on X right now.

Payload (`artifacts/xai_xsearch.json`):

```json
{
  "model": "grok-4-1-fast-reasoning",
  "input": [
    {"role": "user", "content": "What are people saying about product X this week. Give 8 bullets and cite sources."}
  ],
  "tools": [
    {"type": "x_search"}
  ]
}
```

Call:

```bash
bash -lc 'curl https://api.x.ai/v1/responses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $XAI_API_KEY" \
  --data-binary @artifacts/xai_xsearch.json'
```

### 4) Web search (`web_search`)

Payload (`artifacts/xai_websearch.json`):

```json
{
  "model": "grok-4-1-fast-reasoning",
  "input": [
    {"role": "user", "content": "What changed in the latest iOS App Store review guidelines. Cite sources."}
  ],
  "tools": [
    {"type": "web_search"}
  ]
}
```

Call:

```bash
bash -lc 'curl https://api.x.ai/v1/responses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $XAI_API_KEY" \
  --data-binary @artifacts/xai_websearch.json'
```

## Output expectations (definition of done)

When you use Grok with search tools:

- Return a clean answer (bullets / short narrative)
- Include citations / sources when present

xAI returns URL citations as annotations on `output_text` items.

Extraction patterns:

Extract assistant text (JSON strings):

```bash
bash -lc 'curl https://api.x.ai/v1/responses -H "Content-Type: application/json" -H "Authorization: Bearer $XAI_API_KEY" --data-binary @artifacts/xai_xsearch.json' \
| jq '.. | objects | select(.type=="output_text") | .text'
```

Extract citation URLs (JSON strings), deduped:

```bash
bash -lc 'curl https://api.x.ai/v1/responses -H "Content-Type: application/json" -H "Authorization: Bearer $XAI_API_KEY" --data-binary @artifacts/xai_xsearch.json' \
| jq '.. | objects | select(.type=="url_citation") | .url' \
| sort | uniq
```

## Safety / secrets

- Never print or paste `XAI_API_KEY` into chat.
- Do not write the key into tracked files.
- Prefer storing it in your shell profile, a local env file, or a secret manager, then restart the relevant process if needed.

## Examples

### Good

- “Use Grok with `x_search` to find what’s trending about keyword K today; summarize themes; include citations.”
- “Find the latest best-practice chatter (X posts) about a config/security topic; summarize + link the posts; then verify via official docs before acting.”

### Bad

- “Here’s my API key: …”
- “Let’s scrape X without citations and claim it’s real-time.”
- “Use X posts as the authoritative source for what to ship/configure (no docs/code verification).”

## Common failures & fixes

- xAI error about credits/licenses
  - The key is valid, but the team/account needs credits/licenses in the xAI console.
