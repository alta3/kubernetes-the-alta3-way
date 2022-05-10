#!/bin/sh

cd ~/git/kubernetes-the-alta3-way
ansible-playbook main.yml
ansible-playbook ~/mycode/yaml/containerd_update.yaml
echo "********"
echo "COMPLETE"
echo "********"
