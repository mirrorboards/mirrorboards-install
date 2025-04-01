#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mirrorboards/mirrorboards-install/refs/heads/main/install-mctl-remote.sh)"

mkdir -p "$HOME/mirrorboards"
