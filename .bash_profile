echo "Running .bash_profile"

. "$HOME/.uenv"

[[ $- == "*i*" ]] && . "$HOME/.uprofile"
