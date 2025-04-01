#!/bin/bash

/bin/bash -c "$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-mctl-remote.sh)"

mkdir -p "$HOME/mirrorboards"
curl -H 'Cache-Control: no-cache' -o "$HOME/mirrorboards/mirror.toml" https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/maps/mirror.toml

cd "$HOME/mirrorboards"

mctl clone mirror.toml

/bin/bash -c "$(curl -H 'Cache-Control: no-cache' -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/scripts/install-mctl.sh)"
/bin/bash -c "$(curl -H 'Cache-Control: no-cache' -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/scripts/install-github-mirror.sh)"
/bin/bash -c "$(curl -H 'Cache-Control: no-cache' -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/scripts/install-fish-functions.sh)"
