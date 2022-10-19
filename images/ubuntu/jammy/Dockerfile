# Ubuntu 22.04 LTS (Jammy Jellyfish)
FROM docker.io/library/ubuntu:jammy

SHELL ["/bin/bash", "-c"]

USER 0

# Copy configuration files to appropriate locations
COPY files /

# Install packages from apt repositories
ARG DEBIAN_FRONTEND="noninteractive"
# Ignore other repositories here, as some require HTTPS
RUN apt-get update --quiet --option Dir::Etc::SourceParts="" && \
    # Install packages from official repository or mirror
    apt-get install --yes --quiet --option Dir::Etc::SourceParts="" \
      apt-transport-https \
      bash \
      ca-certificates \
      curl \
      wget \
      cargo \
      git \
      vim \
      nano \
      locales && \
    # Delete package cache to avoid consuming space in layer
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the sudo group
RUN groupadd sudo

# Add a user `coder` so that you're not developing as the `root` user
RUN useradd coder \
      --create-home \
      --shell=/bin/bash \
      --uid=1000 \
      --user-group \
      --groups=sudo

USER 1000