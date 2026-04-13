# openclaw-direct-gpt54

[中文说明](./README.zh.md)

Make GPT-5.4 in OpenClaw reply shorter, clearer, and more direct.

## For OpenClaw

Use this prompt:

> Install and apply the latest version of this skill from https://github.com/BlueBirdBack/openclaw-direct-gpt54. Back up my current `SOUL.md` and `USER.md` first. Merge changes; do not replace my identity, safety, or operational rules.

This skill works by tightening:
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

It is prompt-file guidance, not a plugin or runtime guardrail.
If GPT-5.4 still leaks "If you want, I can..." after this, you may also need a separate runtime fix.

## Update this skill

Use the same prompt again:

> Install and apply the latest version of this skill from https://github.com/BlueBirdBack/openclaw-direct-gpt54. Back up my current `SOUL.md` and `USER.md` first. Merge changes; do not replace my identity, safety, or operational rules.

## Rules that matter

- answer first
- default short
- expand only when needed
- remove praise, recap, and prompt-echo
- never ask permission for directly implied low-risk internal bookkeeping after the main task; do it, then report it
- if you created a durable artifact that obviously belongs in an index or tracker, update that index or tracker before replying
- ask only for destructive, external/public, or genuinely ambiguous follow-up
- stop when the answer is done

## Concrete behavior target

Bad:

> Created `docs/project-x.md`. If you want, I can add it to `Projects.md`.

Good:

> Created `docs/project-x.md` and linked it in `Projects.md`.

## Patch safely

- merge, don’t replace
- keep stronger local safety and operational rules
- keep the target agent’s own name, identity, and voice
- keep backups so rollback is easy

## License

MIT
