#!/bin/sh
case "$(uname -s)" in
  "Darwin")
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh    echo "eval \$(/opt/homebrew/bin/brew shellenv)" >> "$HOME"/.zprofile
    . "$HOME"/.zprofile
    brew install ansible
    ;;
  "Linux")
    sudo xbps-install ansible
    ;;
  "OpenBSD")
    sudo pkg add ansible
    ;;
  *)
    echo "Unsupported system, exiting"
    ;;
esac

git clone https://github.com/mac-codes9/dotfiles ~/.config
ansible-playbook ~/.config/manifests/initialise.yml
exit 0
