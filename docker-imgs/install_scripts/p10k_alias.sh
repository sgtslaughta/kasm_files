#!/bin/bash

# Clone Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Download MesloLGS NF Regular font
wget -O MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# Install the font and set it as the default font in Terminator
mkdir -p ~/.local/share/fonts
mv MesloLGS\ NF\ Regular.ttf ~/.local/share/fonts/
fc-cache -f -v
gsettings set org.gnome.desktop.interface monospace-font-name 'MesloLGS NF Regular 11'

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

chsh -s /bin/zsh

echo "alias ll='ls -lisa'" >> ~/.zshrc
echo "alias cdl='cdl() { cd "$1" && ls -lisa; }; cdl'" >> ~/.zshrc
