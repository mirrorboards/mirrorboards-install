#!/bin/bash

/bin/bash -c "$(curl -H 'Cache-Control: no-cache' -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/scripts/install-mctl-remote.sh)"

mkdir -p "$HOME/mirrorboards"
curl -H 'Cache-Control: no-cache' -o "$HOME/mirrorboards/mirror.toml" https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/maps/mirror.toml

cd "$HOME/mirrorboards"

mctl clone mirror.toml
