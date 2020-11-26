# Dotfiles

These are my personal dotfiles that I use for quickly getting setup on a fresh install of an operating system or a new computer. I use these dotfiles with [Arch Linux](https://www.archlinux.org/) running [Sway](https://swaywm.org/).

## Setup

> I would generally avoid the install script and instead, read
> through the files in this repository and take the bits that
> you like and work for you.

We'll first want to clone down the repo.

```
$ git clone git@github.com:eugenetriguba/dotfiles.git
$ cd dotfiles
```

And then we can install the dotfiles by creating symlinks and install
the packages we need for the dotfiles.
```
$ ./install_dotfiles.bash
$ ./install_packages.bash
```

`install_dotfiles` will symlink all our `config/` folders into `$HOME/.config/`
and `home/` files into `$HOME/`. 

`install_packages` installs the various fonts and tools needed for the dotfiles.

## License

The [MIT](./LICENSE) License
