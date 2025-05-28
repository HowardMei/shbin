#!/usr/bin/env bash

# Bootstrap Installation Script for shbin
# Author: HowardMei
# Date: 2025-05-13

# Function to display messages
function log_message() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

function log_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check for required commands
function check_command() {
    if ! command -v "$1" &>/dev/null; then
        log_error "$1 is required but not installed. Please install it first."
        exit 1
    fi
}

# Install script
function wget_install_shbin() {
    log_message "Starting installation of shbin..."

    # Step 1: Download the repository archive to /tmp
    REPO_URL="https://github.com/HowardMei/shbin/archive/refs/heads/main.tar.gz"
    INSTALL_DIR="${HOME}/.shbin"
    TEMP_ARCHIVE="/tmp/shbin.tar.gz"

    if [[ ! -d "$INSTALL_DIR" ]]; then
        log_message "shbin will be installed in $INSTALL_DIR."
    else
        log_message "Removing old version shbin in $INSTALL_DIR."
        rm -rf "$INSTALL_DIR"
    fi

        log_message "Downloading shbin repository archive..."
        wget -O "$TEMP_ARCHIVE $REPO_URL"

        log_message "Extracting shbin archive to $INSTALL_DIR..."
        mkdir -p "$INSTALL_DIR"
        tar -xzf "$TEMP_ARCHIVE" --strip-components=1 -C /tmp/shbins
        mv -f /tmp/shbins/shbin "$INSTALL_DIR"

    # Step 2: Copy shdot and shsec to $HOME
    DOTFILES_DIR="/tmp/shbins/shdot"
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_message "Copying shdot files to home directory..."
        ##cp -rf "${DOTFILES_DIR}"/ "$HOME"/
        "${DOTFILES_DIR}"/cpdot.sh
    else
        log_error "Dotfiles directory not found in $DOTFILES_DIR. Skipping shdot files setup."
    fi
    SECFILES_DIR="/tmp/shbins/shsec"
    if [[ -d "$SECFILES_DIR" ]]; then
        log_message "Copying shsec files to home directory..."
        ##cp -rf "${DOTFILES_DIR}"/ "$HOME"/
        "${SECFILES_DIR}"/cpsec.sh
    else
        log_error "Secfiles directory not found in $SECFILES_DIR. Skipping shsec files setup."
    fi
    log_message "Cleaning up temporary files..."
    rm -f "$TEMP_ARCHIVE"
    rm -rf /tmp/shbins

    # Step 3: Set execute permissions
    log_message "Setting execute permissions..."
    chmod -R a+x "$INSTALL_DIR"

    # Step 4: Add shbin to PATH
    log_message "Adding shbin to PATH in .bash_profile..."
    if ! grep -q "shbin" "$HOME"/.bash_profile; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>"$HOME"/.bash_profile
        log_message "shbin added to PATH."
    else
        log_message "shbin already in PATH."
    fi

    # Step 5: Source .bash_profile
    log_message "Sourcing .bash_profile..."
    source "$HOME"/.bash_profile

    log_message "Installation completed successfully!"
}


function git_install_shbin() {
    log_message "Starting installation of shbin..."

    # Step 1: Clone the repository
    REPO_URL="https://github.com/HowardMei/shbin.git"
    INSTALL_DIR="${HOME}/.shbin"
    if [[ ! -d "$INSTALL_DIR" ]]; then
        log_message "shbin will be installed in $INSTALL_DIR."
    else
        log_message "Removing old version shbin in $INSTALL_DIR."
        rm -rf "$INSTALL_DIR"
    fi

        log_message "Cloning shbin repository into /tmp/shbins..."
        git clone "$REPO_URL" /tmp/shbins
        mv -f /tmp/shbins/shbin "$INSTALL_DIR"

    # Step 2: Copy shdot and shsec to $HOME
    DOTFILES_DIR="/tmp/shbins/shdot"
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_message "Copying shdot files to home directory..."
        ##cp -rf "${DOTFILES_DIR}"/ "$HOME"/
        "${DOTFILES_DIR}"/cpdot.sh
    else
        log_error "Dotfiles directory not found in $DOTFILES_DIR. Skipping shdot files setup."
    fi
    SECFILES_DIR="/tmp/shbins/shsec"
    if [[ -d "$SECFILES_DIR" ]]; then
        log_message "Copying shsec files to home directory..."
        ##cp -rf "${DOTFILES_DIR}"/ "$HOME"/
        "${SECFILES_DIR}"/cpsec.sh
    else
        log_error "Secfiles directory not found in $SECFILES_DIR. Skipping shsec files setup."
    fi
    log_message "Cleaning up temporary files..."
    rm -f "$TEMP_ARCHIVE"
    rm -rf /tmp/shbins

    # Step 3: Set execute permissions
    log_message "Setting execute permissions..."
    chmod -R a+x "$INSTALL_DIR"

    # Step 4: Add shbin to PATH
    log_message "Adding shbin to PATH in .bash_profile..."
    if ! grep -q "shbin" "$HOME"/.bash_profile; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>"$HOME"/.bash_profile
        log_message "shbin added to PATH."
    else
        log_message "shbin already in PATH."
    fi

    # Step 5: Source .bash_profile
    log_message "Sourcing .bash_profile..."
    source "$HOME"/.bash_profile

    log_message "Installation completed successfully!"
}

# Main
function main() {
    log_message "Checking for required commands..."
    check_command grep
    check_command tar
    if ! command -v git &>/dev/null; then
        wget_install_shbin
    else
        git_install_shbin
    fi
}

# Execute the script!
main "$@"