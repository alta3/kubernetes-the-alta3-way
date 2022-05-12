#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
kubectl config use-context kubernetes-the-alta3-way
echo END OF SETUP ----------
