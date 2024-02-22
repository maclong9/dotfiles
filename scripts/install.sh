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
    printf "\n\033[1;31m✘ %s, removing $HOME/.config and brew then exiting.\033[0m\n" "$1"

    rm -rf "$HOME"/.config /opt/homebrew "$HOME"/.ssh

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

install_bun() {
    if ! command -v bun > /dev/null; then
        curl -fsSL https://bun.sh/install | bash || error_clean "Error installing bun"
    fi
}

install_doom() {
    message "Installing Doom Emacs..."
    
    if [ ! -d "$HOME"/.emacs.d ]; then
        git clone https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d || error_clean "Error cloning doom-emacs to $HOME/.emacs.d"
    fi
    
    "$HOME"/.emacs.d/bin/doom install || error_exit "Error running doom install"
    
    success "Doom Emacs installed successfully"
}

tooling_install() {
    message "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    printf 'eval %s\n/export PATH="$PATH:Applications/Emacs.app/Contents/MacOS"' "$(/opt/homebrew/bin/brew shellenv)" > "$HOME"/.zprofile
    mv /Applications/Emacs.app/Contents/MacOS/Emacs /Applications/Emacs.app/Contents/MacOS/emacs
    . "$HOME"/.zprofile
    message "Installing tooling with Brew..."
    brew install homebrew/cask/emacs fd fzf gh hyperkey mas ripgrep rust sd koekeishiya/formulae/skhd koekeishiya/formulae/yabai zig || error_clean "Error installing tooling with Brew"
    mas install 1436953057
    install_bun || error_clean "Error installing bun from script"
    install_doom || error_clean "Error installing Emacs"

    success "Tooling has been installed successfully"
}

configure_git() {
    message "Configuring Git"
    git config --global user.email "maclong9@icloud.com"
    git config --global user.name "Mac"
    git config --global push.default current
    git config --global init.defaultBranch main
    git config --global merge.conflictStyle zdiff3
    git config --global help.autocorrect 30
    git config --global rebase.autosquash true
    gh config set git_protocol ssh
    gh auth login
    success "Git configured successully"
  }

post_install() {
    yabai --start-service
    skhd --start-service
    configure_git || error_exit "Error configuring git"
}

main() {
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"

        clone_configuration || error_clean "Failed to clone configuration repository"
        tooling_install
        post_install

        success "System configuration complete, enjoy."
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
    fi

    success "Configuration setup completed successfully."
}
main

