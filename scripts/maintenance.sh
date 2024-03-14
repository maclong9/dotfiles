if [ "$(uname -s)" = "Darwin" ]; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
elif [ "$(uname -s)" = "Linux" ]; then
    xbps-install -Su
    xbps-remove -R
fi
