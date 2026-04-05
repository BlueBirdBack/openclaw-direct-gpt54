# openclaw-terse-gpt54

Make GPT-5.4 in OpenClaw reply shorter, clearer, and less chatty.

If your agent rambles, repeats itself, or adds too much fluff, this repo gives you a simple way to tighten it.

What you get:
- a cleaner `SOUL.md`
- a better place for user preferences in `USER.md`
- a small reply checklist in `RESPONSE_PROTOCOL.md`
- a reusable skill you can install or adapt

What this is **not**:
- not a runtime guardrail
- not a plugin
- not a validator or linter
- not a magic one-line prompt

It works by improving the prompt files and the structure around them.

## Quick start

1. Back up your current files.
2. Use the templates in `templates/` to tighten `SOUL.md`, `USER.md`, and `RESPONSE_PROTOCOL.md`.
3. Start a fresh session and test a few real prompts.

## What to edit

- `SOUL.md` — identity, tone, response discipline
- `USER.md` — user-specific preferences
- `RESPONSE_PROTOCOL.md` — short reply checklist

## The basic idea

Most verbose GPT-5.4 setups have the same problem: they ask for concision in a vague way.

This repo fixes that by making the rules more concrete:
- answer first
- default short
- expand only when needed
- remove praise, recap, and prompt-echo
- stop when the answer is done

## Safe patching rules

- **Merge, don’t replace.**
- Keep stronger local safety, escalation, operational rules, and identity.
- Keep the target agent’s own name, self-description, and voice.
- Prefer small edits over whole-file rewrites.
- Keep backups so rollback is easy.
- Replace a whole file only if the user explicitly asks.

## What’s in this repo

- `templates/` — copyable examples for your local files
- `skills/openclaw-terse/` — source for the packaged skill
- `dist/openclaw-terse.skill` — packaged skill artifact

The packaged `.skill` includes only:
- `openclaw-terse/SKILL.md`
- `openclaw-terse/references/patch-patterns.md`

It does **not** include the `templates/` folder.

## Manual install

1. Back up `SOUL.md` and `USER.md`.
2. Patch your existing files using the examples in `templates/`.
3. Create or tighten `RESPONSE_PROTOCOL.md`.
4. Start a fresh session.
5. Test on 3 real prompts.
6. Tighten again if it still rambles.

## Packaging and verification

Requirements for the helper scripts:
- `zip`
- `sha256sum`

Build the packaged skill:

```bash
bash scripts/build-skill.sh
```

Verify that `dist/openclaw-terse.skill` matches source:

```bash
bash scripts/verify-skill.sh
```

The build script writes a SHA-256 checksum to `dist/openclaw-terse.skill.sha256`.
The verify script rebuilds the artifact in a temp directory and fails if it drifts from source.

## Compatibility

This assumes an OpenClaw workspace that uses `SOUL.md` and `USER.md`.
If your setup is different, adapt the patterns manually.

## Why this works

GPT-5.4 is strong, but it often over-explains.
You usually do not fix that with a single line like “be concise.”
You fix it with better structure.

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
- create or tighten `RESPONSE_PROTOCOL.md`
- add a prompt-side response checklist
- avoid bloating memory

## License

MIT
