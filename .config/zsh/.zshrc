bindkey -e

# Editor, gets conditionally overwritten if neovim is present and not in ssh
export EDITOR="vim"

# Aliases

# Completion
source "$ZDOTDIR/zconditionals"

autoload -Uz compinit
compinit

source "$ZDOTDIR/zprompt"

task
