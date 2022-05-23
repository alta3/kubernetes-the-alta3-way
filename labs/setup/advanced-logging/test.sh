#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/counter-pod.yaml
kubectl wait --for condition=Ready --timeout 30s pod/counter
kubectl apply -f ../yaml/two-pack.yaml
kubectl wait --for condition=Available --timeout 30s deployment.apps/two-pack
kubectl apply -f ../yaml/nginx-rsyslog-pod.yaml
kubectl wait --for condition=Ready --timeout 30s pod/nginx-rsyslog-pod
