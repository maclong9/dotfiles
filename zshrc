# Base Options
PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

# Aliases
alias g="git"
alias la="ls -a"

# Plugins
## Install zplug if missing
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

## Define Plugins
zplug "belak/zsh-utils"
zplug "z-shell/zsh-zoxide"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

## Install Missing Plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Key Bindings
bindkey -v
