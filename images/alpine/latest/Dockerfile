# Alpine Latest
FROM docker.io/library/alpine:latest

SHELL ["/bin/ash", "-c"]

USER 0

RUN apk add --quiet --no-cache \
      bash \
      ca-certificates \
      curl \
      wget \
      cargo \
      python3 \
      nodejs \
      npm \
      make \
      git \
      vim \
      nano \
      locales && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    # Delete package cache to avoid consuming space in layer
    apk cache clean

# Add a user `coder` so that you're not developing as the `root` user
RUN adduser coder \
      -h /home/coder \
      -s /bin/bash \
      -u 1000

USER 1000
