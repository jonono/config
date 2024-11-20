#!/usr/bin/env bash

sudo dnf install -y \
	alacritty \
	emacs \
	gnome-tweaks \
	gnome-extensions-app \
	gnome-shell-extension-appindicator \
	gnome-shell-extension-blur-my-shell \
	gnome-shell-extension-caffeine \
	gnome-shell-extension-no-overview \
	gnome-shell-extension-pop-shell \
	gnome-themes-extra \
	stow \
	tmux \
	vim

# alacritty themes
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
