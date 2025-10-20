bindkey -e


# Editor, gets conditionally overwritten if neovim is present and not in ssh
export EDITOR="vim"

# Aliases
alias ".."="cd .."
alias "..."="cd ../.."
alias "3.."="cd ../../.."

alias "proj"="cd $HOME/projects"

autoload -Uz compinit
compinit

source "$ZDOTDIR/zconditionals"
source "$ZDOTDIR/zprompt"

task
