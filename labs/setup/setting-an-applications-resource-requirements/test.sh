#!/bin/bash
set -xeuo pipefail 

kubectl apply -f ../yaml/linux-pod-r.yaml
kubectl apply -f ../yaml/linux-pod-rl.yaml
