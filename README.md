# Dotfiles

This repository contains my configuration for various pieces of software I use
(e.g. "dotfiles").

## Installation

### Only Dotfiles

The repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage
symlinks between these configuration files and the user's home directory.

To install only the dotfiles:

```sh
git clone git@github.com:eugenetriguba/dotfiles.git ~/.dotfiles
cd .dotfiles
./link.sh
```

### System Setup

I setup my whole system with an ansible playbook using my
[system-setup](https://git.sr.ht/~eugenetriguba/system-setup) repository.

This installs everything needed onto my system and _then_ symlinks these
configuration files into my home directory.
