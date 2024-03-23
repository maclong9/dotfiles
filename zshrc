source "$HOME/.zplug/init.zsh"
bindkey -v

export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

zplug "djui/alias-tips"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "BurntSushi/ripgrep", from:gh-r, as:command
zplug "ajeetdsouza/zoxide", from:gh-r, as:command
zplug "z-shell/zsh-zoxide"
zplug load

mkcd() {
  mkdir "$1" && cd "$1"
}
