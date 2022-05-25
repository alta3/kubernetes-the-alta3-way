#!/bin/sh
# Order 66 - The Jedi must be purged

# Kube Admin Reset
kubeadm reset

# Remove the hold on Kubernetes Applications
apt-mark unhold kubelet kubeadm kubectl

# Remove all packages related to Kubernetes
apt remove -y kubeadm kubectl kubelet kubernetes-cni 
apt purge -y kube*

# Purge etcd
ETCDCTL_API=3 etcdctl del "" --from-key=true
systemctl stop etcd
rm -rf /var/lib/etcd/default.etcd
apt purge -y etcd
apt autoremove

# Remove docker containers/ images ( optional if using docker)
docker image prune -a
systemctl restart docker
apt purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd containerd.io runc --allow-change-held-packages

# Remove parts
apt autoremove -y

# Remove all folder associated to kubernetes, etcd, and docker
rm -rf ~/.kube
rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes ~/.kube/* 
rm -rf /var/lib/docker /etc/docker /var/run/docker.sock
rm -f /etc/apparmor.d/docker /etc/systemd/system/etcd* 
rm -rf /opt/cni/bin
rm -rf /etc/systemd/system/kubelet.service.d/
rm -rf /var/run/docker.pid

# Delete docker group (optional)
groupdel docker

# Clear the iptables
iptables -t nat -F && iptables -t nat -X
iptables -t raw -F && iptables -t raw -X
iptables -t mangle -F && iptables -t mangle -X
iptables -F && iptables -X
