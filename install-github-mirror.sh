#!/bin/bash

# Clone the GitHub mirror repository into $HOME/github-mirror
echo "Cloning mirrorboards/github-mirror into $HOME/github-mirror..."

# Create the directory if it doesn't exist
mkdir -p "$HOME/github-mirror"

# Clone the repository
git clone https://github.com/mirrorboards/github-mirror.git "$HOME/github-mirror"

echo "Repository successfully cloned to $HOME/github-mirror"

# Run the mirror.sh script
echo "Running mirror.sh..."
cd "$HOME/github-mirror" && ./mirror.sh
