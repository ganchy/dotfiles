source /usr/share/cachyos-fish-config/cachyos-config.fish

# nnn contexts use pywal16's bright ANSI bank:
# color12, color13, color14, color9
# Falls back to 4,5,6,1 on an 8-color terminal.
set -gx NNN_COLORS '#0c0d0e09;4561'
set -gx NNN_FCOLORS '050605020706060801010203'

if test -f ~/.cache/wal/colors.fish
    source ~/.cache/wal/colors.fish
end

# Reload pywal syntax colors in already-running Fish shells.
function __reload_pywal_colors --on-signal WINCH
    if test -f ~/.cache/wal/colors.fish
        source ~/.cache/wal/colors.fish
    end

    # Redraw any command currently being typed.
    commandline -f repaint 2>/dev/null
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
