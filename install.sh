#!/bin/bash
set -e
set -u

# Install yay for easy AUR package installation
sudo pacman -Syy --needed yay

# Install all the packages from the packages.txt file
yay -S --needed - < packages.txt

# Install all stow packages
echo
echo "Creating symlinks for dotfiles... this will overwrite existing files"
echo "and remove configuration files that are unknown to stow!"
echo "Are you sure you want to continue? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  stow -t ~ --restow --adopt */

  # check git for any changes, if there are any, reset the branch
  if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
    echo "There are changes in the dotfiles repository which means stow adopted some files."
    echo "Resetting the dotfiles repository to remove these changes."
    git reset --hard
  fi
fi
