#!/usr/bin/env sh
tooling="emacs-mac-app fd fzf mas ripgrep rust sd wget zig"
apps="1436953057 424390742 424389933 1436953057 1534275760 634148309 634159523 43420957 1289583905 497799835"

trap 'cleanup' INT TERM
        
success() {
    printf "\n\033[1;32m✔ %s\033[0m\n\n" "$1"
}

info() {
    printf "\n\033[0;34mⓘ %s\033[0m\n\n" "$1"
}

message() {
    printf "\n\n\e[1;37m%s\e[0m\n\n" "$1"
}

error_exit() {
    printf "\n\n\033[1;31m✘ %s, exiting.\033[0m\n" "$1"
    exit 1
}

cleanup() {
    message "Exiting...\n"
    sudo rm -rf /opt/mports ~/.config
    exit 0
}

clone_configuration() {
    message "Checking if ~/.config already exists...\n"

    if [ -d ~/.config ]; then
        error_exit "$HOME/.config already exists\n"
    else
        git clone https://github.com/mac-codes9/dotfiles ~/.config || error_exit "Failed to clone configuration repository"
    fi

    success "Configuration cloned successfully"
}

ports_install() {
    if ! command -v ports > /dev/null; then
        message "Installing MacPorts..."
       
        mkdir -p /opt/mports
        git clone https://github.com/macports/macports-base.git /opt/mports/
        cd /opt/mports/macports-base || error_exit "/opts/mports/macports-base does not exist"
        ./configure --enable-readline
        make
        sudo make install
        make distclean
    fi
    success "MacPorts is installed"
}

install_hyperkey() {
    message "Installing Hyperkey..."
    
    curl -LO https://hyperkey.app/downloads/Hyperkey0.28.dmg
    hdiutil attach .dmg
    sudo cp -R "/Volumes/Hyperkey0.28/Hyperkey.app" /Applications
    
    hdiutil detach /Volumes/Hyperkey0.28
}

tooling_install() {
    message "Installing tooling with MacPorts..."
   
    sudo port install "$tooling" || error_exit "Error installing tooling with MacPorts"
    curl -fsSL https://bun.sh/install | bash || error_exit "Error installing bun"
    emacs_install || error_exit "Error installing Emacs"
    
    success "Tooling has been installed successfully"
}

app_install() {
    message "Installing Applications with mas..."
   
    sudo mas install "$apps" || error_exit "Error installing applications with mas"
  
    success "Applications have been installed"
}

ssh_setup() {
  message "Configuring SSH..."
  
  ssh-keygen -t ed25519 -C "maclong9@icloud.com" -f ~/.ssh/mac-mb
  eval "$(ssh-agent -s)"
  echo '''
  Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_mac-mb
  ''' > ~/.ssh/config
  ssh-add --apple-use-keychain ~/.ssh/mac-mb
  pbcopy < ~/.ssh/id_mac-mb.pub

  info "Your public key has been copied to your clipboard, make sure to add it to your remote repository provider"
  success "SSH configured successfully"
}

post_install() {
    message "Running post install setup..."
    
    skhd --start-service
    yabai --start-service
    open -a /Applications/Hyperkey.app
    open -a /Applications/Linear.app
    git config --global user.email "maclong9@icloud.com" && git config --global user.name "Mac"
    ssh_setup
    
    success "Post install setup complete."
}

main() {
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"
        
        clone_configuration
        ports_install
        tooling_install
        app_install
        post_install

        success "System configuration complete, enjoy."
    else
        error_exit "Running on unsupported system"
    fi

    success "Configuration setup completed successfully."
}
main
