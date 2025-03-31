#!/bin/bash

# Run the install scripts in order
./install-mctl.sh
./install-github-mirror.sh
./install-mount-fish-functions.sh

echo "Installation completed successfully!"
