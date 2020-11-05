# Golang
export GOPATH=$HOME/Code/go
export GOBIN=$HOME/Code/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Python Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads NVM

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Pipx
export PATH="$PATH:$HOME/.local/bin"

# Default Editor
export EDITOR="vim"

# Oh My ZSH
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="agnoster"
export plugins=(git)