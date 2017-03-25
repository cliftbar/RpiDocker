FROM resin/rpi-raspbian:jessie

# Install development packages
RUN apt-get update && \
    apt-get install -y apt-utils curl nano wget inetutils-ping dnsutils && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/*
