FROM kasmweb/ubuntu-jammy-dind:1.14.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    make \
    zsh \
    terminator \
    wget \
    libxtst6 \
    libxext6 \
    libxrender-dev \
    libxi6 \
    libxrandr2 \
    libxinerama1 \
    libfontconfig1 \
    libfreetype6 \
    libgtk-3-0 \
    libgbm1 \
    libnss3 \
    libxss1 \
    libasound2 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install PyCharm
RUN wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2024.1.tar.gz \
    && tar -xzf pycharm.tar.gz -C /opt/ \
    && rm pycharm.tar.gz \
    && mv /opt/pycharm-* /opt/pycharm

# Create shortcut for PyCharm on desktop
RUN ln -s /opt/pycharm/bin/pycharm.sh /home/kasm-default-profile/Desktop/pycharm.sh

# Add text to pycharm.sh desktop file
RUN echo '[Desktop Entry]\nType=Application\nTerminal=true\nName=Pycharm CE\nIcon=utilities-terminal\nEx>

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download and run setup script for terminal fonts and p10k
RUN mkdir $HOME/.fonts
RUN wget -O setup_terminal.sh https://github.com/sgtslaughta/kasm_files/blob/main/p10k_alias.sh
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
