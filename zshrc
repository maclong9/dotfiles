# Options
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

# Aliases
alias g="git"
alias ls="ls --color"
alias la="ls -a"
alias sys="~/.config/scripts/fetch.sh"

# Void Linux Session Start
if [ -d /etc/sv ] && [ "$(tty)" = "/dev/tty1" ]; then
    RUN_DIR=/run/user/$(id -u)
    sudo mkdir -p $RUN_DIR
    sudo chown mac $RUN_DIR

    export MOZ_ENABLE_WAYLAND=1
    export MOZ_WEBRENDER=1
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_RUNTIME_DIR=$RUN_DIR

    dbus-run-session -- sway
fi
