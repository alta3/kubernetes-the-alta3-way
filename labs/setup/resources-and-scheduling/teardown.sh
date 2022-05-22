#!/bin/bash
set -euo pipefail

kubectl delete -f ../yaml/dev-rq.yaml --namespace=dev

kubectl delete \
  -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml \
  -f ../yaml/resourced_deploy.yml
