# Context Dump — 2025-08-15

## Background
- Working on **Context Vault** tools to help carry knowledge between ChatGPT sessions.
- Implemented several `fish` functions: `ctxnote`, `ctxrun`, `ctxsnap`, `ctxdiff`, `ctxsum`.
- Added helper toggles (`ctxon/ctxoff`), `ctxstatus`, and a reboot guard to prevent losing context before running `ctxsum`.

## Key Events
- Spent several hours building and debugging functions; caught copy/paste and syntax errors in `ctxdiff` and `ctxsnap`.
- Confirmed logs/diffs/snaps are writing correctly to `~/context-vault/`.
- Discussed **auto-log toggle mode** (lite vs full snapshot). Not enabled yet; waiting until base tools stabilize.
- Added `customize.md` spec into repo, containing rules for ChatGPT reminders about using Context Vault.
- Fixed Git/GitHub authentication to use SSH. Verified push to `origin main`.

## Current Status
- Tools are usable but need more polish for automation.
- Repo is now pushing logs/diffs/snaps regularly.
- `customize.md` exists in `docs/` and will eventually replace Customize Box clutter.

## Open Questions / Next Steps
- Add an **alias** `ctxdone` that runs `ctxoff`, `ctxsum`, and pushes logs in one shot.
- Decide when/if to enable auto-snapshot hooks.
- Test reminders for session start/end to ensure they don’t get in the way.
- Verify ChatGPT can actually read `customize.md` from repo in connected sessions (current session couldn’t).
