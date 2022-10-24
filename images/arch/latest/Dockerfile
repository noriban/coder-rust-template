# Arch Linux (Rolling)
FROM docker.io/library/archlinux:latest

SHELL ["/bin/bash", "-c"]

USER 0

# Install needed packages
RUN pacman -Syyu --noconfirm --quiet --noprogressbar \
      bash \
      ca-certificates \
      curl \
      wget \
      cargo \
      gcc \
      nodejs-lts-gallium \
      npm \
      make \
      git \
      vim \
      nano && \
    # Delete package cache to avoid consuming space in layer
    pacman -Scc

# Add a user `coder` so that you're not developing as the `root` user
RUN useradd coder \
      --create-home \
      --shell=/bin/bash \
      --uid=1000 \
      --user-group

USER 1000

# Now install code-server
RUN wget https://code-server.dev/install.sh -P /home/coder/ && \
    chmod +x /home/coder/install.sh && \
    /home/coder/install.sh --method standalone && \
    rm /home/coder/install.sh