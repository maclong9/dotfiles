#!/bin/sh
usage() {
  for string in "Usage: %s [-i <install_command>] 
    [-h]\n" "$0" "Options:\n" \
    "  -i, --install-command <install_command>   Specify the install command to be used, be sure to add `sudo` if required\n" \
    "  -h, --help                                Display this help message\n";
  do
    printf "$string"
  exit 1
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -i | --install-command) INSTALL_COMMAND="$2"; shift 2;;
    -h | --help)            usage;;
    *)                      printf "Invalid option: %s\n" "$1"; usage;;
    esac
done

message() {
  MSG="$2"; ERR=""; NC="$(tput sgr0)";
  case "$1" in
    "info")    COL="$(tput setaf 4)";;
    "error")   COL="$(tput setaf 1)" ERR=": $?";;
    "success") COL="$(tput setaf 2)";;
  esac
  printf "%s%s%s%s\n" "$COL" "$MSG" "$ERR" "$NC"
}

handle_critical_error() {
  message "error" "Critical error occurred"
  exit 1
} trap "handle_critical_error" ERR

install_git() {
  if ! git --version > /dev/null; then
    if [ "$(uname)" != "Darwin" ]; then 
      message "info" "Installing Xcode Developer Tools..."   
      xcode-select --install
      sudo xcodebuild -license accept     
      message "success" "Xcode Developer Tools installed"
    else
      message "info" "Installing git..."
      $INSTALL_COMMAND git
      message "success" "Git installed successfully"
    fi
  fi
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

install_tooling() {
  message "info" "Installing tools..." 
  if ! curl --version > /dev/null; then
    $INSTALL_COMMAND curl
  fi
  curl -fsSL "https://deno.land/install.sh" | sh
  curl -fsSl "https://raw.githubusercontent.com/junegunn/fzf/master/install" | sh
  message "success" "Tooling installed"
}

install_plugins() {
  TOOL="$1"; PLUGIN_PATH="$2"; shift 2
  message "info" "Installing $TOOL plugins..." 
  for plugin in "$@"; do
    git clone "https://github.com/$plugin" "$HOME/.$PLUGIN_PATH"
  done
  message "success" "$TOOL plugins installed"
}

setup_tooling() {
  message "info" "Setting up tooling"
  install_plugins "Vim" "vim/pack/plugins/start" "junegunn/fzf.vim" "lifepillar/vim-mucomplete" "sheerun/vim-polyglot" "tpope/vim-fugitive" "tpope/vim-rsi"
  install_plugins "ZSH" "zsh/plugins" "Aloxaf/fzf-tab" "zsh-users/zsh-completions" "zsh-users/zsh-syntax-highlighting"    
  message "success" "Tooling setup successfully"
}

install_git || message "error" "installing Git"
clone_configuration || message "error" "cloning configuration"
link_configuration || message "error" "linking configuration files"
install_tooling || message "error" "installing tools"
setup_tooling || message "error" "setting up tooling"
message "success" "System configuration complete, enjoy."
