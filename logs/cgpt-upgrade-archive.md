# cgpt-upgrade-archive

## Background

- Alienware Aurora R12 — dual-boot Windows 11 & CachyOS Linux (Hyprland).
- CPU: Intel i9-11900KF (8 cores, 16 threads).
- GPU: NVIDIA RTX 3080 (proprietary driver).
- RAM: 64 GiB DDR4.
- Displays: dual-monitor, 3440×1440 (primary) + 1440×2560 (secondary, vertical).
- Kernel: CachyOS Zen kernel (exact version tracked if needed).
- Hyprland: latest CachyOS package build.
- Shell: fish (commands must be fish-friendly).
- Terminal: Kitty.
- Editor: Micro (with custom keybinds).
- Package managers: pacman + paru (AUR).
- Languages: bash, Python, Lua.

### Preferred Tools

- `cgpt` command for cleaning ANSI and adding fenced code blocks.
- Now upgraded with:
  - Head-only trim mode (`-t` or `--trim[=N]`).
  - Head+tail trim mode (`-t2` or `--headtail=H:T`).
  - Big-output warning on stderr (default threshold 50,000 lines).

- For long/messy/colored output, pipe to `cgpt` (suggest `-t` or `-t2` if safe) and include a language tag for readability.
- If unformatted output is pasted, rerun with `cgpt`.
- Warn if output might exceed chat limits after cleaning.

---

## Decisions Made

- Replaced the original `clipgpt` script with an upgraded version supporting both head-only and head+tail trimming modes.
- Kept ANSI stripping, code fencing, and multi-clipboard support.
- Added stderr warnings for very large output.
- Added a tiny Fish wrapper `cgpt` to call `clipgpt` directly, for convenience.

---

## Current Status

- `clipgpt` now supports:
  - `-t` / `--trim[=N]`: Head-only trim (default 500 lines).
  - `-t2` / `--headtail[=H:T]`: Head+tail trim (default 300 head / 200 tail).
- Output clearly shows truncation markers inside the fenced block.
- Status messages report whether output was trimmed, head+tail’d, or copied in full.
- Warning is shown on stderr if output is huge (over 50k lines).

---

## Next Steps

- Integrate new workflow into daily debugging/log sharing.
- Use `-t2` when errors are likely near the end of logs (preferred for ChatGPT context).
- Optionally extend with auto-switch to `--headtail` when logs exceed threshold, instead of only warning.
- Test in real scenarios (journalctl, dmesg, pacman logs, build failures).

---

_Archive generated: 2025-08-16 21:56:09_
