#
# Go
#
# Assumes a directory structure of all
# code in ~/Code and go code in ~/Code/go
#
export GOPATH=$HOME/Code/go
export GOBIN=$HOME/Code/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

#
# Python
#
# Poetry is used for dependency management,
# pyenv for separate python versions from
# the system python, and pipx for CLI tools.
#
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

#
# Custom scripts
#
export PATH="$HOME/.local/bin:$PATH"
#
# JavaScript/Node
#
# NVM is used to manage versions of node separate
# from the system version. Yarn is used over npm.
#
export PATH="$PATH:$(yarn global bin)"
source /usr/share/nvm/init-nvm.sh

#
# Defaults
#
export EDITOR="vim"
export BROWSER="firefox"

#
# Fix 'unknown terminal xterm-termite'
#
export TERM="xterm-256color"

#
# Fix vim youcompleteme issues with pyenv
#
export PYTHON_CONFIGURE_OPTS="--enable-shared"

#
# Wayland Support
#
export MOZ_ENABLE_WAYLAND=1

#
# Qt
#
export QT_SCALE_FACTOR=1.5
export QT_AUTO_SCREEN_SCALE_FACTOR=0
