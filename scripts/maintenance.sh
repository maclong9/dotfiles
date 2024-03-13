if [ "$(uname -a)" = "Darwin" ]; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
elif [ "$(uname -a)" = "Linux" ]; then
    xbps-install -Su
    xbps-remove -R
fi
