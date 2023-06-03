# https://wiki.archlinux.org/title/fish

set -U fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    #starship init fish | source
    zoxide init fish | source

    [ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
end


#
# Editor
#
alias vim=nvim
alias vi=nvim
export EDITOR=nvim

export LESS=-RFXi
export USE_CCACHE=1
export CCACHE_DIR=$HOME/.cache/ccache
export XZ_OPT="--threads=0"
export S_COLORS=auto

fish_add_path -m $HOME/.cargo/bin
fish_add_path -m $HOME/.local/bin
fish_add_path -m $HOME/bin
