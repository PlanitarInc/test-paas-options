#!/usr/bin/env bash

## add mesosphere repo and keys
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
    sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

## update repos
sudo apt-get -yqq update
sudo apt-get install -yqq curl python-setuptools python-pip python-dev python-protobuf

# Zookeeper
sudo apt-get install -yqq zookeeperd
echo 1 | sudo dd of=/var/lib/zookeeper/myid

## Install and run Docker
## http://docs.docker.io/installation/ubuntulinux/ for more details
sudo apt-get install -yqq docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
# docker pull libmesos/ubuntu

# Mesos 0.19
sudo apt-get install mesos marathon deimos
sudo mkdir -p /etc/mesos-master
echo in_memory | sudo dd of=/etc/mesos-master/registry

# Configure Mesos to use Deimos
sudo mkdir -p /etc/mesos-slave
## Configure Deimos as a containerizer
echo /usr/local/bin/deimos | sudo tee /etc/mesos-slave/containerizer_path
echo external | sudo tee /etc/mesos-slave/isolation

# Restart the environment
sudo initctl reload-configuration
sudo restart docker.io
sudo restart zookeeper
sudo restart marathon
sudo restart mesos-master
sudo restart mesos-slave
