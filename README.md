# Installation

The following documentation will guide you through the installation process.

- [Arch Wiki](https://wiki.archlinux.org/) - The linux distribution that I use (btw...!)
- [Stow](https://www.gnu.org/software/stow/) - A package manager to handle dotfiles configurations.
- [starship](https://starship.rs/) - The prompt that I use in my terminal.
- [kitty](https://sw.kovidgoyal.net/kitty/) - The terminal emulator that I use.
- [neovim](https://neovim.io/) - The text editor that I use.

## Packages

The following packages are required to be installed on your system, regardless of the package that you install with `stow`.

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
