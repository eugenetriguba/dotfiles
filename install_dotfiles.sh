#!/bin/bash
#
# This script installs the dotfiles by symlinking them
# into the appropriate place in the $HOME directory.
#
# Exit Status:
#    - 1 if the user did not wish to continue.
#    - 0 if the script completed.

echo -en "This will create symlinks into your $HOME/.config and $HOME directory. " \
         "Do you wish to continue? (\e[31my\e[0m/\e[32mn\e[0m)"

read cont
if [[ "$cont" != "y" ]]; then
    exit 1
fi

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

for i in $(ls -a ${dotfiles_dir}/config); do
    ln -s ${dotfiles_dir}/config/${i} ${HOME}/.config/${i}
done

for i in $(ls -a ${dotfiles_dir}/home); do
    ln -s ${dotfiles_dir}/home/${i} ${HOME}/${i}
done

ln -s ${dotfiles_dir}/local/share/fonts ${HOME}/.local/share/fonts
fc-cache

echo "Created symlinks for dotfiles!"
exit 0