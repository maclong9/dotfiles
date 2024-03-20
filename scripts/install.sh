#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

install_homebrew() {
  if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> /Users/mac/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    handle_error "~/.config already exists"
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
}

install_tools() {
  brew install deno mas
  brew install --cask element hyperkey orbstack osu texifier
  mas install 1289583905 # 424390742 424389933 634148309 634159523 434290957 497799835 1289583905 
  # ^ Compressor, Final Cut Pro, Logic Pro, MainStage, Motion, Xcode, Pixelmator Pro
  open -a element hyperkey 
}

link_configuration() {
   ln -s "$HOME/.config/gitconfig" "$HOME/.gitconfig"
   ln -s "$HOME/.config/vimrc" "$HOME/.vimrc"
   ln -s "$HOME/.config/zshrc" "$HOME/.zshrc"
}

setup_cron() {

}

install_homebrew || handle_error "Failed to install Homebrew"
clone_configuration || handle_error "Failed to clone configuration."
exit 0
