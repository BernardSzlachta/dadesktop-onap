#!/bin/bash

# KUBECTL:
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg
[ -d /etc/apt/keyrings ] || mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly
apt-get update
apt-get install -y kubectl
echo 'source /etc/bash_completion' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc

# DOCKER:
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/containerd.io_1.6.31-1_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-buildx-plugin_0.14.0-1~ubuntu.22.04~jammy_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-compose-plugin_2.6.0~ubuntu-jammy_amd64.deb
dpkg -i ./containerd.io_1.6.31-1_amd64.deb
dpkg -i ./docker-ce-cli_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
dpkg -i ./docker-ce_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
dpkg -i ./docker-buildx-plugin_0.14.0-1~ubuntu.22.04~jammy_amd64.deb
dpkg -i ./docker-compose-plugin_2.6.0~ubuntu-jammy_amd64.deb
systemctl docker start

# MINIKUBE:
wget https://github.com/kubernetes/minikube/releases/download/v1.33.1/minikube_1.33.1-0_amd64.deb
dpkg -i ./minikube_1.33.1-0_amd64.deb
minikube version
apt -y install conntrack
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.30.0/crictl-v1.30.0-linux-amd64.tar.gz
tar zxvf crictl-v1.30.0-linux-amd64.tar.gz -C /usr/local/bin
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.14/cri-dockerd_0.3.14.3-0.ubuntu-jammy_amd64.deb
dpkg -i ./cri-dockerd_0.3.14.3-0.ubuntu-jammy_amd64.deb
wget https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-amd64-v1.5.0.tgz
mkdir -p /opt/cni/bin
tar -xf cni-plugins-linux-amd64-v1.5.0.tgz -C /opt/cni/bin
mkdir -p /etc/cni/net.d
minikube start --vm-driver=none
