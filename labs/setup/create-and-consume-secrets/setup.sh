#!/bin/bash
set -euo pipefail

kubectl apply \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

KTA3W="${HOME}/git/kubernetes-the-alta3-way/labs"
kubectl create configmap nginx-conf --from-file="${KTA3W}/config/nginx.conf"
kubectl create configmap index-file --from-file="${KTA3W}/config/index.html"
echo "It was a bright cold day in April, and the clocks were striking thirteen." >> "${HOME}/nginx.txt"
kubectl create configmap nginx-txt --from-file="${HOME}/nginx.txt"

kubectl apply -f ../yaml/nginx-configured.yaml
#kubectl get pod nginx-configured
