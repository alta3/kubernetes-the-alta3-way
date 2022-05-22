#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/netgrabber.yaml \
  -f ../yaml/nginx-conf.yaml \
  -f ../yaml/webby-nginx-combo.yaml \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

kubectl delete --ignore-not-found --wait="${WAIT}" secret generic webby-keys
kubectl delete --ignore-not-found --wait="${WAIT}" configmap nginx-txt
kubectl delete --ignore-not-found --wait="${WAIT}" configmap nginx-conf
kubectl delete --ignore-not-found --wait="${WAIT}" configmap index-file
