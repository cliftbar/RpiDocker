# Prep environment for running docker cluster with rpi Clusterhat OTG networking.
# Assumes the docker service is off.
# Run with sudo
systemctl daemon-reload
systemctl start docker
iptables -P FORWARD ACCEPT
