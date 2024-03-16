title="Maintenance"
complete_message="System maintenance complete"
if [ "$(uname -s)" = "Darwin" ]; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
    osascript -e "display notification \"$complete_message\" with title \"$title\""
elif [ -d /etc/sv ]; then
    xbps-install -Syu
    xbps-remove -RyoO
    notify-send $title $complete_message
fi
