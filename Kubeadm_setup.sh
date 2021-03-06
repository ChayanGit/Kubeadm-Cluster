#!/bin/bash

sudo apt-get update && sudo apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update

# Disable Swapping
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo apt install docker.io -y

usermod -aG docker ubuntu


systemctl restart docker
systemctl enable docker.service

sudo apt-get update && apt-get install -y kubelet kubeadm kubectl

chmod 700 /etc/docker
rm rf /etc/docker/daemon.json
touch /etc/docker/daemon.json
# Do the folllowing step manuallt in the path /etc/docker/daemon.json
#echo "{"exec-opts": ["native.cgroupdriver=systemd"]}" > /etc/docker/daemon.json

#sudo systemctl daemon-reload
#sudo systemctl restart docker
#sudo systemctl restart kubelet

