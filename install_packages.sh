#!/bin/bash
#
# Installs packages and tools I use.

echo -en "This will do a full system update, install packages using pacman, and " \
         "run various remote scripts in order to install tools such as nvm. into " \
         "your $HOME/.config and $HOME directory. " \
         "Do you wish to continue? (\e[31my\e[0m/\e[32mn\e[0m)"

read cont
if [[ "$cont" != "y" ]]; then
    exit 1
fi

echo "Running full system upgrade.."
sudo pacman -Syu

echo "Installing pacman packages.."
sudo pacman -S vim pyenv yarn sway termite

echo "Installing AUR packages using yay.."
yay -S nvm pyenv-virtualenv oh-my-bash-git vim-plug

echo "Installing vim plugins.."
vim +'PlugInstall --sync' +qa

echo "Installing fonts.."
yay -S otf-san-francisco-pro otf-san-francisco nerd-fonts-complete
sudo pacman -S ttf-fira-code ttf-font-awesome adobe-source-code-pro-fonts
 
echo "Finished installing packages."
exit 0