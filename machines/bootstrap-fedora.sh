#!/bin/sh

# setup rpmfusion repos
dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# enable openh264
dnf -y config-manager --enable fedora-cisco-openh264

# full ffmpeg from rpmfusion
dnf -y swap ffmpeg-free ffmpeg --allowerasing

# additional codecs
dnf -y update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y install @sound-and-video

# hardware accel on AMD
dnf -y swap mesa-va-drivers mesa-va-drivers-freeworld
dnf -y swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

# libva-utils gives us vainfo which lets us verify what hardware accleration is available
dnf -y install libva-utils

# terminal / cli tools
dnf -y install vim
dnf -y install ripgrep
dnf -y install zsh

# ppd is what amd recommends for power management on my 7840U powered framework 13
dnf -y install power-profiles-daemon
powerprofilesctl set power-saver
