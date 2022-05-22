#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found  \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

kubectl delete --ignore-not-found secret generic webby-keys
kubectl delete --ignore-not-found configmap nginx-txt
kubectl delete --ignore-not-found configmap nginx-conf
kubectl delete --ignore-not-found configmap index-file
kubectl delete --ignore-not-found -f ../yaml/nginx-configured.yaml
kubectl delete --ignore-not-found -f ../yaml/nginx-locked-n-loaded-02.yaml
