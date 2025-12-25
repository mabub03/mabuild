#!/usr/bin/env fish
# yoinked from https://gitlab.com/origami-linux/
# --- Environment guard -------------------------------------------------------
if set -q DISTROBOX_ENTER_PATH
    return
end

# --- Modern replacements -----------------------------------------------------
alias vim nvim
alias docker podman
alias docker-compose podman-compose
alias cat bat
alias sudo 'sudo-rs '
alias su su-rs

# --- Directory listings via eza ----------------------------------------------
alias la 'eza -la --icons'
alias lt 'eza --tree --level=2 --icons'
function ls
    command eza --icons $argv
end
function ll
    command eza -l --icons $argv
end

# --- Interactive tooling -----------------------------------------------------
fzf --fish | source
zoxide init fish | source
starship init fish | source

# --- Cleanup (remove the old commands that aren't needed) -----------------------------------------------------------------
# (TODO: look at which of these I need to remove as most of these are nags which I removed)
# functions -e grep find tmux ls ll nano git ps du

# --- Helper utilities --------------------------------------------------------
function _command_exists
    command -v "$argv[1]" >/dev/null 2>&1
end

function _eval_if_available
    set binary "$argv[1]"
    set -e argv[1]
    if _command_exists "$binary"
        set -l output ("$binary" "$argv" 2>&1)
        if test $status -eq 0
            eval $output
        end
    end
end

# --- uutils-coreutils shims --------------------------------------------------
function _register_uutils_aliases
    for uu_bin in /usr/bin/uu_*
        if test -e "$uu_bin"
            set base_cmd (basename "$uu_bin")
            set std_cmd (string replace -r '^uu_' '' "$base_cmd")
            switch "$std_cmd"
                case ls cat '[' test
                    continue
            end
            alias "$std_cmd" "$base_cmd"
        end
    end
end
_register_uutils_aliases
