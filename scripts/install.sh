#!/usr/bin/env sh
message() {
    printf "\n\e[1;37m%s\e[0m\n" "$1"
}

success() {
    printf "\n\033[1;32m✔ %s\033[0m\n" "$1"
}

info() {
    printf "\n\033[0;34mⓘ %s\033[0m\n" "$1"
}

error_exit() {
    printf "\n\033[1;31m✘ %s, exiting.\033[0m\n" "$1"
    exit 1
}

error_clean() {
    printf "\n\033[1;31m✘ %s, removing ~/.config and MacPorts then exiting.\033[0m\n" "$1"
    rm -rf ~/.config /opts/mports
    exit 1
}

error_clean() {
    printf "\n\033[1;31m✘ %s, removing $HOME/.config and MacPorts then exiting.\033[0m\n" "$1"

    rm -rf "$HOME"/.config /opts/mports "$HOME"/.ssh
    rm -rf "$HOME"/Downloads/Hyperkey0.28.dmg

    if [ -d /Volumes/Hyperkey0.28 ]; then
        hdiutil detach /Volumes/Hyperkey0.28
    fi

    exit 1
}

clone_configuration() {
    message "Checking if $HOME/.config already exists..."

    if [ -d "$HOME"/.config ]; then
        error_exit "$HOME/.config already exists"
    else
        git clone https://github.com/mac-codes9/dotfiles "$HOME"/.config
    fi

    success "Configuration cloned successfully"
}

ports_install() {
    if [ ! -f /opt/local/bin/port ]; then
        message "Installing MacPorts..."
        mkdir -p /opt/mports
        git clone https://github.com/macports/macports-base.git /opt/mports/macports-base
        cd /opt/mports/macports-base
        git checkout v2.9.1
        ./configure --enable-readline
        make
        make install
        make distclean
        sudo port selfupdate
    fi

    success "MacPorts is installed"
}

install_bun() {
    if ! command -v bun; then
        curl -fsSL https://bun.sh/install | bash || error_clean "Error installing bun"
    fi
}

install_doom() {
    message "Installing Doom Emacs..."
    mv /Applications/MacPorts/EmacsMac.app/Contents/MacOS/Emacs /Applications/MacPorts/EmacsMac.app/Contents/MacOS/emacs

    if [ ! -d "$HOME"/.emacs.d ]; then
        git clone https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d || error_clean "Error cloning doom-emacs to $HOME/.emacs.d"
    fi
    
    "$HOME"/.emacs.d/bin/doom install || error_clean "Error running doom install"
    
    success "Doom Emacs installed successfully"
}

tooling_install() {
    message "Installing tooling with MacPorts..."

    sudo echo "export PATH=\"$PATH:/opt/local/bin:$HOME/.bun/bin:$HOME/.emacs.d/bin:/Applications/MacPorts/EmacsMac.app/Contents/MacOS\"" > ~/.profile
    source "$HOME"/.profile
    port install emacs-mac-app fd fzf gh mas ripgrep rust sd || error_clean "Error installing tooling with MacPorts, you may need to run port selfupdate"
    install_bun || error_clean "Error installing bun from script"
    install_doom || error_clean "Error installing Emacs"

    success "Tooling has been installed successfully"
}

post_install() {
    message "Running post install setup..."

    skhd --start-service
    yabai --start-service
    git config --global user.email "maclong9@icloud.com" && git config --global user.name "Mac"
    gh config set git_protocol ssh
    gh auth login

    success "Post install setup complete."
}

main() {
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"

        clone_configuration || error_clean "Failed to clone configuration repository"
        ports_install || error_clean "/opts/mports/macports-base does not exist"
        tooling_install
        post_install || error_exit "Error running post installation setup"

        success "System configuration complete, enjoy."
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
    fi

    success "Configuration setup completed successfully."
}
main

