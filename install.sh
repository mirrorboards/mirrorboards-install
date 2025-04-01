#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-mctl-remote.sh)"

mkdir -p "$HOME/mirrorboards"

wget -O "$HOME/mirrorboards/mirror.toml" https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/maps/mirror.toml

cd "$HOME/mirrorboards"

mctl clone mirror.toml
