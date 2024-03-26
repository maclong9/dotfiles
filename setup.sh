#!/bin/sh
message() {
  content="$2";
  if [ "$1" = "info" ]; then
    color="\e[34m"
    content="$content..."
  elif [ "$1" = "error" ]; then
    color="\e[31m" 
  elif [ "$1" = "success" ]; then
   color="\e[32m" 
   printf "\033[1A\033[K"
  fi
  
  printf "%s%s%s\n" "$color" "$content" "$(tput sgr0)"
  
  if [ "$1" = "error" ]; then
    exit 1
  fi
}

install_xcli() {
  if ! command -v git > /dev/null && [ "$(uname)" = "Darwin" ]; then
    message "info" "Installing Xcode Developer Tools"   
    xcode-select --install
    sudo xcodebuild -license accept     
    message "success" "Xcode Developer Tools installed"
  fi
}

install_tooling() {
  if ! command -v deno > /dev/null; then
    message "info" "Installing Deno"
    curl -SLs "https://deno.land/install.sh" | sh >/dev/null 2>&1
    message "success" "Tooling installed"
  fi  
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    message "info" "$HOME/.config already exists"
  else
    message "info" "Cloning configuration"
    git clone -q "https://github.com/maclong9/dotfiles" "$HOME/.config"
    message "success" "Configuration cloned"
  fi
}

link_configuration() {
   message "info" "Linking configuration files" 
   for file in "gitconfig" "vimrc" "zshrc"; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done 
   message "success" "Configuration linked"
}

install_xcli || message "error"
install_tooling || message "error"
clone_configuration || message "error"
link_configuration || message "error"
message "success" "System configuration complete, enjoy."
