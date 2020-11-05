# Dotfiles

These are my personal dotfiles that I use for quickly getting setup on a fresh install of an operating system or a new computer. I use these dotfiles with Arch Linux running XFCE as the desktop environment and i3 as the window manager.

## Setup

> I would generally avoid the install script and instead, read
> through the files in this repository and take the bits that
> you like and work for you.

We'll first want to clone down the repository.

```
$ git clone git@github.com:eugenetriguba/dotfiles.git
```

After that, we can run `./install.sh` to symlink all our `config/` folders
into `$HOME/.config/` and `home/` files into `$HOME/`. 

The symlinks are useful because now anytime I customize one of my dotfiles, those changes are actually made to the file in my dotfiles git repo. That allows
me to periodically push those changes back up and pull them down on any other
device that I also want to have these changes on.
