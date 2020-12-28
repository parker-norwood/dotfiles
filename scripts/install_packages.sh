#!/bin/bash

apt_packages=(
  baobab # GNOME disk usage analyzer
  curl # command line tool for transferring data with URL syntax
  dconf-editor # simple configuration storage system - graphical editor
  fzf # general-purpose command-line fuzzy finder
  gir1.2-gconf-2.0 # GNOME configuration database system (GObject-introspection)
  git # fast, scalable, distributed revision control system
  git-lfs # git Large File Support
  gnome-shell-extensions # extensions to extend functionality of GNOME Shell
  gnome-tweaks # tool to adjust advanced configuration settings for GNOME
  ./deb/google-chrome-stable_current_amd64.deb # the web browser from Google
  htop # interactive processes viewer
  imagemagick # image manipulation programs -- binaries
  kitty # fast, featureful, GPU based terminal emulator
  miktex # MiKTeX: a scalable TeX distribution
  neofetch # shows linux system information with distribution logo
  nodejs # node.js event-based server-side javascript engine
  python3-nautilus # python binding for Nautilus components (Python 3 version)
  python3-pip # python package installer
  vim # Vi IMproved - enhanced vi editor
  vim-airline # Lean & mean status/tabline for vim that's light as air
  # net-tools # deprecated, use iproute2 utilities (ip/ss commands) instead
  # dnsutils # deprecated, use dig instead
)

snaps=(
  caprine # unofficial and privacy-focused facebook messenger desktop app
  discord # all-in-one voice and text chat for gamers
  docker # docker container runtime
  postman # API development environment
  spotify # music for everyone
  vlc # the ultimate media player
)

classic_snaps=(
  code # code editing redefined
  gitkraken # for repo management, in-app code editing & issue tracking
  microk8s # lightweight kubernetes for workstations and appliances
)

python3_packages=()

add_sources() {
  # MiKTeX
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
  echo "deb [arch=amd64] http://miktex.org/download/ubuntu focal universe" | sudo tee /etc/apt/sources.list.d/miktex.list
}

download_deb_packages() {
  mkdir ./deb
  # Google Chrome
  wget -O ./deb/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
}

clean_up_deb_packages() {
  rm -rf ./deb
}

add_sources

download_deb_packages

sudo apt update

sudo apt dist-upgrade --fix-missing --auto-remove -y

(( ${#apt_packages[@]} )) && sudo apt install -y ${apt_packages[@]}

(( ${#snaps[@]} )) && sudo snap install ${snaps[@]}

for snap in ${classic_snaps[@]}; do
  sudo snap install $snap --classic
done

(( ${#python3_packages[@]} )) && sudo pip3 install ${python3_packages[@]}

clean_up_deb_packages
