#!/bin/sh

change_shell() {
  chsh -s $(which zsh)
}

change_terminal() {
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /snap/bin/ghostty 100
  sudo update-alternatives --set x-terminal-emulator /snap/bin/ghostty
  sed -i '1ighostty_ghostty.desktop' ~/.config/ubuntu-xdg-terminals.list
}

install_firacode_nerd_font() {
  mkdir -p ~/.local/share/fonts
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
  tar -xvf FiraCode.tar.xz -C ~/.local/share/fonts --wildcards *.ttf
  fc-cache -fv
  rm FiraCode.tar.xz
}

add_user_to_docker_group() {
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  sudo snap disable docker
  sudo snap enable docker
}

setup_git() {
  gh auth login
  gh auth setup-git
  read -p "git config --global user.name " git_user_name
  git config --global user.name $git_user_name
  read -p "git config --global user.email " git_user_email
  git config --global user.name $git_user_email
}

# TODO: Utilize once dracula-theme-snap has autoconnect greedy plug
# https://gitlab.com/sundbp/dracula-theme-snap
dracula_theme() {
  wget https://github.com/dracula/gtk/archive/master.zip
  unzip -d ~/.themes master.zip
  mv ~/.themes/gtk-master ~/.themes/Dracula
  rm -rf ~/.config/gtk-4.0
  ln -s ~/.themes/Dracula/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
  ln -s ~/.themes/Dracula/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
  ln -s ~/.themes/Dracula/gtk-4.0/assets ~/.config/gtk-4.0/assets
  ln -s ~/.themes/Dracula/assets ~/.config/assets
}

dconf_load() {
  dconf load / < $CHEZMOI_SOURCE_DIR/dconf.ini
}

change_shell
change_terminal
install_firacode_nerd_font
add_user_to_docker_group
setup_git
dconf_load