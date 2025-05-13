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
    if ! command -v $1 &>/dev/null; then
        log_error "$1 is required but not installed. Please install it first."
        exit 1
    fi
}

# Install script
function wget_install_shbin() {
    log_message "Starting installation of shbin..."

    # Step 1: Download the repository archive
    REPO_URL="https://github.com/HowardMei/shbin/archive/refs/heads/main.tar.gz"
    INSTALL_DIR="${HOME}/.shbin"
    TEMP_ARCHIVE="/tmp/shbin.tar.gz"

    if [[ ! -d "$INSTALL_DIR" ]]; then
        log_message "Downloading shbin repository archive..."
        wget -O $TEMP_ARCHIVE $REPO_URL

        log_message "Extracting shbin archive to $INSTALL_DIR..."
        mkdir -p $INSTALL_DIR
        tar -xzf $TEMP_ARCHIVE --strip-components=1 -C $INSTALL_DIR

        log_message "Cleaning up temporary files..."
        rm -f $TEMP_ARCHIVE
    else
        log_message "shbin is already installed in $INSTALL_DIR."
    fi

    # Step 2: Set execute permissions
    log_message "Setting execute permissions..."
    chmod -R a+x $INSTALL_DIR

    # Step 3: Copy dotfiles
    DOTFILES_DIR="${INSTALL_DIR}/shdot"
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_message "Copying dotfiles to home directory..."
        cp -rf ${DOTFILES_DIR}/.* $HOME/
    else
        log_error "Dotfiles directory not found in $DOTFILES_DIR. Skipping dotfiles setup."
    fi

    # Step 4: Add shbin to PATH
    log_message "Adding shbin to PATH in .bash_profile..."
    if ! grep -q "shbin" $HOME/.bash_profile; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>$HOME/.bash_profile
        log_message "shbin added to PATH."
    else
        log_message "shbin already in PATH."
    fi

    # Step 5: Source .bash_profile
    log_message "Sourcing .bash_profile..."
    source $HOME/.bash_profile

    log_message "Installation completed successfully!"
}


function git_install_shbin() {
    log_message "Starting installation of shbin..."

    # Step 1: Clone the repository
    REPO_URL="https://github.com/HowardMei/shbin.git"
    INSTALL_DIR="${HOME}/.shbin"
    if [[ ! -d "$INSTALL_DIR" ]]; then
        log_message "Cloning shbin repository into $INSTALL_DIR..."
        git clone $REPO_URL $INSTALL_DIR
    else
        log_message "shbin is already cloned in $INSTALL_DIR."
    fi

    # Step 2: Set execute permissions
    log_message "Setting execute permissions..."
    chmod -R a+x $INSTALL_DIR

    # Step 3: Copy dotfiles
    DOTFILES_DIR="${INSTALL_DIR}/shdot"
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_message "Copying dotfiles to home directory..."
        cp -rf ${DOTFILES_DIR}/.* $HOME/
    else
        log_error "Dotfiles directory not found in $DOTFILES_DIR. Skipping dotfiles setup."
    fi

    # Step 4: Add shbin to PATH
    log_message "Adding shbin to PATH in .bash_profile..."
    if ! grep -q "shbin" $HOME/.bash_profile; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>$HOME/.bash_profile
        log_message "shbin added to PATH."
    else
        log_message "shbin already in PATH."
    fi

    # Step 5: Source .bash_profile
    log_message "Sourcing .bash_profile..."
    source $HOME/.bash_profile

    log_message "Installation completed successfully!"
}

# Main
function main() {
    log_message "Checking for required commands..."
    check_command chmod
    check_command cp
    if ! command -v git &>/dev/null; then
        wget_install_shbin
    else
        git_install_shbin
    fi
}

# Execute the script!
main "$@"