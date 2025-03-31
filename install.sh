#!/bin/bash

set -e

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "Installing mctl (Mirrorboards CLI)..."

# Determine installation directory based on OS
if [ "$(uname)" == "Darwin" ]; then
    # macOS - check if /usr/local/bin exists and is writable
    if [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
        INSTALL_DIR="/usr/local/bin"
    else
        # Try ~/bin as fallback
        INSTALL_DIR="$HOME/bin"
        mkdir -p "$INSTALL_DIR"
    fi
elif [ "$(uname)" == "Linux" ]; then
    # Linux - check if /usr/local/bin exists and is writable
    if [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
        INSTALL_DIR="/usr/local/bin"
    else
        # Try ~/.local/bin as fallback
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
    fi
else
    echo -e "${RED}Unsupported operating system.${NC}"
    exit 1
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Cloning Mirrorboards repository..."
if ! git clone git@github.com:mirrorboards/mirrorboards-go.git; then
    echo -e "${RED}Error: Failed to clone repository. Make sure you have git installed and SSH access to the repository.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Copy the binary
if [ -f "$TEMP_DIR/mirrorboards-go/mirrorboards-cli/bin/mctl" ]; then
    cp "$TEMP_DIR/mirrorboards-go/mirrorboards-cli/bin/mctl" "$INSTALL_DIR/mctl"
    chmod +x "$INSTALL_DIR/mctl"
else
    echo -e "${RED}Error: Binary file not found in the repository.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Clean up
cd - > /dev/null
rm -rf "$TEMP_DIR"

echo -e "${GREEN}Installation complete!${NC}"
echo -e "mctl has been installed to: ${GREEN}$INSTALL_DIR/mctl${NC}"

# Check if the installation directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${RED}Warning: $INSTALL_DIR is not in your PATH.${NC}"
    echo "Add the following to your shell profile:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
fi

echo "You can now run mctl from the command line."
