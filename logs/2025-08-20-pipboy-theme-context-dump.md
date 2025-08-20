# 2025-08-20-pipboy-theme-context-dump

## Background
- Goal: test out a Pip-Boy style theme in Kitty terminal.
- Started with custom colors and prompt tweaks. Green text legibility was poor, but user preferred the `[VAULT-TEC]` prompt shade for general text.
- Attempted to wire the theme into Kitty via `include themes/Pip-Boy.conf` and `kitten themes`.
- Encountered issues with Kitty remote control and ML4W overrides.

## Decisions
- Used `kitten themes` to assign Pip-Boy as default dark theme, Desert Night as default light theme.
- Determined Kitty tracks light/dark defaults with:
  - `~/.config/kitty/dark-theme.auto.conf`
  - `~/.config/kitty/light-theme.auto.conf`
  - plus `current-theme.conf`.
- Verified that Kitty follows system light/dark mode flips (via `gsettings set org.gnome.desktop.interface color-scheme …`) because ML4W links Kitty to GTK mode.

## Status
- Pip-Boy theme is active when dark mode is set.
- Desert Night active when dark mode is reset to default.
- Hyprland hotkey attempt (`SUPER+CTRL+Y`) to flip modes didn’t work; bind not loading or collision suspected.
- Discovered `themeswitcher.sh` isn’t the light/dark toggle — it’s just a Waybar theme selector.
- Confirmed that flipping `gsettings` manually does switch Kitty along with other apps.

## Next
- Later: decide if you want a fish alias/script to flip between light/dark by rewriting `dark-theme.auto.conf` and `light-theme.auto.conf`.
- Debug Hypr keybinds: confirm bind is loaded with `hyprctl binds` before reattempting.
- Optional: symlink `current-theme.conf` to either auto file for instant manual overrides.
