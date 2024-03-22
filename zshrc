PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

source /opt/homebrew/opt/zplug/init.zsh

for plugin in \
    "belak/zsh-utils" \
    "djui/alias-tips" \
    "Aloxaf/fzf-tab" \
    "z-shell/zsh-zoxide" \
    "zsh-users/zsh-completions" \
    "zdharma-continuum/fast-syntax-highlighting"
do
    zplug $plugin
done

zplug load
