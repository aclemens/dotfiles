#!/bin/sh

# Update pacman package list and all installed packages
sudo pacman -Syyu

# Install yay for easy AUR package installation
sudo pacman -S --needed yay

# Install all the packages from the packages.txt file
yay -S --needed - < packages.txt

