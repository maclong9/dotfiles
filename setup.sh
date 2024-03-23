#!/bin/sh
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
NO_COLOR=$(tput sgr0)

handle_error() {
  printf "%sError %s: %s%s" "$RED" "$1" "$?" "$NO_COLOR"
  exit 1
}

success_message() {
  printf "%s%s%s\n" "$GREEN" "$1" "$NO_COLOR"
}

info_message() {
  printf "%s%s%s\n" "$BLUE" "$1" "$NO_COLOR"
}

install_xcli() {
  if ! command -v git > /dev/null; then
    info_message "Installing Xcode Developer Tools..."
    xcode-select --install
    sudo xcodebuild -license accept
    success_message "Xcode Developer Tools installed"
  fi
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    info_message "$HOME/.config already exists"
  else
    info_message "Cloning configuration..."
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
    success_message "Configuration cloned"
  fi
}

link_configuration() {
   info_message "Linking configuration files..."
   for file in gitconfig vimrc zshrc; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done
   success_message "Configuration linked"
}

install_tools() {
  info_message "Installing tools..."
  curl -sL --proto-redir -all,https \
    "https://raw.githubusercontent.com/zplug/installer/master/installer.zsh" | zsh
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  curl -fsSL https://deno.land/install.sh | sh
  success_message "Tooling installed"
}

tooling_setup() {
  . "$HOME/.zshrc"
  zplug install
  vim -c "PlugInstall | q"
}

info_message "Initialising System"
install_xcli || handle_error "installing Xcode Developer Tools"
clone_configuration || handle_error "cloning configuration"
link_configuration || handle_error "linking configuration files"
install_tools || handle_error "installing tools"
tooling_setup || handle_error "setting up tooling"
success_message "System Initialisation Complete, Enjoy."
