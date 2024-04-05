#!/bin/sh -e
message() {
  ansi_pre=$(printf "\033")
  [ "$1" = "info" ] && color="${ansi_pre}[34m" # Blue
  [ "$1" = "success" ] && color="${ansi_pre}[1A${ansi_pre}[K${ansi_pre}[32m" # Clear ^ & Green
  [ "$1" = "error" ] && color="${ansi_pre}[31m" # Red

  printf "%s[%s] %s%s\n" "$color" "$1" "${ansi_pre}[0m" "$2"
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
   for file in "gitconfig" "gitignore" "vimrc" "zshrc"; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done 
   message "success" "Configuration linked"
}

main() {
  message "info" "System Initialising"
  install_xcli 
  install_tooling 
  clone_configuration
  link_configuration 
  message "success" "System configuration complete, enjoy."
}

main
