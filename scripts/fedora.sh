#!/bin/bash
# set up flathub remote

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# alacritty

sudo dnf install -y alacritty

# fish

sudo dnf install -y fish
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/hydro"

# stow

sudo dnf install -y stow

# stow dotfiles

./dotfiles/setup.sh

# toolbox

sudo dnf install -y toolbox

# rpmfusion

sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf update -y @sound-and-video
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
sudo dnf install -y libva-utils

# 1password

#TODO

# steam

flatpak install -y flathub com.valvesoftware.Steam
# TODO only do this on my laptop
# sudo flatpak override com.valvesoftware.Steam --env=STEAM_FORCE_DESKTOPUI_SCALING=2

# digikam

sudo dnf install -y digikam

# discord

flatpak install -y flathub com.discordapp.Discord

# localsend

flatpak install -y flathub org.localsend.localsend_app

# krita

sudo dnf install -y krita

# element

flatpak install -y flathub im.riot.Riot

# anki

flatpak install -y flathub net.ankiweb.Anki

# celluloid

flatpak install -y flathub io.github.celluloid_player.Celluloid

# mpv

flatpak install -y flathub io.mpv.Mpv

# vlc

flatpak install -y flathub org.videolan.VLC

# doom emacs

# TODO actually install doom emacs
sudo dnf install -y emacs ripgrep fd-find libvterm cmake libtool shellcheck shfmt nodejs-npm

# vim

sudo dnf install -y vim

# rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
