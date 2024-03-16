if [ "$(uname -s)" = "Darwin" ]; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
elif [ -d /etc/sv ]; then
    xbps-install -Syu
    xbps-remove -RyoO
fi
