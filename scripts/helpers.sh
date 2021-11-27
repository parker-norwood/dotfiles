#!/bin/bash

make_tmp_dir() {
  mkdir ./tmp
}

clean_up_tmp_dir() {
  rm -rf ./tmp
}

patch_kitty_gnome_plugins() {
  mkdir -p ~/.local/share/nautilus-python/extensions
  cp .dotfiles/kitty/open-terminal.py ~/.local/share/nautilus-python/extensions
  sudo cp .dotfiles/kitty/desktopIconsUtil.js /usr/share/gnome-shell/extensions/desktop-icons@csoriano
}

install_fira_code_nerd_fonts() {
  mkdir -p ~/.local/share/fonts/NerdFonts
  curl -Lo tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
  unzip -o -d ~/.local/share/fonts/NerdFonts tmp/FiraCode.zip
  fc-cache -fv
}

install_fira_code_nerd_fonts_old() {
  submodules/nerd-fonts/install.sh FiraCode
}

change_shell() {
  chsh -s $(which zsh)
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50
  sudo update-alternatives --set x-terminal-emulator $(which kitty)
  kitty -d ~ --detach zsh -c "neofetch; echo '\n***Make sure to logout to reflect changes to the default shell.***\n'; zsh -i"
}

add_user_to_docker_group() {
  sudo groupadd docker
  sudo usermod -aG docker $USER
  echo "Docker commands enabled without sudo. A system restart is required."
}

[ -z "$1" ] && echo "USAGE" && exit

case $1 in
  make_tmp_dir) make_tmp_dir;;
  clean_up_tmp_dir) clean_up_tmp_dir;;
  patch_kitty_gnome_plugins) patch_kitty_gnome_plugins;;
  install_fira_code_nerd_fonts) install_fira_code_nerd_fonts;;
  install_fira_code_nerd_fonts_old) install_fira_code_nerd_fonts;;
  change_shell) change_shell;;
  add_user_to_docker_group) add_user_to_docker_group;;
  *) echo "USAGE" && exit;;
esac
