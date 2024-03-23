#!/bin/sh
message() {
  MSG="$2"; ERR=""; NC="$(tput sgr0)";
  case "$1" in
    "info")    
      COL="$(tput setaf 4)" ;;
    "error")   
       COL="$(tput setaf 1)" 
       ERR=": $?" ;;
    "success") 
      COL="$(tput setaf 2)" ;;
  esac
  
  printf "%s%s%s%s\n" "$COL" "$MSG" "$ERR" "$NC"
  
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
  curl -fsSL "https://deno.land/install.sh" | sh
  message "success" "Tooling installed"
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    message "error" "$HOME/.config already exists"
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

install_git || message "error" "installing Git"
install_tooling || message "error" "installing tools"
clone_configuration || message "error" "cloning configuration"
link_configuration || message "error" "linking configuration files"
message "success" "System configuration complete, enjoy."
