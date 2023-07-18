# https://wiki.archlinux.org/title/fish

set -U fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    #starship init fish | source

    if type -q zoxide
        zoxide init fish | source
    end

    [ -z "$SSH_AUTH_SOCK" ] && set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

if type -q delta
    set -g GIT_PAGER delta
end

#
# Editor
#
alias vim=nvim
alias vi=nvim

set -x LESS -RFXi
set -x USE_CCACHE 1
set -x XZ_OPT "--threads 0"
set -x S_COLORS auto

set -x CCACHE_DIR "$HOME/.cache/ccache"
set -x MAKEFLAGS -j(nproc)

fish_add_path -gm \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $HOME/bin \
