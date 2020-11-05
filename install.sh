#!/bin/bash

echo -en "This will create symlinks into your HOME/.config and HOME directory. Do you wish to continue? (\e[31my\e[0m/\e[32mn\e[0m)"

read cont
if [[ "$cont" != "y" ]]; then
    exit 1
fi

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

for i in $(ls -a ${dotfiles_dir}/config); do
    ln -s ${dotfiles_dir}/config/${i} ${HOME}/.config/${i}
done

for i in $(ls -a ${dotfiles_dir}/home); do
    ln -s ${dotfiles_dir}/home/${i} ${HOME}/.${i}
done

ln -s ${dotfiles_dir}/local/share/fonts ${HOME}/.local/share/fonts

echo "Created symlinks for dotfiles!"