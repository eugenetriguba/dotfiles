#!/bin/sh
set -e

(cd "$HOME/.dotfiles" && stow --target "$HOME" .)
