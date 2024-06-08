#!/bin/bash

# $home
echo "stowing into \$home"
stow -v -R --dotfiles --no-folding -t ~ emacs
stow -v -R --dotfiles --no-folding -t ~ sway
stow -v -R --dotfiles --no-folding -t ~ waybar
stow -v -R --dotfiles --no-folding -t ~ mako
stow -v -R --dotfiles --no-folding -t ~ foot

# /etc
echo "stowing into /etc"
sudo stow -v -R --no-folding -t /etc nm-no-rand-mac-addr
