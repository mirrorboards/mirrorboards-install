#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-mctl-remote.sh)"

mkdir -p "$HOME/mirrorboards"
curl -o "$HOME/mirrorboards/mirror.toml" https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/maps/mirror.toml

cd "$HOME/mirrorboards"

mctl clone mirror.toml

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-mctl.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-github-mirror.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-fish-functions.sh)"
