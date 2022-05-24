#!/bin/bash
set -euo pipefail

scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh controller:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-1:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-2:/tmp/kubeadm-deps.sh
ssh controller "bash /tmp/kubeadm-deps.sh" &
ssh node-1 "bash /tmp/kubeadm-deps.sh" &
ssh node-2 "bash /tmp/kubeadm-deps.sh" &
wait

ssh -o StrictHostKeyChecking=no controller << KUBEADM_INIT
export PUBLIC_IP=$(dig controller +search +noall +short)
sudo kubeadm init \
--pod-network-cidr=192.168.0.0/16 \
--apiserver-advertise-address=${PUBLIC_IP} \
--control-plane-endpoint=${PUBLIC_IP} \
--kubernetes-version=1.24.0-rc.1

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml
KUBEADM_INIT

JOIN_CMD=$(ssh controller kubeadm token create --print-join-command)
ssh -o StrictHostKeyChecking=no node-1 sudo "${JOIN_CMD}"
