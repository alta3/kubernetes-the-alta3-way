#!/bin/bash
set -euo pipefail

sudo modprobe br_netfilter

cat << EOF | sudo tee /etc/modules-load.d/k8s.conf 
br_netfilter
EOF

cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl jq gnupg

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
EOF

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/containerd.list
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable
EOF

sudo apt-get update 
sudo apt-get install -y containerd.io kubelet=1.23.7-00 kubeadm=1.23.7-00 kubectl=1.23.7-00

sudo scp -o StrictHostKeyChecking=no -i "${HOME}/.ssh/id_rsa" student@bchd:~/git/kubernetes-the-alta3-way/labs/config/containerd_config.toml /etc/containerd/config.toml

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
kvm-intel
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo apt-mark hold kubelet kubeadm kubectl
