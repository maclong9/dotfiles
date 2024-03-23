source "$HOME/.zplug"
bindkey -v

PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

zplug "djui/alias-tips"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg
zplug "ajeetdsouza/zoxide", from:gh-r, as:command, rename-to:z
zplug "z-shell/zsh-zoxide"
zplug load

function mkcd() {
  mkdir $1 && cd $1
}
