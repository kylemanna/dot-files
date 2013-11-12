# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

# End of lines added by compinstall

autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
#prompt walters
prompt adam2

if [ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

autoload -U colors && colors

zstyle ':completion:*' menu select
setopt completealiases

alias ls='ls --color'

if [ -f "$HOME/.shell_env.sh" ]; then
	source $HOME/.shell_env.sh
fi
