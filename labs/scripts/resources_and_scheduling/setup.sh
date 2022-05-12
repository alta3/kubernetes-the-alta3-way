#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f ~/mycode/yaml/prod-ns.yaml -f ~/mycode/yaml/test-ns.yaml -f ~/mycode/yaml/dev-ns.yaml
