#!/bin/bash
set -xeuo pipefail

KTA3W="${HOME}/git/kubernetes-the-alta3-way/labs"
kubectl create configmap nginx-conf --from-file="${KTA3W}/config/nginx.conf.createandconsumesecrets"
kubectl apply -f ../yaml/nginx-locked-n-loaded-02.yaml
#kubectl wait --for condition=Ready --timeout 60s -f 
#curl https://localhost:9090
