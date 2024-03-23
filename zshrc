source "$HOME/.zplug/init.zsh"
bindkey -v

export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

mkcd() {
  mkdir "$1" && cd "$1"
}
