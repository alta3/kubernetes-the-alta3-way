#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/test-rq.yaml --namespace=test
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/dev-rq.yaml --namespace=dev
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/prod-rq.yaml --namespace=prod
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/test-ns.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/dev-ns.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/prod-ns.yaml
