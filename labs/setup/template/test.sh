#!/bin/bash
set -xeuo pipefail
# NOTE: -x shows testing commands

#kubectl run a-pod-worth-waiting-for --image=nginx:1.19.6
#kubectl wait --for condition=Ready --timeout 30s pod/a-pod-worth-waiting-for

#kubectl apply -f ../yaml/a-deployment-worth-waiting-for.yml
#kubectl wait --for condition=Available --timeout 60s deployment.apps/a-deployment-worth-waiting-for

# NOTE: use 2 or 3 commands to show the success
#kubectl get pods a-pod-worth-wating-for
#kubectl get deployment.apps a-deployment-worth-waiting-for
kubectl get pods
