#!/bin/sh
usage() {
  for string in "Usage: %s [-i <install_command>] [-h]\n" "$0" "Options:\n" \
    "  -i, --install-command <install_command>   Specify the install command to be used\n" \
    "  -h, --help                                Display this help message\n";
  do
    printf "%s" "$string"
  done
  exit 1
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -i | --install-command) 
      INSTALL_COMMAND="$2"
      shift 2 ;;
    -h | --help)            
      usage ;;
    *)                      
      printf "Invalid option: %s\n" "$1"
      usage ;;
    esac
done

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
    if [ "$(uname)" != "Darwin" ]; then 
      message "info" "Installing Xcode Developer Tools..."   
      xcode-select --install
      sudo xcodebuild -license accept     
      message "success" "Xcode Developer Tools installed"
    else
      message "info" "Installing git..."
      "$INSTALL_COMMAND git"
      message "success" "Git installed successfully"
    fi
  fi
}

install_tooling() {
  message "info" "Installing tools..." 
  if [ "$(uname)" != "Darwin" ] && ! vim --version > /dev/null; then
    "$INSTALL_COMMAND vim"
  fi
  curl -fsSL "https://deno.land/install.sh" | sh
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

install_git || message "error" "installing Git"
install_tooling || message "error" "installing tools"
clone_configuration || message "error" "cloning configuration"
link_configuration || message "error" "linking configuration files"
message "success" "System configuration complete, enjoy."
