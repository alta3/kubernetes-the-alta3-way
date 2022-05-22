#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/nginx-locked-n-loaded-02.yaml
#kubectl wait --for condition=Ready --timeout 60s -f 
#curl https://localhost:9090
