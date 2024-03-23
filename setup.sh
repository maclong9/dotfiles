#!/bin/sh
message() {
  message="$2";
  
  case "$1" in
    "info")    
      color="$(tput setaf 4)" ;;
    "error")   
      color="$(tput setaf 1)"; message="$?" ;;
    "success") 
      color="$(tput setaf 2)" ;;
  esac
  
  printf "%s%s%s%s\n" "$color" "$message" "$(tput sgr0)"
  
  if [ "$1" = "error" ]; then
    exit 1
  fi
}

install_git() {
  if ! git --version > /dev/null; then
    message "info" "Installing Xcode Developer Tools..."   
    xcode-select --install
    sudo xcodebuild -license accept     
    message "success" "Xcode Developer Tools installed"
  fi
}

install_tooling() {
  message "info" "Installing tools..." 
  if ! deno --version > /dev/null; then
    curl -fsSL "https://deno.land/install.sh" | sh
  fi  
  message "success" "Tooling installed"
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    message "info" "$HOME/.config already exists"
  else
    message "info" "Cloning configuration..."
    git clone "https://github.com/maclong9/dotfiles" "$HOME/.config"
    message "success" "Configuration cloned"
  fi
}

link_configuration() {
   message "info" "Linking configuration files..." 
   for file in "gitconfig" "vimrc" "zshrc"; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done 
   message "success" "Configuration linked"
}

install_git || message "error"
install_tooling || message "error"
clone_configuration || message "error"
link_configuration || message "error"
message "success" "System configuration complete, enjoy."
