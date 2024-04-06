#!/bin/bash

# Check if /cold_storage exists
if [ -d "/cold_storage" ]; then
    # Create a symbolic link to /cold_storage on the user's desktop
    ln -s "/cold_storage" "$HOME/Desktop/ColdStorageShortcut"
fi