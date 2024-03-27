#!/bin/sh
message() {
  ANSI_PREFIX=$(printf "\033")
  if [ "$1" = "info" ]; then
    printf "%s" "${ANSI_PREFIX}[34m" # Sets Foreground to Blue
  elif [ "$1" = "error" ]; then
    printf "%s" "${ANSI_PREFIX}[31m" # Sets Foreground to Red
  elif [ "$1" = "success" ]; then
    printf "%s" "${ANSI_PREFIX}[32m" # Sets Foreground to Green
    printf "%s[1A%s[K" "${ANSI_PREFIX}" "${ANSI_PREFIX}" # Clears Previous Line
  fi
  
  printf "%s%s[0m\n" "$2" "${ANSI_PREFIX}" # Clears previous Foreground color
  
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
  if ! command -v deno > /dev/null; then
    message "info" "Installing Tooling..."
    curl -SLs "https://deno.land/install.sh" | sh >/dev/null 2>&1
    message "success" "Tooling installed"
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
install_tooling || message "error"
clone_configuration || message "error"
link_configuration || message "error"
message "success" "System configuration complete, enjoy."
