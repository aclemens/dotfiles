# Installation

The following documentation will guide you through the installation process.

- [Arch Wiki](https://wiki.archlinux.org/) - The linux distribution that I use (btw...!)
- [Stow](https://www.gnu.org/software/stow/) - A package manager to handle dotfiles configurations.
- [starship](https://starship.rs/) - The prompt that I use in my terminal.
- [kitty](https://sw.kovidgoyal.net/kitty/) - The terminal emulator that I use.
- [neovim](https://neovim.io/) - The text editor that I use.

## Packages

The following packages are required to be installed on your system, in order to use all the provided dotfiles.

```bash
sudo pacman -Sy --needed yay
sudo yay -S --needed
    eza
    fastfetch
    git
    htop
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    kitty
    lazygit
    neovim
    npm
    python-black
    python-isort
    starship
    stow
    stylua
    vim
    waybar
    wofi
```

## Adding dotfiles

In order to use the dotfiles provided in this repository, you need to clone the repository and use `stow` to symlink the files to your home directory.

```bash
git clone https://github.com/aclemens/dotfiles.git
```

# Configuration

In order to apply a package from the dotfiles, you need to use `stow` to symlink the files to your home directory.

```bash
cd dotfiles
stow <package>
```

If you want to install the nvim configuration for example, you would run the following command:

```bash
cd dotfiles
stow neovim
```

This will link all the files in the `neovim` directory to your home directory.
