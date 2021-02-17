#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install  -y docker-ce docker-ce-cli containerd.io
sudo mkdir /srv/nexus
sudo chmod 600 /srv/nexus

export GITLAB_HOME=/srv/gitlab

sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count = 262144" >> /etc/sysctl.conf

