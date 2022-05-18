#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
kubectl apply -f ~/mycode/yaml/prod-ns.yaml -f ~/mycode/yaml/test-ns.yaml -f ~/mycode/yaml/dev-ns.yaml
echo END OF SETUP ----------
