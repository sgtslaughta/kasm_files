ARG BASE_TAG="develop"
ARG BASE_IMAGE="core-ubuntu-jammy"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
WORKDIR $HOME

### Envrionment config
ENV DEBIAN_FRONTEND=noninteractive \
    SKIP_CLEAN=true \
    KASM_RX_HOME=$STARTUPDIR/kasmrx \
    DONT_PROMPT_WSL_INSTALL="No_Prompt_please" \
    INST_DIR=$STARTUPDIR/install \
    INST_SCRIPTS="/ubuntu/install/tools/install_tools_deluxe.sh \
                  /ubuntu/install/misc/install_tools.sh \
                  /ubuntu/install/firefox/install_firefox.sh \
                  /ubuntu/install/ansible/install_ansible.sh \
                  /ubuntu/install/terraform/install_terraform.sh \
                  /ubuntu/install/gamepad_utils/install_gamepad_utils.sh \
                  /ubuntu/install/cleanup/cleanup.sh"

# Copy install scripts
COPY ./src $INST_DIR

# Run installations
RUN \
  for SCRIPT in $INST_SCRIPTS; do \
    bash ${INST_DIR}${SCRIPT} || exit 1; \
  done && \
  $STARTUPDIR/set_user_permission.sh $HOME && \
  rm -f /etc/X11/xinit/Xclients && \
  chown 1000:0 $HOME && \
  mkdir -p /home/kasm-user && \
  chown -R 1000:0 /home/kasm-user && \
  rm -Rf ${INST_DIR}

# Userspace Runtime
ENV HOME /home/kasm-user
WORKDIR $HOME
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Remove the desktop shortcuts
RUN rm -f /home/kasm-default-profile/Desktop/*.desktop

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git make zsh terminator wget python3-pip curl chromium-browser sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies and download Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gpg \
 && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update && apt-get install -y \
    google-chrome-stable \
 && rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the Chrome binary path as an environment variable (optional)
ENV CHROME_BIN /usr/bin/google-chrome

# Set the default browser to Chrome
RUN update-alternatives --install /usr/bin/x-www-browser x-www-browser $CHROME_BIN 200 \
    && update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser $CHROME_BIN 200

# Install PyCharm
RUN wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2024.1.tar.gz \
    && tar -xzf pycharm.tar.gz -C /opt/ \
    && rm pycharm.tar.gz \
    && mv /opt/pycharm-* /opt/pycharm

ENV PC_PATH=/opt/pycharm/bin
ENV PC_CMD='${PC_PATH}/pycharm.sh &'
# Add text to pycharm.sh desktop file
RUN echo "[Desktop Entry]\nType=Application\nName=Pycharm CE\nIcon=${PC_PATH}/pycharm.svg\nExec=/bin/bash -c '${PC_CMD}'" >  \
    /home/kasm-default-profile/Desktop/pycharm.desktop \
    && chmod +x /home/kasm-default-profile/Desktop/pycharm.desktop

# Update the wallpaper
COPY ./custom_jammy/wallpapers/crt.png /usr/share/backgrounds/bg_default.png

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Copy the zshrc file to the home directory
COPY ./custom_jammy/p10k-config/.p10k.zsh $HOME/.p10k.zsh
COPY ./custom_jammy/p10k-config/.zshrc $HOME/.zshrc

# Download and run setup script for terminal fonts and p10k
RUN mkdir $HOME/.fonts
RUN wget -O setup_terminal.sh https://raw.githubusercontent.com/sgtslaughta/kasm_files/main/docker-imgs/install_scripts/p10k_alias.sh \
    && chmod +x setup_terminal.sh \
    && ./setup_terminal.sh

CMD ["zsh"]

# Copy the readme file to the desktop
COPY ./custom_jammy/README.md /home/kasm-default-profile/Desktop/README.txt

# Grab the cold storage check script
RUN wget -O /cold_storage_check.sh https://raw.githubusercontent.com/sgtslaughta/kasm_files/main/docker-imgs/install_scripts/cold_storage_check.sh \
    && chmod +x /cold_storage_check.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

RUN sudo chsh -s /bin/zsh kasm-user

# Open a shell when the user logs in
CMD ["zsh"]


