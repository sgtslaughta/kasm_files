# What is this?
This is a custom image for Ubuntu 22.04 (Jammy Jellyfish) with some additional packages installed.
Starting from the raw ubuntu image, we add the minimal Kasm Workspaces dependencies and some additional packages.

- Firefox
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
- On first login, right-click the desktop and open a terminal
    - This will run the terminal setup script, setting dark mode and mounting the persistent storage (if present).
- Useful aliases the `.zshrc` file.
    - `cd` change dir and list it
    - `l` list all files with details
    - `c` clear the terminal
    - `h` show history
    - `gh` grep history
- To rerun the terminal setup, run `p10k configure`.