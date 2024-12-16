#!/bin/sh

# Update pacman package list and all installed packages
sudo pacman -Syyu

# Install yay for easy AUR package installation
sudo pacman -S --needed yay

# Install all the packages from the packages.txt file
yay -S --needed - < packages.txt

# Install all stow packages
echo "Creating symlinks for dotfiles, this will overwrite existing files!"
echo "Are you sure you want to continue? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  stow -t ~ --simulate --restow --adopt */

  # check git for any changes, if there are any, reset the branch
  if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
    echo "There are changes in the dotfiles repository which means stow adopted some files."
    echo "Resetting the dotfiles repository to remove these changes."
    git reset --hard
  fi
fi
