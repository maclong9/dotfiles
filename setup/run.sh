#!/bin/sh

handle_error() {
  echo "An error occurred: $1"
  exit 1
}

installAnsible() {
  if ! [ -x "$(command -v ansible)" ]; then
    case "$(uname -s)" in
      "Darwin")
        pip3 install ansible
        export PATH="$PATH:$HOME/Library/Python/3.9/bin"
        ;;
      "Linux")
        xbps-install -S ansible git  # Adjusted xbps-install command for package installation
        ;;
      *)
        handle_error "Unsupported system"
        ;;
    esac
  fi
}

cloneConfiguration() {
  if [ -e "$HOME/.config" ]; then  # Adjusted directory check syntax
    echo "Configuration folder already exists."
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
}

runSpecifiedPlaybook() {
  case "$1" in
    "prepare")
      ansible-playbook "$HOME/.config/setup/prepare.yml" --ask-become-pass  # Corrected playbook path and option
      ;;
    "initialise")
      ansible-playbook "$HOME/.config/setup/initialise.yml" --ask-become-pass  # Corrected playbook path and option
      ;;
    *)
      handle_error "Invalid playbook specified: $1"
      ;;
  esac
}

installAnsible || handle_error "Failed to install ansible."
cloneConfiguration || handle_error "Failed to clone configuration."
runSpecifiedPlaybook "$1" || handle_error "Failed to execute $1 playbook."
exit 0
