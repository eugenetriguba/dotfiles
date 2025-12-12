# shellcheck shell=sh
[ -n "${DOTFILES_OS_LOADED}" ] && return
readonly DOTFILES_OS_LOADED=1

os_print() {
  uname
}

os_is_macos() {
  [ "$(os_print)" = "Darwin" ]
}

os_is_openbsd() {
  [ "$(os_print)" = "OpenBSD" ]
}

os_is_linux() {
  [ "$(os_print)" = "Linux" ]
}

os_is_linux_debian() {
  _linux_debian_id=$(. /etc/os-release && echo $ID)
  [ os_is_linux ] && [ "$_linux_debian_id" = "debian" ]
}
