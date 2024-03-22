source /opt/homebrew/opt/zplug/init.zsh

PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

for plugin in \
  "djui/alias-tips" \
  "Aloxaf/fzf-tab" \
  "z-shell/zsh-zoxide" \
  "zsh-users/zsh-syntax-highlighting"
do
    zplug $plugin
done
zplug load

bindkey -v

function mkcd() {
  mkdir $1 && cd $1
}
