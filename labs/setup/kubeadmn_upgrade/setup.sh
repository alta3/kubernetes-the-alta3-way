#!/usr/bin/bash

echo STARTING ----------
ssh controller "kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n""
echo END OF SETUP ----------
