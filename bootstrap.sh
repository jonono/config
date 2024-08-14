#!/bin/bash
# this script bootstraps my fedora 40 kde install.
# assumeyesses added where possible but still requires some manual intervention (aka doom install)

# preamble
sudo dnf update -y
sudo dnf install -y git

# rpmfusion / media
sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf install -y libva-utils libheif-tools

# flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# steam
flatpak install -y flathub com.valvesoftware.Steam
sudo dnf install -y steam-devices

# gui applications
sudo dnf install -y https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
sudo dnf install -y pinta krita
flatpak install -y flathub org.localsend.localsend_app
sudo dnf copr enable -y wezfurlong/wezterm-nightly && sudo dnf install -y wezterm

# nerd font copr
dnf copr enable -y che/nerd-fonts && dnf install -y nerd-fonts

# emacs+doom
sudo dnf install -y emacs fd-find ripgrep
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# tailscale
sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled
#run `sudo tailscale up` when ready to set tailscale up

# tools
sudo dnf install -y shellcheck shfmt vim stow

# playball!
sudo dnf install -y nodejs
sudo npm install -g playball
