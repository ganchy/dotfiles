source /usr/share/cachyos-fish-config/cachyos-config.fish

set -gx NNN_COLORS '4561'
set -gx NNN_FCOLORS '050605020706060801010203'

if test -f ~/.cache/wal/colors.fish
    source ~/.cache/wal/colors.fish
end

function nnn
    command nnn $argv

    # Re-apply the latest pywal colors after nnn exits
    if test -f ~/.cache/wal/colors.fish
        source ~/.cache/wal/colors.fish
    end

    if test -f ~/.cache/wal/colors-kitty.conf
        kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf 2>/dev/null
    end
end

# Automatically start Hyprland on TTY1 login
if status is-login
    if test (tty) = /dev/tty1
        exec start-hyprland
    end
end
