#!/bin/bash
# set up flathub remote

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# rpmfusion/media packages

sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf install -y libva-utils libheif-tools

# tailscale
# Note: to finish Tailscale setup, run ~sudo tailscale up~ when ready.

sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled

# steam

flatpak install -y flathub com.valvesoftware.Steam
sudo dnf install -y steam-devices

# discord

flatpak install flathub com.discordapp.Discord

# fractal (matrix)

flatpak install flathub org.gnome.Fractal

# foliate

flatpak install flathub com.github.johnfactotum.Foliate

# 1password

sudo dnf install -y https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm

# doomemacs

sudo dnf install -y emacs fd-find ripgrep shellcheck shfmt
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# module prereqs
# required for:
# - mu4e
# - markdown-preview

sudo dnf install -y isync maildir-utils pandoc

# localsend

flatpak install -y flathub org.localsend.localsend_app

# image editing

sudo dnf install -y pinta krita

# terminal

sudo dnf install -y alacritty

# misc

flatpak install flathub com.rafaelmardojai.Blanket
flatpak install flathub de.haeckerfelix.Shortwave
flatpak install flathub io.github.celluloid_player.Celluloid
flatpak install flathub app.fotema.Fotema
flatpak install flathub info.febvre.Komikku
flatpak install flathub dev.bragefuglseth.Fretboard
flatpak install flathub org.gnome.design.Emblem
flatpak install flathub page.kramo.Cartridges
flatpak install flathub net.nokyan.Resources
flatpak install flathub de.haeckerfelix.Fragments

# easyeffects
# Installs EasyEffects with presets for the framework 13 speakers

flatpak install flathub com.github.wwmm.easyeffects
TMP=$(mktemp -d) && \
CFG=${XDG_CONFIG_HOME:-~/.config}/easyeffects && \
mkdir -p "$CFG" && \
curl -Lo $TMP/fwdsp.zip https://github.com/cab404/framework-dsp/archive/refs/heads/master.zip && \
unzip -d $TMP $TMP/fwdsp.zip 'framework-dsp-master/config/*/*' && \
sed -i 's|%CFG%|'$CFG'|g' $TMP/framework-dsp-master/config/*/*.json && \
cp -rv $TMP/framework-dsp-master/config/* $CFG && \
rm -rf $TMP

# playball! (mlb)

sudo dnf install -y nodejs
sudo npm install -g playball

# rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# the rest

sudo dnf install -y vim stow htop iftop fzf lm_sensors

# extensions/tweaks

sudo dnf install -y gnome-tweaks
sudo dnf install -y gnome-extensions-app
sudo dnf install -y gnome-shell-extension-appindicator
sudo dnf install -y gnome-shell-extension-blur-my-shell
sudo dnf install -y gnome-shell-extension-caffeine
sudo dnf install -y gnome-shell-extension-just-perfection
sudo dnf install -y gnome-shell-extension-openweather
sudo dnf install -y gnome-shell-extension-auto-move-windows

# gtk3 dark theme
# Some applications (like emacs or 1password) don't support gtk4 so we need this package to enable dark mode on "legacy" apps (see gnome-tweaks)

sudo dnf install -y adw-gtk3-theme

# preinstalled software I don't use/want/like

sudo dnf remove -y gnome-boxes
sudo dnf remove -y libreoffice*
sudo dnf remove -y totem
sudo dnf remove -y rhythmbox
