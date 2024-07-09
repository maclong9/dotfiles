# Dotfiles

Configuration files for zsh, tmux, git and vim.

## Usage

``` sh
git clone https://github.com/maclong9/dotfiles .config

for file in .config/*(D); do
  if [[ $file:t != ".git" && $file:t != "README.md" ]]; then
    ln -s "$file" "$HOME/.${file:t}"
  fi
done
```
