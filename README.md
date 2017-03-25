# RpiDocker
repo of docker images to run in a docker swarm consisting of a RPi 3 (master) and 4 RPi Zeros networked using a [ClusterHat](https://clusterhat.com/)

## rpi-devbase
A docker image from raspbian jessie to serve as a base for all the raspberry pi images.  This base allows for running on ARM (Zeros) and ARMv7 (RPi 2/3)
Some nice to have dev tools are installed here for working in the images.

## rpi-openjdk
Image with openjdk, because that takes forever to install when building images.

## rpi-haproxy
Image with a configuration for the spark cluster.  Built off of [armhf/haproxy](https://hub.docker.com/r/armhf/haproxy/)

## rpi-spark
Image to serve as a spark worker or master, depending on the startup script.  Based off https://github.com/afritzler/docker-spark-arm, with changes to allow for running on raspberrypi zeros
