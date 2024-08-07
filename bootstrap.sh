#!/bin/bash

sudo dnf install git

# rpmfusion / media
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf install libva-utils
sudo dnf install libheif-tools libheif-freeworld

# flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# gnome stuff
sudo dnf install gnome-tweaks
sudo dnf install adw-gtk3-theme

# steam
flatpak install flathub com.valvesoftware.Steam
sudo dnf install steam-devices

# gui applications
sudo dnf install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
sudo dnf install pinta
flatpak install flathub org.localsend.localsend_app
sudo dnf install krita gnome-kra-ora-thumbnailer

# emacs+doom
sudo dnf install emacs
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# tailscale
sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up
