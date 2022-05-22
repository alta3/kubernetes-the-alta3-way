#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/netgrabber.yaml
kubectl wait --for condition=Ready --timeout 60s -f ../yaml/netgrabber.yaml
kubectl exec netgrab -c busybox -- sh -c "ping 8.8.8.8 -c 1"
kubectl apply -f ../yaml/nginx-conf.yaml
kubectl apply -f ../yaml/webby-nginx-combo.yaml
kubectl wait --for condition=Ready --timeout 60s -f ../yaml/webby-nginx-combo.yaml
