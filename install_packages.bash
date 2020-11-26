#!/bin/bash
#
# Installs packages and tools I use.

. ./helpers.bash

confirm_prompt "This will install the tools needed for the dotfiles using pacman and yay"

exit 0

echo "Running full system upgrade.."
sudo pacman -Syu

echo "Installing pacman packages.."
sudo pacman -S vim pyenv yarn sway termite

echo "Installing AUR packages using yay.."
yay -S nvm pyenv-virtualenv oh-my-bash-git vim-plug ly

echo "Installing vim plugins.."
vim +'PlugInstall --sync' +qa

echo "Installing fonts.."
yay -S otf-san-francisco-pro otf-san-francisco nerd-fonts-complete
sudo pacman -S ttf-fira-code ttf-font-awesome adobe-source-code-pro-fonts
 
echo "Finished installing packages."
exit 0