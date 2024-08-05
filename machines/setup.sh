#!/bin/bash
set -euo pipefail

sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S git

# paru
mkdir "${HOME}/pkgbuild" && cd "${HOME}/pkgbuild"
sudo pacman --noconfirm -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# aur packages
paru -S pacnews clipman 1password

# archwiki offline
sudo pacman --noconfirm -S arch-wiki-docs dialog arch-wiki-lite

# gpu stuff
sudo pacman --noconfirm -S libva-utils libva-mesa-driver mesa

# sway/windowing environment stuff
sudo pacman --noconfirm -S sway swayidle swaybg swaylock bemenu-wayland dunst brightnessctl polkit gnome-themes-extra
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# fonts
sudo pacman --noconfirm -S noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-firacode-nerd

# gui applications
sudo pacman --noconfirm -S firefox steam gamescope pinta

# emacs+doom
sudo pacman --noconfirm -S emacs-wayland
git clone --depth 1 https://github.com/doomemacs/doomemacs "${HOME}/.config/emacs"
"${HOME}/.config/emacs/bin/doom" install

# tools
sudo pacman --noconfirm -S ffmpeg power-profiles-daemon python-gobject
powerprofilesctl set power-saver
