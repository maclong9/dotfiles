# Base Options
setopt autocd
PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

# Aliases
alias g="git"
alias ls="ls --color"
alias la="ls -a"

# Plugins
## Install zplug if missing
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

## Define Plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "marlonrichert/zsh-autocomplete"
zplug "z-shell/zsh-zoxide"
zplug "belak/zsh-utils"

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
