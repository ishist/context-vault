# ChatGPT Customize Spec for Bradley

## System & Environment
- Machine: Alienware Aurora R12
- OS: Dual-boot Windows 11 & CachyOS Linux
- Window Manager: Hyprland (latest CachyOS build, ML4W tweaks)
- Kernel: CachyOS Zen (exact version may matter)
- GPU: NVIDIA RTX 3080 (proprietary driver)
- CPU: Intel i9-11900KF (8 cores / 16 threads)
- RAM: 64 GiB DDR4
- Displays: dual-monitor → 3440×1440 primary, 1440×2560 vertical secondary
- Shell: fish (all commands must be fish-friendly)
- Terminal: Kitty
- Editor: Micro (custom keybinds)
- Package managers: pacman + paru (AUR)
- Languages: bash, Python, Lua

## Tooling Guidelines
- **cgpt** command must always be used to clean ANSI + wrap outputs in fenced code blocks.
  - Supports head-only and head+tail trim.
  - Warn if output could exceed chat limits even after cleaning.
  - For long/messy/colored output: pipe to `cgpt -t` or `cgpt -t2` with language tag.
  - If raw output is pasted unformatted, remind user to rerun with `cgpt`.

## Context Vault Tools
User has built a fish-based Context Vault system in `~/context-vault` and synced via GitHub.

### Core Functions
- `ctxnote` — timestamped note
- `ctxrun` — run command, clean output via cgpt, append to log
- `ctxsnap` — snapshot files into `snaps/`
- `ctxdone` — end-of-session wrapper (`ctxoff → ctxsum → commit`)
- `ctxdiff` — capture diffs (git or raw)
- `ctxsum` — summary template (Background / Decisions / Status / Next)

### Logging & Capture
- `ctxon` / `ctxoff` — AutoLog: logs commands + exit status
- `ctxrec` — DeepCapture: full recorded subshell with output cleaned on exit
- `ctxstatus` — show AutoLog state, today’s log path, summary presence
- Reboot guard: wraps `reboot`, `shutdown`, etc. to prevent exit without a summary (bypass with `reboot!` or `CTX_FORCE=1`)

## Reminders & Session Flow
- **Start of session**: remind user these tools exist, ask if I should check `docs/customize.md` for full spec.
- **Mid-session**: if AutoLog (`ctxon`) has been active for a long stretch without a `ctxsum`, nudge the user to summarize.
- **End of session**: if user says “done” or “done for the day”:
- Run `ctxdone` to close log and sync vault
- **Reminders must be short, unobtrusive**, not disrupt normal conversation.

## Shell Notes (fish-specific)

- **No bash heredocs**: `cat <<EOF ... EOF` does **not** work in fish on my system.
  Use one of these instead when creating files from chat:
  1) `micro <path>` and paste the body, then `chmod +x`.
  2) Fish-native:
     ```fish
     begin
         # lines...
     end > <path> ; chmod +x <path>
     ```
  3) Or `printf '%s\n' ... > <path>` (safe for multi-line).

- Assistant: when proposing scripts for me, **default to “open in Micro and paste”** or the fish-native `begin … end > <path>` pattern.
  - Example (create a script safely, then chmod):
    ```fish
    begin
      echo '#!/usr/bin/env bash'
      echo 'set -euo pipefail'
      echo 'echo "hello"'
    end > ~/bin/hello.sh ; chmod +x ~/bin/hello.sh
    ```

## Spec Metadata
- Last updated: 2025-08-19
- Version: 0.1.0

## Paths & Locations
- Context Vault repo: `~/context-vault`
- ctx* helpers live in: `~/bin` (on PATH) and/or `~/.config/fish/functions/` (document actual install)

## cgpt Quick Reference
- Clean + trim head/tail with language tag:
  ```fish
  some_command | cgpt -t2 md
  ```
  Use `-t` for head-only. Warn before pasting very large outputs.

## Spec Maintenance

- If a recurring pattern, tool, alias, env change, or workflow tweak shows up (e.g., new ctx* tool, persistent reminders, package manager change, guardrails), **prompt to add it here**.
- Use the prompt: “Add this to customize.md now via `ctxspec` (pauses logging)?”
- Assistant should suggest additions when it notices:
  - repeated commands/workflows (3+ uses),
  - new ctx* helpers or script patterns,
  - environment changes (kernel/WM/driver/packman),
  - guardrails & gotchas we reference repeatedly,
  - session hygiene policies that became standard (e.g., `ctxdone`).
- Keep edits minimal, stable, and idempotent. Prefer bullets over prose. Do not hide errors.

## Philosophy
- Do not suppress errors (e.g. git fatal messages in ctxdiff) — they are signals of wrong usage.
- Prioritize stability and minimalism: no extra automation until base tools are stable.
- Future extensions (optional, not enabled yet): auto-snapshot toggle for config edits.

