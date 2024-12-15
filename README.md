# Installation

The following documentation will guide you through the installation process.

For further information, please refer to the following links:

- [Arch Wiki](https://wiki.archlinux.org/) - The linux distribution that I use (btw...!)
- [Stow](https://www.gnu.org/software/stow/) - A package manager to handle dotfiles configurations.
- [starship](https://starship.rs/) - The prompt that I use in my terminal.
- [kitty](https://sw.kovidgoyal.net/kitty/) - The terminal emulator that I use.
- [neovim](https://neovim.io/) - The text editor that I use.

## Packages

Install all the required packages on your system by running the `installation.sh` script.

## Adding dotfiles

In order to use the dotfiles provided in this repository, you need to clone the repository and use `stow` to symlink the files to your home directory.

```bash
cd ~
git clone https://github.com/aclemens/dotfiles.git .dotfiles
```

> [!NOTE] Attention
> If you have any existing configuration files in your home directory, you should back them up before running the `stow` command.

Make sure to install the dotfiles repository directly in your home directory, otherwise the `stow` command will not work as expected. If need to install the dotfiles repository in a different location, you need to specify the target directory with the `-t` flag.

> The _bash_ package in this repository defines an alias in the `.bashrc` file to always use the `stow` command with the `-t` flag.

# Usage

In order to apply a package from the dotfiles, you need to use `stow` to symlink the files to your home directory.

```bash
cd <path-to-dotfiles-directory>
stow <package>
```

If you want to install the bash package for example, you would run the following command:

```bash
stow bash
```

This will link all the files in the `bash` directory to your home directory.
