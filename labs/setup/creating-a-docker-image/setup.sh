#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
echo Just an FYI, k8s is not installed, but you should be fine to continue 
echo with this lab. No more setup required.
echo END OF SETUP ----------
