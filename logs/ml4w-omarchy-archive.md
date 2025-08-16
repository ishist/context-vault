# ML4W + Omarchy Hybrid Project (Context Archive)

This file is a dump of all pertinent context from the long ChatGPT session (August 2025) where Bradley worked on merging features from **Omarchy Hyprland** into an existing **ML4W Hyprland** installation. It is designed to be committed into the `context-vault` repo so future sessions can pick up from here.

---

## System Setup
- **Machine:** Alienware Aurora R12 (dual boot Windows 11 + CachyOS Hyprland)
- **CPU/GPU:** i9-11900KF + NVIDIA RTX 3080 (proprietary driver)
- **RAM:** 64 GiB
- **Shell/Terminal:** Fish shell + Kitty terminal
- **Editor:** Micro (with custom keybinds)
- **Package Managers:** pacman + paru (AUR)
- **Preferred tools:** `cgpt` command for cleaning ANSI output

---

## Project Goal
Port desirable features from **Omarchy’s Hyprland setup** into an existing **ML4W stable Hyprland** system, without replacing the full setup. Themes were explicitly skipped.

---

## Omarchy Features Added
1. **Unified Update Script**
   - Created `ml4w-omarchy-update` in `~/.local/bin/`.
   - Function: wraps `paru`, `flatpak`, `fwupdmgr`, `paccache`, and journal vacuuming.
   - Scans for `.pacnew` files and warns to run `sudo -E pacdiff`.
   - Supports `--dry-run` and integrates logging in `~/.local/var/log/`.

2. **Waybar Integration**
   - Update button (`custom/updates`) tied to `ml4w-omarchy-update`.
   - On-click launches updates via `ml4w-omarchy-update-waybar`, showing desktop notifications.
   - Script echoes `{"text":"0"}` when no updates are available, ensuring the icon doesn’t disappear.

3. **Terminal & Tools**
   - Installed: `btop`, `lazygit`, `lazydocker`, `neovim`.
   - Attempted Omarchy’s LazyVim config (partial success, but Neovim troubleshooting postponed).
   - Kitty FZF overlay added (file finder with `Ctrl+Shift+F`), simplified to remove preview pane due to errors.

4. **Walker (rofi alternative)**
   - Installed and bound to hotkey in Hyprland.
   - Configured via `~/.config/walker/config.json` (pure JSON, no comments).
   - Systemd user service attempted, but `--service` flag unsupported — postponed until upstream updates.

---

## Current Status
- ✅ **Update system + Waybar button fully functional** (but needs polish — see “Open Issues”).
- ✅ **Kitty FZF overlay works (simple, no preview).**
- ✅ **Walker launches manually and via keybind.**
- ❌ **Walker systemd service not working (flag unsupported).**
- ❌ **Neovim/LazyVim setup incomplete (Mason errors).**

---

## Open Issues / Next Steps
1. **Waybar Updates Button**
   - Button sometimes disappears if no updates → script was modified to output `"0"`.
   - Needs retest to confirm consistent behavior.

2. **Neovim Setup**
   - Mason plugin errors → need to debug LazyVim config or reinstall plugins.

3. **Walker Service**
   - `--service` flag no longer valid; need updated approach for background daemon.

4. **Kitty FZF Overlay**
   - Currently stable without preview. If desired later, reintroduce preview incrementally.

---

## References
- `~/.local/bin/ml4w-omarchy-update`
- `~/.local/bin/ml4w-omarchy-update-waybar`
- `~/.config/waybar/modules.json`
- `~/.config/kitty/fzf-open.sh`
- `~/.config/walker/config.json`
