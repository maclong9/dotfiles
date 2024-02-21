#!/usr/bin/env sh
tooling="emacs-mac-app fd fzf mas ripgrep rust sd wget zig"
#apps="1436953057 424390742 424389933 1436953057 1534275760 634148309 634159523 43420957 1289583905 497799835"
apps="1289583905"

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
    rm -rf ~/.config /opts/mports ~/.ssh
    rm -rf ~/Downloads/Hyperkey0.28.dmg

    if [ -d "/Volumes/Hyperkey0.28" ]; then
        hdiutil detach /Volumes/Hyperkey0.28
    fi
    
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
        ./configure --enable-readline
        make
        make install
        make distclean
    fi
    
    echo 'export PATH="/opt/local/bin:$PATH"' > ~/.profile
    source ~/.profile
    success "MacPorts is installed"
}

install_hyperkey() {
    message "Installing Hyperkey..."
    
    curl -LO https://hyperkey.app/downloads/Hyperkey0.28.dmg
    hdiutil attach "$HOME"/Downloads/Hyperkey0.28.dmg
    cp -R /Volumes/Hyperkey0.28/Hyperkey.app /Applications
    hdiutil detach /Volumes/Hyperkey0.28
    rm -rf "$HOME"/Downloads/Hyperkey0.28.dmg

    success "Hyperkey installed successfully"
}

install_sioyek() {
    message "Installing Sioyek..."
    
    curl -LO https://github.com/ahrm/sioyek/releases/download/v2.0.0/sioyek-release-mac.zip
    unzip sioyek-release-mac.zip
    hdiutil attach "$HOME"/Downloads/build/sioyek.dmg
    cp -R /Volumes/build:sioyek/Sioyek.app /Applications
    hdiutil detach /Volumes/build:sioyek
    rm -rf "$HOME"/Downloads/build

    success "Sioyek installed successfully"
}

emacs_install() {
    message "Installing Doom Emacs..."
    
    git clone https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d || error_clean "Error cloning doom-emacs to $HOME/.emacs.d"
    "$HOME"/.emacs.d/bin/doom install || error_clean "Error running doom install" 
    sips -i https://github.com/SavchenkoValeriy/emacs-icons/blob/main/curvy-blender/Emacs.icns /Applications/Emacs.app/Contents/Resources/AppIcon.icns || error_clean "Error changing Emacs icon"

    success "Doom Emacs installed successfully"
}

tooling_install() {
    message "Installing tooling with MacPorts..."
   
    port install "${@:tooling}" || error_clean "Error installing tooling with MacPorts"
    curl -fsSL https://bun.sh/install | bash || error_clean "Error installing bun"
    emacs_install || error_clean "Error installing Emacs"
    
    success "Tooling has been installed successfully"
}

app_install() {
    message "Installing Applications with mas..."
    
    mas install "${@:apps}" || error_clean "Error installing applications with mas"
    install_hyperkey || error_clean "Error installing Hyperkey"
    
    success "Applications have been installed"
}

ssh_setup() {
  message "Configuring SSH..."
  
  ssh-keygen -t ed25519 -C "maclong9@icloud.com" -f "$HOME"/.ssh/mac-mb
  eval "$(ssh-agent -s)"
  echo "
  Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $HOME/.ssh/id_mac-mb
  " > "$HOME"/.ssh/config
  ssh-add --apple-use-keychain "$HOME"/.ssh/mac-mb
  pbcopy < "$HOME"/.ssh/id_mac-mb.pub

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
        
        clone_configuration || error_clean "Failed to clone configuration repository"
        ports_install || error_clean "/opts/mports/macports-base does not exist"
        tooling_install 
        app_install
        post_install || error_exit "Error running post installation setup"

        success "System configuration complete, enjoy."
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
    fi

    success "Configuration setup completed successfully."
}
main
