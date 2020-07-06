# Dotfiles

These are my personal dotfiles that I use for quickly getting setup on a fresh install of an operating system or a new computer.
I use these dotfiles with Arch Linux running XFCE as the desktop enviroment and i3 as the window manager.

## Setup

We'll first want to clone down the repository.

```
$ git clone git@github.com:eugenetriguba/dotfiles.git
```

After that, we'll want to create a ~/Code directory and move our dotfiles/ folder into it.
```
$ mkdir ~/Code
$ mv ~/Downloads/dotfiles ~/Code/dotfiles
```

The reason for this is that I keep all my dotfiles in ~/Code/dotfiles and
use symbolic soft links (`ln -s`) to link all the files out from this folder
to where they need to go. So for example, I'd link up `.zshrc` with `ln -s ~/Code/dotfiles/.zshrc ~/.zshrc`.
Now anytime I customize my `.zshrc` file, those changes are actually made to my file in `~/Code/dotfiles/.zshrc`,
which is a git repo. I can then periodically push those changes back up and pull them down on any other
device that I also want to have those changes.
