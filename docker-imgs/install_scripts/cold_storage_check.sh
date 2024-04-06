#!/bin/zsh

# Check if /cold_storage exists
if [ -d "/cold_storage" ]; then
    # Create a symbolic link to /cold_storage on the user's desktop
    ln -s "/cold_storage" "$HOME/Desktop/cold_storage"
fi

# Set the Greybird-dark theme
xfconf-query -c xsettings -p /Net/ThemeName -s 'Greybird-dark'
