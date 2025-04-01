#!/bin/bash

# Directory to add to PATH
DIRECTORY="$HOME/mirrorboards/mirrorboards/mirrorboards-go/mirrorboards-cli/bin"

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Directory $DIRECTORY does not exist. Creating it..."
  mkdir -p "$DIRECTORY"
fi

# Detect the current shell
CURRENT_SHELL=$(basename "$SHELL")
echo "Detected shell: $CURRENT_SHELL"

# Handle different shell types
if [ "$CURRENT_SHELL" = "fish" ]; then
  # Fish shell configuration
  FISH_CONFIG_DIR="$HOME/.config/fish"
  FISH_CONFIG_FILE="$FISH_CONFIG_DIR/config.fish"
  
  # Create fish config directory if it doesn't exist
  if [ ! -d "$FISH_CONFIG_DIR" ]; then
    echo "Creating Fish config directory: $FISH_CONFIG_DIR"
    mkdir -p "$FISH_CONFIG_DIR"
  fi
  
  # Create config.fish if it doesn't exist
  if [ ! -f "$FISH_CONFIG_FILE" ]; then
    echo "Creating Fish config file: $FISH_CONFIG_FILE"
    touch "$FISH_CONFIG_FILE"
  fi
  
  # Check if PATH already contains the directory in fish
  if fish -c "echo \$PATH" | tr ' ' '\n' | grep -q "^$DIRECTORY\$"; then
    echo "Directory is already in Fish PATH. No changes made."
  else
    # Add the directory to Fish PATH
    echo "# Added by Mirrorboards CLI setup script" >> "$FISH_CONFIG_FILE"
    echo "fish_add_path $DIRECTORY" >> "$FISH_CONFIG_FILE"
    
    echo "Added $DIRECTORY to PATH in $FISH_CONFIG_FILE"
    echo "To apply changes immediately, run: source $FISH_CONFIG_FILE"
  fi
  
  SHELL_CONFIG="$FISH_CONFIG_FILE"
else
  # Bash/Zsh/other shells configuration
  SHELL_CONFIG=""
  
  # Try to detect based on current shell
  if [ "$CURRENT_SHELL" = "zsh" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
  elif [ "$CURRENT_SHELL" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      SHELL_CONFIG="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      SHELL_CONFIG="$HOME/.bash_profile"
    fi
  fi
  
  # If still empty, check if common config files exist
  if [ -z "$SHELL_CONFIG" ]; then
    if [ -f "$HOME/.zshrc" ]; then
      SHELL_CONFIG="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
      SHELL_CONFIG="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      SHELL_CONFIG="$HOME/.bash_profile"
    elif [ -f "$HOME/.profile" ]; then
      SHELL_CONFIG="$HOME/.profile"
    fi
  fi
  
  # If still empty, default to creating .profile
  if [ -z "$SHELL_CONFIG" ]; then
    SHELL_CONFIG="$HOME/.profile"
    echo "Could not determine shell config file. Creating $SHELL_CONFIG."
    touch "$SHELL_CONFIG"
  fi
  
  echo "Using shell config file: $SHELL_CONFIG"
  
  # Check if PATH already contains the directory
  if echo "$PATH" | tr ':' '\n' | grep -q "^$DIRECTORY\$"; then
    echo "Directory is already in PATH. No changes made."
  else
    # Add the directory to PATH in the shell configuration file
    echo "# Added by Mirrorboards CLI setup script" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:$DIRECTORY\"" >> "$SHELL_CONFIG"
    
    echo "Added $DIRECTORY to PATH in $SHELL_CONFIG"
    echo "To apply changes immediately, run: source $SHELL_CONFIG"
  fi
fi

# Make the script explain what it did
echo "Setup complete!"
echo "The Mirrorboards CLI directory has been added to your PATH."
echo "You can now run Mirrorboards CLI commands from any directory."