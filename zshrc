source /opt/homebrew/opt/zplug/init.zsh

PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "
bindkey -v

zplug "djui/alias-tips"
zplug "Aloxaf/fzf-tab"
zplug "z-shell/zsh-zoxide"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load

function mkcd() {
  mkdir $1 && cd $1
}
