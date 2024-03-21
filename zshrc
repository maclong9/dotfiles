# Base Options
PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

# Aliases
alias g="git"
alias la="ls -a"

# Plugins
source ~/.zplug/init.zsh
zplug "belak/zsh-utils"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "z-shell/zsh-zoxide"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load
bindkey -v
