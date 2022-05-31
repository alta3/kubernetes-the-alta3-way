ssh node-1 sudo apt-get install nfs-common -y
ssh node-2 sudo apt-get install nfs-common -y
ssh node-3 sudo apt-get install nfs-common -y

sudo apt-get install nfs-kernel-server -y
sudo systemctl enable nfs-server
sudo systemctl start nfs-server
echo "/srv/nfs    *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)" | sudo tee -a /etc/exports
sudo exportfs -rav
