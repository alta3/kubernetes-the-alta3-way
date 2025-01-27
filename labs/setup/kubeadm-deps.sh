#!/bin/bash
set -euo pipefail

sudo apt update

sudo apt -y upgrade

sudo apt-get install -y apt-transport-https ca-certificates curl jq gnupg

sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo cat <<EOF | sudo tee /etc/apt/sources.list.d/containerd.list
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable
EOF
sudo apt update

sudo apt install -y containerd.io kubelet=1.31.4-1.1 kubeadm=1.31.4-1.1 kubectl=1.31.4-1.1

sudo apt install -y sshpass

sudo sshpass -p 'alta3' scp -o StrictHostKeyChecking=no student@bchd:~/mycode/config/containerd_config.toml /etc/containerd/config.toml

sudo cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
kvm-intel
EOF

sudo modprobe overlay

sudo modprobe br_netfilter

sudo cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

sudo systemctl restart containerd

sudo systemctl enable containerd

sudo apt-mark hold kubelet kubeadm kubectl
