#!/usr/bin/bash

echo STARTING ----------
ssh controller "kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n""
echo Maybe you are still in the process of setting up your cluster
echo ignore any errors here. This is just making sure we remove kubeadm if it is installed.

ssh controller 'sudo kubeadm reset'
ssh controller 'sudo apt-mark unhold kubelet kubeadm kubectl'
ssh controller 'sudo apt remove -y kubeadm kubectl kubelet kubernetes-cni'
ssh controller 'sudo apt purge -y kube*'
ssh controller 'sudo ETCDCTL_API=3 etcdctl del "" --from-key=true'
ssh controller 'sudo systemctl stop etcd'
ssh controller 'sudo rm -rf /var/lib/etcd/default.etcd'
ssh controller 'sudo apt purge -y etcd'
ssh controller 'sudo apt autoremove -y'
ssh controller 'sudo apt install docker -y'
ssh controller 'sudo docker image prune -a'
ssh controller 'sudo systemctl restart docker'
ssh controller 'sudo apt purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd containerd.io runc --allow-change-held-packages'
ssh controller 'sudo apt autoremove -y'
ssh controller 'sudo rm -rf ~/.kube'
ssh controller 'sudo rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes ~/.kube/*'
ssh controller 'sudo rm -rf /var/lib/docker /etc/docker /var/run/docker.sock'
ssh controller 'sudo rm -f /etc/apparmor.d/docker /etc/systemd/system/etcd*'
ssh controller 'sudo rm -rf /opt/cni/bin'
ssh controller 'sudo rm -rf /etc/systemd/system/kubelet.service.d/'
ssh controller 'sudo rm -rf /var/run/docker.pid'
ssh controller 'sudo groupdel docker'
ssh controller 'sudo iptables -t nat -F && iptables -t nat -X'
ssh controller 'sudo iptables -t raw -F && iptables -t raw -X'
ssh controller 'sudo iptables -t mangle -F && iptables -t mangle -X'
ssh controller 'sudo iptables -F && iptables -X'
ssh controller 'sudo reboot'
ssh node-1     'wget https://batcat.alta3.com/alta3/kubernetes-the-alta3-way/main/labs/scripts/order-66.sh?'
ssh node-1     'sudo bash order-66.sh'
ssh node-1     'sudo reboot'
echo END OF SETUP ----------


