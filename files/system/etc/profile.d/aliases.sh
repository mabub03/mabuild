#!/usr/bin/env bash
# yoinked from https://gitlab.com/origami-linux/

# --- Environment guard -------------------------------------------------------
if [ -n "$DISTROBOX_ENTER_PATH" ]; then
    return
fi

# --- Cleanup -----------------------------------------------------------------
# Initial cleanup (good practice, but we will strictly unalias below too)
# # (TODO: look at which of these I need to remove as most of these are nags which I removed)
#unset -f grep find tmux ls ll nano git ps du 2>/dev/null
unalias ls 2>/dev/null
unalias ll 2>/dev/null

# --- Helper utilities --------------------------------------------------------
_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

_eval_if_available() {
    local binary="$1"
    shift
    if _command_exists "$binary"; then
        eval "$("$binary" "$@")"
    fi
}

# --- Modern replacements -----------------------------------------------------
alias vim='nvim'
alias update='topgrade'
alias docker='podman'
alias docker-compose='podman-compose'
alias cat='bat'
alias sudo='sudo-rs '
alias su='su-rs'

# --- Directory listings via eza ----------------------------------------------
alias la='eza -la --icons=auto'
alias lt='eza --tree --level=2 --icons=auto'
alias ls='eza --icons=auto'
alias ll='eza -l --icons=auto'
#ls() { command eza --icons "$@"; }
#ll() { command eza -l --icons "$@"; }

# --- uutils-coreutils shims --------------------------------------------------
_register_uutils_aliases() {
    local uu_bin base_cmd std_cmd
    for uu_bin in /usr/bin/uu_*; do
        [ -e "$uu_bin" ] || continue
        base_cmd=$(basename "$uu_bin")
        std_cmd="${base_cmd#uu_}"
        case "$std_cmd" in
        ls | cat | '[' | test) continue ;;
        esac
        alias "$std_cmd"="$base_cmd"
    done
}
_register_uutils_aliases

# --- Interactive tooling -----------------------------------------------------
_eval_if_available fzf --bash
_eval_if_available zoxide init bash --cmd cd
export PS1="\[\e[32m\]\u@\h \[\e[34m\]\w \$ \[\e[0m\]"
