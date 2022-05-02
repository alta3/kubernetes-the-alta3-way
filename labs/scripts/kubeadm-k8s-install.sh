#!/bin/sh
echo 'Installing K8s Node'
apt-get update
apt-get install libseccomp2  # Might be already installed
wget https://storage.googleapis.com/cri-containerd-release/cri-containerd-1.3.3.linux-amd64.tar.gz
sha256sum cri-containerd-1.3.3.linux-amd64.tar.gz
curl https://storage.googleapis.com/cri-containerd-release/cri-containerd-1.3.3.linux-amd64.tar.gz.sha256
# Compare to make sure the 2 checksums are the same.
tar --no-overwrite-dir -C / -xzf cri-containerd-1.3.3.linux-amd64.tar.gz
mkdir /etc/containerd
cat << EOF >> /etc/containerd/config.toml
version = 2

[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
    [plugins."io.containerd.grpc.v1.cri".registry]
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
          endpoint = ["https://registry.alta3.com"]
EOF
systemctl start containerd
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
bash -c 'echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'
apt-get update
apt-get install -y kubelet=1.18.0-00 kubeadm=1.18.0-00 kubectl=1.18.0-00
apt-mark hold kubelet kubeadm kubectl
echo '[Service]' > /etc/systemd/system/kubelet.service.d/0-containerd.conf
echo 'Environment="KUBELET_EXTRA_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock"' >> /etc/systemd/system/kubelet.service.d/0-containerd.conf
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/10-ip-forwarding.conf
sysctl net.ipv4.ip_forward=1
echo 'br_netfilter' > /etc/modules-load.d/br_nf.conf
modprobe br_netfilter
systemctl daemon-reload

