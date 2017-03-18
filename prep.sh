# Prep environment for running docker cluster.
# Run with sudo
systemctl daemon-reload
systemctl start docker
iptables -P FORWARD ACCEPT
