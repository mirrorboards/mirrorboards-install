#!/bin/bash

# Create mirrorboards directory in home folder if it doesn't exist
mkdir -p "$HOME/mirrorboards"

# Copy the .mirror.toml file to the created directory
cp ./maps/.mirror.toml "$HOME/mirrorboards"

# Change to the mirrorboards directory and run mctl clone command
cd "$HOME/mirrorboards" && mctl clone .mirror.toml

echo "Initialization complete!"
