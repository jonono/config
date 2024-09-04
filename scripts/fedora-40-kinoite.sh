#!/bin/bash
# set up flathub remote

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# ffmpeg-full
# explicitly installing ffmpeg-full should give flatpak firefox access to hardware accelerated decoding.

flatpak install -y --runtime "runtime/org.freedesktop.Platform.ffmpeg-full/x86_64/23.08"

# firefox

flatpak install -y flathub org.mozilla.firefox

# 1password
# flatpak 1password is not ideal but good enough.

flatpak install -y https://downloads.1password.com/linux/flatpak/1Password.flatpakref

# steam

flatpak install -y flathub com.valvesoftware.Steam
sudo flatpak override com.valvesoftware.Steam --env=STEAM_FORCE_DESKTOPUI_SCALING=2

# ksudoku

flatpak install -y flathub org.kde.ksudoku

# digikam

flatpak install -y flathub org.kde.digikam

# discord

flatpak install -y flathub com.discordapp.Discord

# localsend

flatpak install -y flathub org.localsend.localsend_app

# krita

flatpak install -y flathub org.kde.krita

# video

flatpak install -y flathub io.github.celluloid_player.Celluloid

# yakuake
# yakuake is a sliding terminal window. bound to a hotkey it slides a terminal window down from the top of the screen.

flatpak install -y flathub org.kde.yakuake

# create toolbox container

toolbox create

# doom emacs

# TODO
toolbox run --container fedora-toolbox-40 sudo dnf install -y emacs

# stow

toolbox run --container fedora-toolbox-40 sudo dnf install -y stow

# vim

toolbox run --container fedora-toolbox-40 sudo dnf install -y vim

# rust

toolbox run --container fedora-toolbox-40 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# haskell

toolbox run --container fedora-toolbox-40 sudo dnf install -y stack
