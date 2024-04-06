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
                  /ubuntu/install/chromium/install_chromium.sh \
                  /ubuntu/install/firefox/install_firefox.sh \
                  /ubuntu/install/ansible/install_ansible.sh \
                  /ubuntu/install/terraform/install_terraform.sh \
                  /ubuntu/install/gamepad_utils/install_gamepad_utils.sh \
                  /ubuntu/install/cleanup/cleanup.sh"

# Copy install scripts
COPY ../src/ $INST_DIR

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
USER 1000

######### Customize Container Here ###########

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git make zsh terminator wget python3-pip curl \
    && rm -rf /var/lib/apt/lists/*

# Install PyCharm
RUN wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2024.1.tar.gz \
    && tar -xzf pycharm.tar.gz -C /opt/ \
    && rm pycharm.tar.gz \
    && mv /opt/pycharm-* /opt/pycharm

# Create shortcut for PyCharm on desktop
RUN ln -s /opt/pycharm/bin/pycharm.sh /home/kasm-default-profile/Desktop/pycharm.desktop

# Add text to pycharm.sh desktop file
RUN echo '[Desktop Entry]\nType=Application\nTerminal=true\nName=Pycharm CE\nIcon=utilities-terminal\n' >  \
    /home/kasm-default-profile/Desktop/pycharm.desktop

# Update the wallpaper
RUN wget -O /usr/share/backgrounds/bg_default.png https://i.ibb.co/PzJK7Db/Ubuntu-Dark1.png

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download and run setup script for terminal fonts and p10k
RUN mkdir $HOME/.fonts
RUN wget -O setup_terminal.sh https://github.com/sgtslaughta/kasm_files/blob/main/docker-imgs/install_scripts/p10k_alias.sh \
    && chmod +x setup_terminal.sh \
    && ./setup_terminal.sh

CMD ["zsh"]

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000