set -gx TERM xterm-256color

set -gx EDITOR nvim
set -gx PAGER less
set -gx MANPAGER less
set -gx MANWIDTH 80

set -gx GPG_TTY (tty)

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx SRC_DIR $HOME/src
set -gx BIN_DIR $HOME/bin

fish_add_path \
    $BIN_DIR \
    $HOME/.local/bin
