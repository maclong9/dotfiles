PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

source /opt/homebrew/opt/zplug/init.zsh

zplug "belak/zsh-utils"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "z-shell/zsh-zoxide"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

zplug load
bindkey -v
