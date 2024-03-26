#!/bin/sh
message() {
  ESC=$(printf "\033")
  if [ "$1" = "info" ]; then
    printf "%s" "${ESC}[34m"
  elif [ "$1" = "error" ]; then
    printf "%s" "${ESC}[31m" 
  elif [ "$1" = "success" ]; then
    printf "%s" "${ESC}[32m" 
    printf "%s[1A%s[K" "${ESC}" "${ESC}"
  fi
  
  printf "%s%s[0m\n" "$2" "${ESC}"
  
  if [ "$1" = "error" ]; then
    exit 1
  fi
}

install_xcli() {
  if ! command -v git > /dev/null && [ "$(uname)" = "Darwin" ]; then
    message "info" "Installing Xcode Developer Tools..."   
    xcode-select --install
    sudo xcodebuild -license accept     
    message "success" "Xcode Developer Tools installed"
  fi
}

install_tooling() {
  if [ -n "$1" ]; then
    if [ "$(uname)" != "Darwin" ]; then
      command "$1 git vim"
    fi
  else
    message "error" "No install command specified"
    return
  fi

  if [ ! -d "$HOME/.deno" ]; then
    message "info" "Installing Deno..."
    curl -SLs "https://deno.land/install.sh" | sh >/dev/null 2>&1
    message "success" "Deno installed"
  fi
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    message "info" "$HOME/.config already exists"
  else
    message "info" "Cloning configuration..."
    git clone -q "https://github.com/maclong9/dotfiles" "$HOME/.config"
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

install_xcli || message "error"
install_tooling $1 || message "error"
clone_configuration || message "error"
link_configuration || message "error"
message "success" "System configuration complete, enjoy."
