# Dotfiles

Configuration files for zsh, tmux, git and vim.

## Usage

``` sh
git clone https://github.com/maclong9/dotfiles .config

for file in .config/*(D); do
  if [[ $file:t != ".git*" && $file:t != "README.md" && $file:t != "nvim" ]]; then
    ln -s "$file" "$HOME/.${file:t}"
  fi
done

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source $HOME/.zshrc

setupinstall

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
