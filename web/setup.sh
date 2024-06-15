#!/bin/bash

# This content was generated in whole or part with the assistance of an AI model.

# Function to check and load nvm
function load_nvm {
    # Try to source nvm from the most common installation paths
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
        source "/usr/local/opt/nvm/nvm.sh"
    elif [ -s "$HOME/.nvm/nvm.sh" ]; then
        source "$HOME/.nvm/nvm.sh"
    elif [ -s "$HOME/.config/nvm/nvm.sh" ]; then
        source "$HOME/.config/nvm/nvm.sh"
    else
        echo "nvm is not installed or cannot be found. Please install nvm and run this script again."
        exit 1
    fi
}

# Function to install Node.js version specified in .nvmrc or use the latest LTS version
function install_node {
    if [ -f ".nvmrc" ]; then
        nvm install $(cat .nvmrc)
    else
        nvm install --lts
    fi
}

# Function to install dependencies for a given directory
function install_dependencies {
    local dir=$1
    if [ -f "$dir/package.json" ]; then
        echo "Installing dependencies in $dir"
        cd $dir
        npm install
        cd - > /dev/null
    fi
}

# Function to clean dependencies and temporary files for a given directory
function clean_dependencies {
    local dir=$1
    if [ -d "$dir/node_modules" ]; then
        echo "Removing node_modules in $dir"
        rm -rf "$dir/node_modules"
    fi
    if [ -f "$dir/package-lock.json" ]; then
        echo "Removing package-lock.json in $dir"
        rm -f "$dir/package-lock.json"
    fi
    if [ -d "$dir/build" ]; then
        echo "Removing build directory in $dir"
        rm -rf "$dir/build"
    fi
    if [ -d "$dir/dist" ]; then
        echo "Removing dist directory in $dir"
        rm -rf "$dir/dist"
    fi
    if [ -d "$dir/.cache" ]; then
        echo "Removing .cache directory in $dir"
        rm -rf "$dir/.cache"
    fi
}

# Main script
function main {
    # Ensure NVM_DIR is set if not already
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    
    load_nvm

    if [ "$1" == "--clean" ]; then
        clean_dependencies "backend"
        clean_dependencies "frontend"
        echo "All dependencies and temporary files have been cleaned."
    else
        # Install Node.js version
        install_node

        # Install dependencies
        install_dependencies "backend"
        install_dependencies "frontend"
        
        echo "All dependencies have been installed."
    fi
}

main "$@"