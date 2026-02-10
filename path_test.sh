#!/usr/bin/env bash

export PATH=""

eval "$(/usr/libexec/path_helper -s)"

OLD_PATH="$PATH"

function pretty_path() {
    VALUE="$1"
    printf '%s\n\n' "$(echo "$VALUE" | tr ':' '\n')"
}

function print_section_header() {
    SECTION="$1"

    WIDTH=40
    CHAR='='
    SEPARATOR=$(printf '%*s' "$WIDTH" ' ')
    SEPARATOR=${SEPARATOR// /$CHAR}
    printf "%s\n" "$SEPARATOR"
    printf "%*s\n" $(((${#SECTION}+$WIDTH)/2)) "$SECTION"
    printf "%s\n" "$SEPARATOR"
}

. "$HOME/.uenv"

TMP_PATH="$PATH"

export PATH="$OLD_PATH"

print_section_header "\$PATH after .uenv"

pretty_path "$TMP_PATH"

print_section_header "\$PATH_ADD after .uenv"

pretty_path "$PATH_ADD"

export PATH="$TMP_PATH"

. "$HOME/.uprofile"

TMP_PATH="$PATH"

export PATH="$OLD_PATH"

print_section_header "\$PATH after .uprofile"

pretty_path "$TMP_PATH"
