#!/bin/bash

# setup ufw
sudo pacman -S --noconfirm --needed ufw

# disable ufw if it is already enabled
sudo ufw disable
# reset ufw to default settings
sudo ufw reset

# deny all incoming connections
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# allow loopback connections
sudo ufw allow in on lo
sudo ufw allow out on lo

# # QMENU settings
# Allow DNS
sudo ufw route allow in on virbr0 out on wlan0 proto udp to any port 53
# Allow HTTP
sudo ufw route allow in on virbr0 out on wlan0 proto tcp to any port 80
# Allow HTTPS
sudo ufw route allow in on virbr0 out on wlan0 proto tcp to any port 443

# enable ufw
sudo ufw enable

# show ufw status
sudo ufw status verbose

# make sure ufw is enabled on boot
sudo systemctl enable ufw
sudo systemctl restart ufw
sudo systemctl daemon-reload
