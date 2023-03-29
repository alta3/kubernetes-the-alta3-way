#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
echo No worries, it looks like you still may be setting things up
echo END OF SETUP ----------
