#!/bin/bash

apt_packages=(
  # baobab # GNOME disk usage analyzer
  curl # command line tool for transferring data with URL syntax
  dconf-editor # simple configuration storage system - graphical editor
  fzf # general-purpose command-line fuzzy finder
  gh # GitHub’s official command line tool.
  # gir1.2-gconf-2.0 # GNOME configuration database system (GObject-introspection)
  git # fast, scalable, distributed revision control system
  git-lfs # git Large File Support
  # gnome-shell-extensions # extensions to extend functionality of GNOME Shell
  gnome-tweaks # tool to adjust advanced configuration settings for GNOME
  # google-chrome-stable # the web browser from Google
  htop # interactive processes viewer
  imagemagick # image manipulation programs -- binaries
  kitty # fast, featureful, GPU based terminal emulator
  # miktex # MiKTeX: a scalable TeX distribution # TODO: uncomment once MiKTeX has a jammy universe repo
  nautilus-extension-gnome-terminal
  # neofetch # shows linux system information with distribution logo
  protonvpn # ProtonVPN metapackage
  # python3-nautilus # python binding for Nautilus components (Python 3 version)
  python3-pip # python package installer
  vim # Vi IMproved - enhanced vi editor
  vim-airline # Lean & mean status/tabline for vim that's light as air
  # virtualbox # x86 virtualization solution
  zsh # shell with lots of features
  zsh-antidote
  # net-tools # deprecated, use iproute2 utilities (ip/ss commands) instead
  # dnsutils # deprecated, use dig instead
)

apt_packages_remove=(
  gnome-terminal # GNOME terminal emulator application
)

snaps=(
  # bpytop # A Python-based resource monitor for your terminal
  # caprine # unofficial and privacy-focused facebook messenger desktop app
  discord # all-in-one voice and text chat for gamers
  docker # docker container runtime
  postman # API development environment
  signal-desktop # Signal Private Messenger for Windows, Mac, and Linux
  spotify # music for everyone
  # vlc # the ultimate media player
)

snaps_remove=(
  firefox # Safe and easy web browser from Mozilla
)

classic_snaps=(
  code # code editing redefined
  # gitkraken # for repo management, in-app code editing & issue tracking
  # microk8s # lightweight kubernetes for workstations and appliances
)

python3_packages=()

python3_user_packages=(
  # nautilus-open-any-terminal
)

add_sources() {
  # Google Chrome
  wget -q -O - https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > tmp/googlechrome.deb
  sudo apt install -y ./tmp/googlechrome.deb
  # ProtonVPN
  wget -q -O - https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb > tmp/protonvpn.deb
  sudo apt install -y ./tmp/protonvpn.deb # installs repo, not package
}

add_sources

sudo apt update

sudo apt full-upgrade --fix-missing --auto-remove -y

(( ${#apt_packages[@]} )) && sudo apt install -y ${apt_packages[@]}

(( ${#apt_packages_remove[@]} )) && sudo apt purge -y --auto-remove ${apt_packages_remove[@]}

(( ${#snaps[@]} )) && sudo snap install ${snaps[@]}

for snap in ${classic_snaps[@]}; do
  sudo snap install $snap --classic
done

(( ${#snaps_remove[@]} )) && sudo snap remove ${snaps_remove[@]}

(( ${#python3_packages[@]} )) && sudo pip3 install ${python3_packages[@]}

(( ${#python3_user_packages[@]} )) && pip3 install --user ${python3_user_packages[@]}

exit 0
