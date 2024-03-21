# Base Options
PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

# Aliases
aliases=(
  "g=git"
  "la=ls -a"
)

for alias in "${aliases[@]}"
do
  eval "alias $alias"
done

# Plugins
source =/opt/homebrew/opt/zplug
plugins=(
  "belak/zsh-utils"
  "MichaelAquilina/zsh-you-should-use"
  "z-shell/zsh-zoxide"
  "zsh-users/zsh-completions"
  "zsh-users/zsh-syntax-highlighting"
)

for plugin in "${plugins[@]}"
do
  zplug "$plugin"
done

zplug load
bindkey -v
