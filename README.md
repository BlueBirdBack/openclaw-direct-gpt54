# openclaw-terse-gpt54

Make `openai-codex/gpt-5.4` in OpenClaw reply with less fluff.

This is **not** one magic prompt.
It is a small stack:

1. tighten `SOUL.md`
2. move user-specific prefs into `USER.md`
3. add a hard `RESPONSE_PROTOCOL.md`
4. add a pre-send **Response Gate**
5. keep memory lean enough to trust

## What worked

### 1) Make brevity explicit

Do not say "be concise" once and hope.
Say:

- **Default short. Depth only on request.**
- **Answer first.**
- **No fluff, praise, recap, or prompt-echo.**
- **Stop once the job is done.**

### 2) Separate identity from preferences

Keep the soul clean.

- `SOUL.md` = identity, style, response discipline
- `USER.md` = user-specific working preferences
- `RESPONSE_PROTOCOL.md` = hard reply checklist

### 3) Add a hard response gate

Before every reply, force this check:

- Is the answer in the first line?
- Can this be 1 short paragraph or 3–5 bullets?
- Did I remove praise, recap, prompt-echo, and filler?
- Did I cut at least one non-essential sentence?
- Once the job is done, did I stop?

### 4) Patch behavior, not adjectives

"Be concise" is weak.

These are stronger:

- answer first
- default short
- depth only on request
- no repeated point in new wording
- silence beats padding

### 5) Start a fresh session after patching

A fresh `/new` helps because the updated files become the clean baseline from turn one.

## Files to edit in OpenClaw

- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md` *(new)*
- optional: `MEMORY.md` / daily memory if you want to record the preference permanently

## Included in this repo

- `templates/` — generic file templates
- `skills/openclaw-terse/` — reusable skill for tightening verbose OpenClaw agents

## Install the idea manually

1. back up `SOUL.md` and `USER.md`
2. apply the patterns from `templates/`
3. create `RESPONSE_PROTOCOL.md`
4. start a fresh session
5. test on 3 real prompts
6. tighten again if it still rambles

## Why this works

GPT-5.4 is capable, but it likes to elaborate.
You do not fix that with vibes.
You fix it with **structure**.

## Skill

The bundled skill is for requests like:

- "make this OpenClaw agent less verbose"
- "tighten the soul"
- "GPT-5.4 is too chatty"
- "make replies short and direct"

It tells the agent to:

- back up current files
- harden `SOUL.md`
- keep user preferences in `USER.md`
- create `RESPONSE_PROTOCOL.md`
- add a response gate
- avoid bloating memory

## License

MIT
