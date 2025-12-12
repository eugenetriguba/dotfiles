# shellcheck shell=sh
[ -n "${DOTFILES_BOOTSTRAP_LOADED}" ] && return
readonly DOTFILES_BOOTSTRAP_LOADED=1

. "$(dirname "$0")/shlib/homebrew.sh"
. "$(dirname "$0")/shlib/log.sh"
. "$(dirname "$0")/shlib/prompt.sh"

bootstrap_macos() {
  if ! homebrew_is_installed; then
    if prompt_for_confirmation "Homebrew not found. Would you like to install Homebrew?"; then
      homebrew_install
    else
      log_error "Cannot continue without homebrew installed."
      return 1
    fi
  fi

  log_info "Found homebrew installation. Installing Brewfile.."
  (cd macos/homebrew && brew bundle)
  log_info "Brewfile successfully installed. Moving to linking dotfiles.."

  sudo ln -sf "$HOME/bin/get-password" /usr/local/bin/get-password
  sudo ln -sf "$(which op)" /usr/local/bin/op
}

bootstrap_linux_debian() {
  sudo apt-get install curl
  if ! command -v op; then
    _install_1password_cli
  fi
  if ! command -v ghostty; then
    _install_ghostty
  fi

  log_info "Installing debian packages..."
  _linux_debian_packages="$(cat "$(dirname "$0")/linux-debian/packages.txt" | tr '\n' ' ')"
  # shellcheck disable=SC2086
  sudo apt-get install --assume-yes $_linux_debian_packages
  chsh -s $(which zsh) "$USER"
}

_install_1password_cli() {
  # https://developer.1password.com/docs/cli/get-started/
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
    sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
    sudo tee /etc/apt/sources.list.d/1password.list && \
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
    sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
    sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
    sudo apt update && sudo apt install 1password-cli
}

_install_ghostty() {
  curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
  echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
  sudo apt update
  sudo apt intall ghostty
}
