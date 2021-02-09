#!/usr/bin/env sh

sudo pacman -S git hspell nuspell libvoikko

if [! -d "~/.aur" ]; then
   cd ~/.aur
   git clone https://aur.archlinux.org/pulse-secure.git 
   cd pulse-secure
   makepkg -si
fi

