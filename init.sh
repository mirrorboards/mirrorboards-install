#!/bin/bash

# Create mirrorboards directory in home folder if it doesn't exist
mkdir -p "$HOME/mirrorboards"

# Download the .mirror.toml file from GitHub to the created directory
curl -s https://raw.githubusercontent.com/mirrorboards/init/refs/heads/main/maps/.mirror.toml -o "$HOME/mirrorboards/.mirror.toml"

# Change to the mirrorboards directory and run mctl clone command
cd "$HOME/mirrorboards" && mctl clone .mirror.toml

echo "Initialization complete!"
