#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait=false \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

kubectl delete --ignore-not-found --wait=false secret generic webby-keys
kubectl delete --ignore-not-found --wait=false configmap nginx-txt
kubectl delete --ignore-not-found --wait=false configmap nginx-conf
kubectl delete --ignore-not-found --wait=false configmap index-file
kubectl delete --ignore-not-found --wait=false -f ../yaml/nginx-configured.yaml
kubectl delete --ignore-not-found --wait=false -f ../yaml/nginx-locked-n-loaded-02.yaml
