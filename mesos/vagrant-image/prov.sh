#!/usr/bin/env sh

# Install dependencies
apt-get update -y
apt-get install -y curl python-setuptools python-pip python-dev python-protobuf

# Install and configure zookeeper
apt-get install -y zookeeperd
echo 1 | dd of=/var/lib/zookeeper/myid

# Installation of Docker
apt-get install docker.io
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
# docker pull libmesos/ubuntu

# Install and configure Mesos 0.19
curl -fL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_0.19.0~ubuntu14.04%2B1_amd64.deb -o /tmp/mesos.deb
dpkg -i /tmp/mesos.deb
mkdir -p /etc/mesos-master
echo in_memory | dd of=/etc/mesos-master/registry
## Mesos Python egg for use in authoring frameworks
curl -fL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos-0.19.0_rc2-py2.7-linux-x86_64.egg -o /tmp/mesos.egg
easy_install /tmp/mesos.egg

# Install and configure Marathon
curl -fL http://downloads.mesosphere.io/marathon/marathon_0.5.0-xcon2_noarch.deb -o /tmp/marathon.deb
dpkg -i /tmp/marathon.deb

# Restart the environment
initctl reload-configuration
start docker.io || restart docker.io
start zookeeper || restart zookeeper
start mesos-master || restart mesos-master
start mesos-slave || restart mesos-slave

# Install and configure Deimos
pip install deimos

# Configure Mesos to use Deimos
mkdir -p /etc/mesos-slave
## Configure Deimos as a containerizer
echo /usr/local/bin/deimos | dd of=/etc/mesos-slave/containerizer_path
echo external              | dd of=/etc/mesos-slave/isolation

# Restart Marathon
initctl reload-configuration
start marathon || restart marathon


## Aurora
curl -sSfLO https://raw2.github.com/mesosphere/aurora_tutorial/master/accp.bash
chmod +x accp.bash
