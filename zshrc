PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

source /opt/homebrew/opt/zplug/init.zsh

for plugin in \
    "belak/zsh-utils" \
    "MichaelAquilina/zsh-you-should-use" \
    "z-shell/zsh-zoxide" \
    "zsh-users/zsh-completions" \
    "zsh-users/zsh-syntax-highlighting"
do
    zplug $plugin
done

zplug load
bindkey -v
