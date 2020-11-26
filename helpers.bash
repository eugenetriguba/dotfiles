#!/bin/bash
#
# Installation helper functions.

# Prompts the user to confirm an action.
# After the prompt text is displayed, if the
# inputted text is not "y", we exit with a status
# code of 1.
#
# Args:
#   $1: The text for the prompt.
function confirm_prompt {
    echo -en "$1. Do you wish to continue? (\e[31my\e[0m/\e[32mn\e[0m) "

    read cont
    if [[ "$cont" != "y" ]]; then
        exit 1
    fi
}

# Retrieves the current directory.
#
# Example Usage:
#   dotfiles_dir = $(current_dir)
function current_dir {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
}