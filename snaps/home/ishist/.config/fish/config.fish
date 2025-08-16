# ~/.config/fish/config.fish

# Load CachyOS defaults (if present)
if test -r /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# Keep ~/.local/bin on PATH early (idempotent)
if not contains -- $HOME/.local/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
end

# Optional: quiet the default greeting / fastfetch example
# function fish_greeting
# end

# Your shortcuts
alias chat="$HOME/scripts/chat"

# --- envdump: paste-ready system summary (pipes to clipgpt) ---
function envdump
    # Hyprland version: hyprctl tag → pacman version → N/A
    set hypr_tag "N/A"
    if type -q hyprctl
        set hypr_tag (hyprctl version 2>/dev/null | sed -n 's/.*tag:[[:space:]]*\([^ ]*\).*/\1/p' | head -n1)
    end
    if test -z "$hypr_tag"
        if type -q pacman
            set hypr_tag (pacman -Q hyprland 2>/dev/null | awk '{print $2}')
        end
    end
    if test -z "$hypr_tag"; set hypr_tag N/A; end

    # NVIDIA package detection: nvidia | nvidia-open | nvidia-dkms → name + version
    set nvidia_pkg "N/A"
    if type -q pacman
        for p in nvidia nvidia-open nvidia-dkms
            if pacman -Q $p >/dev/null 2>&1
                set nvidia_pkg "$p "(pacman -Q $p 2>/dev/null | awk '{print $2}')
                break
            end
        end
    end

    # NVIDIA kernel module version (if loaded)
    set nvidia_mod "N/A"
    if type -q lsmod; and type -q modinfo
        if lsmod | grep -q '^nvidia'
            set nvidia_mod (modinfo -F version nvidia 2>/dev/null)
        end
    end

    # nvidia-utils version (if installed)
    set nvidia_utils "N/A"
    if type -q pacman
        set nvidia_utils (pacman -Q nvidia-utils 2>/dev/null | awk '{print $2}')
        if test -z "$nvidia_utils"; set nvidia_utils N/A; end
    end

    # Emit and copy (clipgpt adds ```ini fences & copies to both clipboards)
    begin
        printf "Kernel:      %s\n" (uname -r)
        echo   "Distro:      CachyOS (Hyprland)"
        printf "Hyprland:    %s\n" $hypr_tag
        printf "NVIDIA mod:  %s\n" $nvidia_mod
        printf "nvidia pkg:  %s\n" $nvidia_pkg
        printf "nvidia-utils:%s\n" $nvidia_utils
        echo   "CPU:         Intel i9-11900KF"
        echo   "RAM:         64 GiB DDR4"
        echo   "Shell:       fish"
        echo   "Terminal:    Kitty"
        echo   "Package mgr: pacman + paru"
    end | ~/.local/bin/clipgpt ini
end
