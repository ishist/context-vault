# Context Dump — 2025-08-21 (Repo)

## Background
- Goal: Make `customize.md` and `file-index.md` always accessible to ChatGPT instances.
- Problem: Raw GitHub URLs were sometimes unreliable / not auto-fetchable.
- Solution: Switch to jsDelivr CDN URLs for reliable static access.

## Key Events (what changed / where)
- Confirmed ChatGPT can’t fetch repo links automatically; requires explicit pasted URLs.
- Introduced plan to preload session context with URLs via clipboard paste.
- Decided against “auto-fetch” (security limitation) — instead, user pastes when asked.
- Created `ctxload` fish function to copy preload block into clipboard/primary selection.
  - Uses `wl-clipboard` (`wl-copy` / `wl-copy -p`).
  - Fixed grouping syntax (`begin; …; end`).
  - Extended to write to both clipboard (Ctrl-V) and primary selection (middle-click).

## Current Status
- `ctxload` is working: confirmed paste buffer outputs correct three-line block.
- Workflow established:
  1. Run `ctxload` in terminal.
  2. Paste block into “Anything else” box here.
  3. Confirm with “yes” when asked, which triggers fetch of `customize.md` and `file-index.md`.

## Open Questions / Next Steps
- Consider whether to add versioning or a checksum in `ctxload` output (detect stale docs).
- Possibly add a `--stable` flag to only copy to clipboard if middle-click isn’t needed.
- Add this workflow to `docs/customize.md` for future onboarding.
- Decide if log indexing (`generate-logs-index`) should also be piped into this preload workflow.

_created: 2025-08-21 20:15 _
