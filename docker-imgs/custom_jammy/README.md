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