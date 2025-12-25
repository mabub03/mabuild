#!/usr/bin/env fish
# taken from https://gitlab.com/origami-linux/ as a base
# TODO: need to figure out what removing from here in previous commits caused -v-v-v-v-v-v-v-v to start showing up before prompts

# --- Environment guard -------------------------------------------------------
if set -q DISTROBOX_ENTER_PATH
    return
end

# Disable welcome message
set -g fish_greeting ""

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


# --- Modern replacements -----------------------------------------------------
alias vim nvim
alias update topgrade
alias docker podman
alias docker-compose podman-compose
alias cat bat
alias sudo 'sudo-rs '
alias su su-rs

# --- alias gnu commands to uutils --------------------------------------------
alias cp uu_cp
alias echo uu_echo
alias mkdir uu_mkdir
alias more uu_more
alias mv uu_mv
alias rm uu_rm
alias rmdir uu_rmdir
alias ln uu_ln
alias ls uu_ls
alias tee uu_tee
alias touch uu_touch
alias tail uu_tail
alias more uu_more
alias unlink uu_unlink
alias wc uu_wc

# --- experimental alias ------------------------------------------------------
alias ps procs
alias du dust
alias grep rg
alias find fd

# --- Directory listings via eza ----------------------------------------------
alias la 'eza -la --icons'
alias lt 'eza --tree --level=2 --icons'
function ls
    command eza --icons $argv
end
function ll
    command eza -l --icons $argv
end

# --- Cleanup -----------------------------------------------------------------
# functions -e grep find tmux ls ll nano git ps du


# function _should_nag
#     # Only "nag" in a real, interactive terminal run of the command
#     #
#     # - status is-interactive: we're in an interactive shell
#     # - test -t 1: stdout is a TTY (completions run the command with
#     #   stdout/stderr redirected to pipes, so this will be false there)
#     # - skip when user explicitly asks for --help
#     if status is-interactive
#         if test -t 1
#             if not string match -q -- --help $argv
#                 return 0 # True
#             end
#         end
#     end
#     return 1 # False
# end

# function _nag_and_exec
#     set tip "$argv[1]"
#     set -e argv[1]
#     set target "$argv[1]"
#     set -e argv[1]
#     if _should_nag
#         printf '%s\n' "$tip" >&2
#     end
#     # Expand $argv as separate arguments (don't quote) so the target command receives them correctly
#     command "$target" $argv
# end



# --- Friendly migration nags -------------------------------------------------
# function _find_nag
#     _nag_and_exec '🧭 Tip: Try using "fd" next time for a simpler and faster search.' find $argv
# end
# alias find _find_nag

# function _grep_nag
#     _nag_and_exec '🔍 Tip: Try using "rg" for a simpler and faster search.' grep $argv
# end
# alias grep _grep_nag

# function _git_nag
#     _nag_and_exec '🐙 Tip: Try "lazygit" for a slick TUI when working with git.' git $argv
# end
# alias git _git_nag

# function _ps_nag
#     _nag_and_exec '🧾 Tip: "procs" offers a richer, colorful process viewer than ps.' ps $argv
# end
# alias ps _ps_nag

# function _du_nag
#     _nag_and_exec '🌬️ Tip: "dust" makes disk usage checks faster and easier than du.' du $argv
# end
# alias du _du_nag

# --- Interactive tooling -----------------------------------------------------
fzf --fish | source
zoxide init fish | source
starship init fish | source
