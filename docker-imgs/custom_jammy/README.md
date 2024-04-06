# What is this?
This is a custom image for Ubuntu 22.04 (Jammy Jellyfish) with some additional packages installed.
Starting from the raw ubuntu image, we add the minimal Kasm Workspaces dependencies and some additional packages.

- Firefox
- Chromium
- Pycharm
- Terminator
- Zsh with the Powerlevel10k theme
- Custom wallpaper

### TO build the image
```
# FROM the docker-imgs directory
sudo docker build -f custom_jammy/Dockerfile -t <some_name>:<some_tag_ver> .
```
This will build the image locally. Inside the Kasm admin panel, you will specify the image name and tag.

### Using the image
- The first time you use the terminal, you will be prompted to set up Zsh. Follow the instructions to set up the Powerlevel10k theme.
- Enable persistent sessions to retain your settings between sessions.
- If the persistent storage is enabled, you can usually find it at `/mnt/share/`.
- `chmod -R go-w /home/kasm-user/.oh-my-zsh` to clear the warning about insecure directories when using zsh.
- Useful aliases the `.zshrc` file.
    - `cdl` change dir and list it
    - `l` list all files with details
    - `c` clear the terminal
- To rerun the terminal setup, run `p10k configure`.