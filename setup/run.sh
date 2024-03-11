#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

function installAnsible() {
  if [ -x "$(command -v $ansible)" ]; then
    case "$(uname -s)" in
      "Darwin")
        pip3 install ansible
        export PATH=$PATH:"$HOME"/Library/Python/3.9/bin
        ;;
      "Linux")
        xbps-install ansible git
        ;;
      *)
        handle_error "Unsupported system"
        ;;
    esac
  fi
}

function cloneConfiguration() {
  if [ -e "$HOME"/.config ]; then
    echo "Configuration folder already exists."
  else
    git clone https://github.com/maclong9/dotfiles "$HOME"/.config
  fi
}

function runSpecifiedPlaybook() {
  case "$1" in
  "prepare")
    ansible-playbook ~/.config/setup/prepare.yml --ask-become-password 
  ;;
  "initialise")
    ansible-playbook ~/.config/setup/initialise.yml --ask-become-password
  ;;
  esac
}

function main() {
  installAnsible || handle_error "Failed while installing ansible."
  cloneConfiguration || handle_error "Failed to clone configuration."
  runSpecifiedPlaybook $1 || handle_error "Failed to execute $1 playbook."
  exit 0
}
main()
