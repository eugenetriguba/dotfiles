#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.config/shell/oh-my-zsh.sh
source $HOME/.config/shell/aliases.sh
source $HOME/.config/shell/exports.sh
source $HOME/.config/shell/funcs.sh
source $HOME/.config/shell/pyenv.sh

