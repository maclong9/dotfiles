#!/bin/sh
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
NO_COLOR=$(tput sgr0)
HOMEBREW_PATH="/opt/homebrew/bin/brew"

handle_error() {
  printf "%sAn error occurred: %s%s\n" "$RED" "$1" "$NO_COLOR"
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
    
    success_message "Xcode Developer Tools installed"
  fi
}

install_homebrew() {
  info_message "Installing Homebrew..."
  if [ ! -d "$HOMEBREW_PATH" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$($HOMEBREW_PATH shellenv)"
  fi
  success_message "Homebrew installed"
}

create_zprofile() {
  if [ ! -e "$HOME/.zprofile" ]; then
    printf "eval \"\$(%s shellenv)\"" "$HOMEBREW_PATH" >> "$HOME/.zprofile"
  fi
}

clone_configuration() {
  info_message "Cloning configuration..."
  if [ -d "$HOME/.config" ]; then
    info_message "$HOME/.config already exists"
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
  success_message "Configuration cloned"
}

install_tools() {
  info_message "Installing tools..."
  brew install deno fzf ripgrep zoxide zplug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  success_message "Tooling installed"
}

install_apps() {
  info_message "Installing applications..."
  brew install mas
  brew install --cask osu superkey
  mas install 1289583905 # 424390742 424389933 634148309 634159523 434290957 497799835 1289583905 
  success_message "Applications installed"
}

link_configuration() {
   info_message "Linking configuration files..."
   for file in gitconfig vimrc zshrc; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done
   success_message "Configuration linked"
}

info_message "Initialising System"
install_xcli || handle_error "Failed to install Xcode Developer Tools"
install_homebrew || handle_error "Failed to install Homebrew"
create_zprofile || handle_error "Failed to create zprofile"
clone_configuration || handle_error "Failed to clone configuration"
install_tools || handle_error "Failed to install tools"
install_apps || handle_error "Error installing applications"
link_configuration || handle_error "Failed while linking configuration files"
success_message "System Initialisation Complete, Enjoy."
