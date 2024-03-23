#!/bin/sh
printf "%s%s%s\n" "$(tput setaf 4)" "$1" "$(tput sgr0)"
printf "%sError %s: %s%s" "$(tput setaf 1)" "$1" "$?" "$(tput sgr0)"
printf "%s%s%s\n" "$(tput setaf 2)" "$1" "$(tput sgr0)"

install_xcli() {
  if ! command -v git > /dev/null; then
    message_info "Installing Xcode Developer Tools..."   
 
    xcode-select --install
    sudo xcodebuild -license accept  
   
    message_success "Xcode Developer Tools installed"
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
 
  curl -fsSL https://deno.land/install.sh | sh
 
  message "success" "Tooling installed"
}

install_plugins() {
  TOOL=$1; PLUGIN_PATH=$2; shift 2
  message "info" "Installing $TOOL plugins..."
 
  for plugin in "$@"; do
    git clone "https://github.com/$plugin" "$HOME/$PLUGIN_PATH"
  done

  message "success" "$TOOL plugins installed"
}

setup_tooling() {
  message "info" "Setting up tooling"

  install_plugins "Vim" ".vim/pack/plugins/start" \
    "junegunn/fzf.vim" \
    "lifepillar/vim-mucomplete" \
    "mattn/emmet-vim" \
    "sheerun/vim-polyglot" \
    "tpope/vim-fugitive" \
    "tpope/vim-rsi"
  
  install_plugins "ZSH" ".zsh/plugins" \
    \ "djui/alias-tips"
    \ "Aloxaf/fzf-tab"
    \ "zsh-users/zsh-syntax-highlighting"
    
  message "success" "Tooling setup successfully"
}

message "info" "Initialising System"
install_xcli || message "error" "installing Xcode Developer Tools"
clone_configuration || message "error" "cloning configuration"
link_configuration || message "error" "linking configuration files"
install_tooling || message "error" "installing tools"
setup_tooling || message "error" "setting up tooling"
message "success" "System Initialisation Complete, Enjoy."
