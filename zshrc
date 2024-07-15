export PATH=$PATH:$HOME/.mint/bin:/opt/homebrew/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

setopt autocd

alias g="git"
alias hg="history | grep"
alias dup="docker-compose up -d"
alias dst="docker-compose stop"
alias ddw="docker-compose down"
alias ls="sls -cli"

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "kjhaber/tm.zsh"
zplug "ajeetdsouza/zoxide"
zplug "zplug/zplug", hook-build:"zplug --self-manage"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
