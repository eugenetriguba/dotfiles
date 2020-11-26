#!/bin/bash
#
# This script installs the dotfiles by symlinking them
# into the appropriate place in the $HOME directory.
#
# Exit Status:
#    - 1 if the user did not wish to continue.
#    - 0 if the script completed.

. ./helpers.bash

confirm_prompt "This will create symlinks into your HOME/.config and HOME directory"

dotfiles_dir = $(current_dir)

for file in $(ls -a ${dotfiles_dir}/config); do
    ln -s ${dotfiles_dir}/config/${file} ${HOME}/.config/${file}
done

for file in $(ls -a ${dotfiles_dir}/home); do
    ln -s ${dotfiles_dir}/home/${file} ${HOME}/${file}
done

echo "Created symlinks for dotfiles!"
exit 0