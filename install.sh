#!/bin/sh
#
# This script installs the packages and tools I use,
# then installs the dotfiles by symlinking them into the
# appropriate place in the $HOME directory.
#
# Exit Status:
#    - 1 if the user did not wish to continue.
#    - 0 if the script completed.

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

confirm_prompt "This will install the tools needed for the dotfiles using pacman and yay"

echo "Running full system upgrade.."
sudo pacman -Syu

echo "Installing pacman packages.."
sudo pacman -S vim pyenv yarn sway termite python-poetry python-pipx playerctl swayidle gammastep jq

echo "Installing AUR packages using yay.."
yay -S nvm pyenv-virtualenv oh-my-bash-git vim-plug ly wob swaylock-effects j4-dmenu-desktop bemenu

echo "Installing vim plugins.."
vim +'PlugInstall --sync' +qa

echo "Installing fonts.."
yay -S otf-san-francisco-pro otf-san-francisco nerd-fonts-complete
sudo pacman -S ttf-fira-code ttf-font-awesome adobe-source-code-pro-fonts
 
echo "Finished installing packages."

confirm_prompt "This will create symlinks into your HOME/.config and HOME directory"

dotfiles_dir = $(current_dir)

for file in $(ls -a ${dotfiles_dir}/config); do
    ln -s ${dotfiles_dir}/config/${file} ${HOME}/.config/${file}
done

for file in $(ls -a ${dotfiles_dir}/home); do
    ln -s ${dotfiles_dir}/home/${file} ${HOME}/${file}
done

for file in $(ls -a ${dotfiles_dir}/local/bin); do
    ln -s ${dotfiles_dir}/local/bin/${file} ${HOME}/.local/bin/${file}
done

echo "Created symlinks for dotfiles!"
exit 0
