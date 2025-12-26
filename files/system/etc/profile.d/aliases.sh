#!/usr/bin/env bash
# taken from https://gitlab.com/origami-linux/ as a base

# --- Environment guard -------------------------------------------------------
if [ -n "$DISTROBOX_ENTER_PATH" ]; then
    return
fi

# --- Cleanup -----------------------------------------------------------------
# Initial cleanup (good practice, but we will strictly unalias below too)
# unset -f grep find tmux ls ll nano git ps du 2>/dev/null
# unalias ls 2>/dev/null
# unalias ll 2>/dev/null

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

# _should_nag() {
#     # 1. Don't nag during completion (COMP_LINE check)
#     # 2. Don't nag if stderr isn't a TTY
#     if [ ! -t 2 ] || [ -n "$COMP_LINE" ]; then
#         return 1
#     fi

#     # 3. Don't nag if the user is asking for --help
#     for arg in "$@"; do
#         if [ "$arg" = "--help" ]; then
#             return 1
#         fi
#     done

#     return 0
# }

# _nag_and_exec() {
#     local tip="$1"
#     shift
#     local target="$1"
#     shift

#     # Pass remaining arguments to _should_nag to check for flags
#     if _should_nag "$@"; then
#         printf '%s\n' "$tip" >&2
#     fi
#     command "$target" "$@"
# }

# --- Modern replacements -----------------------------------------------------
alias vim='nvim'
alias update='topgrade'
alias docker='podman'
alias docker-compose='podman-compose'
alias cat='bat'
alias sudo='sudo-rs '
alias su='su-rs'

# --- Directory listings via eza ----------------------------------------------
alias la='eza -la --icons'
alias lt='eza --tree --level=2 --icons'
ls() { command eza --icons "$@"; }
ll() { command eza -l --icons "$@"; }

# --- alias gnu commands to uutils --------------------------------------------
alias cp='uu_cp'
alias echo='uu_echo'
alias mkdir='uu_mkdir'
alias more='uu_more'
alias mv='uu_mv'
alias rm='uu_rm'
alias rmdir='uu_rmdir'
alias ln='uu_ln'
alias ls='uu_ls'
alias tee='uu_tee'
alias touch='uu_touch'
alias tail='uu_tail'
alias more='uu_more'
alias unlink='uu_unlink'
alias wc='uu_wc'

# --- alias gnu commands to uutils --------------------------------------------
alias cp='uu_cp'
alias echo='uu_echo'
alias mkdir='uu_mkdir'
alias more='uu_more'
alias mv='uu_mv'
alias rm='uu_rm'
alias rmdir='uu_rmdir'
alias ln='uu_ln'
alias ls='uu_ls'
alias tee='uu_tee'
alias touch='uu_touch'
alias tail='uu_tail'
alias more='uu_more'
alias unlink='uu_unlink'
alias wc='uu_wc'

# --- experimental alias --------------------------------------------
alias ps='procs'
alias du='dust'
alias grep='rg'
alias find='fd'
alias ujust='blujust'

# --- Friendly migration nags -------------------------------------------------
# We must unalias these first to prevent 'syntax error' if they are already
# aliased elsewhere (e.g. grep='grep --color').
# unalias tmux find grep nano git ps du 2>/dev/null

# tmux() {
#     _nag_and_exec '🌀 Tip: Try using "zellij or byobu" for a modern multiplexing experience.' tmux "$@"
# }

# find() {
#     _nag_and_exec '🧭 Tip: Try using "fd" next time for a simpler and faster search.' find "$@"
# }

# grep() {
#     _nag_and_exec '🔍 Tip: Try using "rg" for a simpler and faster search.' grep "$@"
# }

# nano() {
#     _nag_and_exec '📝 Tip: Give "micro" a try for a friendlier terminal editor.' nano "$@"
# }

# git() {
#     _nag_and_exec '🐙 Tip: Try "lazygit" for a slick TUI when working with git.' git "$@"
# }

# ps() {
#     _nag_and_exec '🧾 Tip: "procs" offers a richer, colorful process viewer than ps.' ps "$@"
# }

# du() {
#     _nag_and_exec '🌬️ Tip: "dust" makes disk usage checks faster and easier than du.' du "$@"
# }

# --- Interactive tooling -----------------------------------------------------
_eval_if_available fzf --bash
_eval_if_available starship init bash
_eval_if_available zoxide init bash --cmd cd
