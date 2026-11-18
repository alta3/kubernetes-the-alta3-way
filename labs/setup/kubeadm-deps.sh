#!/bin/bash
set -euo pipefail

# Wait for Ubuntu's automatic updates (apt-daily) to finish if they are running,
# so our apt commands don't fight them for the package lock.
sudo systemd-run --property="After=apt-daily.service apt-daily-upgrade.service" --wait /bin/true

# Backup: if the lock is still held, wait up to 10 minutes instead of failing.
APT_WAIT="-o DPkg::Lock::Timeout=600"

sudo apt-get $APT_WAIT update

sudo apt-get $APT_WAIT install -y apt-transport-https ca-certificates curl jq gnupg

# Kubernetes repo (--batch --yes lets the script re-run without prompting)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Docker repo (provides containerd.io)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/containerd.list
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable
EOF

sudo apt-get $APT_WAIT update

sudo apt-get $APT_WAIT install -y containerd.io kubelet=1.31.4-1.1 kubeadm=1.31.4-1.1 kubectl=1.31.4-1.1

# Kernel modules
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
kvm-intel
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Kernel networking settings required by Kubernetes (includes ip_forward)
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

sudo systemctl restart containerd
sudo systemctl enable containerd

sudo apt-mark hold kubelet kubeadm kubectl
