#!/bin/bash

# Define path variables
SOURCE_DIR="$HOME/mirrorboards/mirrorboards/mirrorboards-utils/mirrorboards-utils-fish"
TARGET_DIR="$HOME/.config/fish/functions"
BACKUP_DIR="$HOME/.config/fish/functions-prev"

echo "Mounting mirrorboards-utils-fish to fish functions folder..."

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory does not exist: $TARGET_DIR"
    echo "Creating target directory..."
    mkdir -p "$TARGET_DIR"
fi

# Backup existing functions if they exist and target is not a symlink already
if [ -d "$TARGET_DIR" ] && [ ! -L "$TARGET_DIR" ]; then
    echo "Backing up existing functions to $BACKUP_DIR..."
    
    # Remove old backup if it exists
    if [ -d "$BACKUP_DIR" ] || [ -L "$BACKUP_DIR" ]; then
        rm -rf "$BACKUP_DIR"
    fi
    
    # Move current functions to backup
    mv "$TARGET_DIR" "$BACKUP_DIR"
fi

# Remove existing symlink if it's pointing to the wrong location
if [ -L "$TARGET_DIR" ] && [ "$(readlink "$TARGET_DIR")" != "$SOURCE_DIR" ]; then
    echo "Removing existing symlink..."
    rm -f "$TARGET_DIR"
fi

# Create the symlink if it doesn't exist or was removed
if [ ! -e "$TARGET_DIR" ]; then
    echo "Creating symbolic link from $SOURCE_DIR to $TARGET_DIR..."
    ln -s "$SOURCE_DIR" "$TARGET_DIR"
fi

# Verify the link was created successfully
if [ -L "$TARGET_DIR" ] && [ "$(readlink "$TARGET_DIR")" = "$SOURCE_DIR" ]; then
    echo "Success: Mirrorboards utils fish functions mounted successfully!"
    if [ -d "$BACKUP_DIR" ]; then
        echo "Original functions backed up to: $BACKUP_DIR"
    fi
else
    echo "Error: Failed to create symbolic link."
    if [ -d "$BACKUP_DIR" ]; then
        echo "Restoring original functions..."
        rm -f "$TARGET_DIR"
        mv "$BACKUP_DIR" "$TARGET_DIR"
    fi
    exit 1
fi