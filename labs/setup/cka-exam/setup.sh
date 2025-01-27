#!/bin/bash
set -euo pipefail

echo "Initializing your CKA exam environment! Please wait, this process will take approximately 3 minutes. No additional output will be displayed until the setup is complete."

scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh controller:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-1:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-2:/tmp/kubeadm-deps.sh
ssh controller "bash /tmp/kubeadm-deps.sh" &
ssh node-1 "bash /tmp/kubeadm-deps.sh" &
ssh node-2 "bash /tmp/kubeadm-deps.sh" &
wait

ssh -o StrictHostKeyChecking=no controller << "KUBEADM_INIT"
sudo export PUBLIC_IP=$(dig controller +search +noall +short)

sudo kubeadm init \
--pod-network-cidr=192.168.0.0/16 \
--apiserver-advertise-address=${PUBLIC_IP} \
--control-plane-endpoint=${PUBLIC_IP} \
--kubernetes-version=1.31.4

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml
KUBEADM_INIT

JOIN_CMD=$(ssh controller kubeadm token create --print-join-command)
ssh -o StrictHostKeyChecking=no node-1 sudo "${JOIN_CMD}"

# kubectl setup for bchd
bash $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh
mkdir -p $HOME/.kube
scp student@controller:/home/student/.kube/config /home/student/.kube/config

# local answer dirs
sudo mkdir -p /opt/cka/answers
sudo chown student:student /opt/cka/answers

echo Metrics Server Pre-Reqs
#kubectl apply -f $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-metrics-cm.yaml
ssh node-1 'echo "serverTLSBootstrap: true" | sudo tee -a /var/lib/kubelet/config.yaml'
ssh node-1 sudo systemctl restart kubelet
ssh controller 'echo "serverTLSBootstrap: true" | sudo tee -a /var/lib/kubelet/config.yaml'
ssh controller sudo systemctl restart kubelet
for CSR in `kubectl get csr -o name`; do kubectl certificate approve $CSR; done
echo STARTING TASK SETUP

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/baremetal/deploy.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# 7 Node Selector
kubectl label node node-1 disk=nvme --overwrite

# 21 Etcd Backup and Restore
ssh -o StrictHostKeyChecking=no controller << "ETCD_BACKUP"
sudo apt install etcd-client -y
sudo mkdir /opt/cka/help -p
sudo chown student:student /opt/cka/help
kubectl run isitback --image=nginx
sleep 20
ETCDCTL_API=3 sudo etcdctl snapshot save /opt/cka/help/restore.backup --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key
kubectl delete pod isitback
ETCD_BACKUP


# 22 Stopped Kubelet  (on bchd?)
# TODO - sudo systemctl stop kubelet    ---- somewhere

for CSR in `kubectl get csr -o name`; do kubectl certificate approve $CSR; done
