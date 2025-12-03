#!/bin/bash
set -euo pipefail

echo "Initializing your CKA exam environment! Please wait, this process will take approximately 3 minutes. No additional output will be displayed until the setup is complete."

# 1. Copy dependency setup script to each node
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh controller:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-1:/tmp/kubeadm-deps.sh
scp -o StrictHostKeyChecking=no $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh node-2:/tmp/kubeadm-deps.sh

# 2. Run kubeadm-deps.sh in parallel on all nodes
echo "Installing dependencies on all nodes..."
ssh controller "bash /tmp/kubeadm-deps.sh" &
ssh node-1 "bash /tmp/kubeadm-deps.sh" &
ssh node-2 "bash /tmp/kubeadm-deps.sh" &
wait

# -------------------------------------------------------------------------
# ### FIX CONTAINERD CONFIGURATION ###
# This block is added to fix the 'unknown service runtime.v1.RuntimeService' error
# -------------------------------------------------------------------------
echo "Configuring containerd (SystemdCgroup) on all nodes..."
for HOST in controller node-1 node-2; do
  ssh -o StrictHostKeyChecking=no $HOST << 'CONTAINERD_FIX'
    # Create dir if not exists
    sudo mkdir -p /etc/containerd
    # Generate default config (enables CRI plugin)
    sudo containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
    # Set SystemdCgroup to true (Required for K8s 1.25+)
    sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
    # Restart containerd to apply changes
    sudo systemctl restart containerd
CONTAINERD_FIX
done
# -------------------------------------------------------------------------

# 3. Check that kubeadm exists on the controller before continuing
ssh -o StrictHostKeyChecking=no controller << 'CHECK_KUBEADM'
if ! command -v kubeadm >/dev/null 2>&1; then
  echo "ERROR: kubeadm is not installed or not in PATH on controller."
  exit 1
fi
CHECK_KUBEADM

# 4. Initialize the control plane on controller
echo "Initializing Control Plane..."
ssh -o StrictHostKeyChecking=no controller << "KUBEADM_INIT"
set -euo pipefail

PUBLIC_IP=$(dig controller +search +noall +short)

# Added --ignore-preflight-errors just in case of minor warnings, though the fix above should resolve the fatal one.
sudo kubeadm init \
  --pod-network-cidr=192.168.0.0/16 \
  --apiserver-advertise-address="${PUBLIC_IP}" \
  --control-plane-endpoint="${PUBLIC_IP}" \
  --kubernetes-version=1.31.4

mkdir -p "$HOME/.kube"
sudo cp -f /etc/kubernetes/admin.conf "$HOME/.kube/config"

uid=$(id -u)
gid=$(id -g)
sudo chown "${uid}:${gid}" "$HOME/.kube/config"

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml
KUBEADM_INIT

# 5. Get join command and run it on node-1
echo "Joining Worker Node..."
JOIN_CMD=$(ssh -o StrictHostKeyChecking=no controller 'sudo kubeadm token create --print-join-command')
ssh -o StrictHostKeyChecking=no node-1 sudo "${JOIN_CMD}"

# 6. Setup kubectl for local use on bchd
bash $HOME/git/kubernetes-the-alta3-way/labs/setup/kubeadm-deps.sh
mkdir -p $HOME/.kube
scp student@controller:/home/student/.kube/config /home/student/.kube/config

# 7. Create local answer directory
sudo mkdir -p /opt/cka/answers
sudo chown student:student /opt/cka/answers

echo "Metrics Server Pre-Reqs"

ssh node-1 'echo "serverTLSBootstrap: true" | sudo tee -a /var/lib/kubelet/config.yaml'
ssh node-1 sudo systemctl restart kubelet
ssh controller 'echo "serverTLSBootstrap: true" | sudo tee -a /var/lib/kubelet/config.yaml'
ssh controller sudo systemctl restart kubelet

for CSR in $(kubectl get csr -o name); do
  kubectl certificate approve "$CSR"
done

echo "STARTING TASK SETUP"

# 8. Deploy metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# 9. Node label for future exercises
kubectl label node node-1 disk=nvme --overwrite

# 10. Etcd Backup and Restore preparation
ssh -o StrictHostKeyChecking=no controller << "ETCD_BACKUP"
sudo apt install etcd-client -y
sudo mkdir -p /opt/cka/help
sudo chown student:student /opt/cka/help
kubectl run isitback --image=nginx
sleep 20
ETCDCTL_API=3 sudo etcdctl snapshot save /opt/cka/help/restore.backup \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
kubectl delete pod isitback
ETCD_BACKUP

# Final CSR approvals (in case of late requests)
for CSR in $(kubectl get csr -o name); do
  kubectl certificate approve "$CSR"
done

echo "CKA exam environment setup completed successfully!"
