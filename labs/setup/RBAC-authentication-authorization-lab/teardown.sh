#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/t3-support.yaml \
  -f ../yaml/alice-csr.yaml \
  -f ../yaml/t3-support-binding.yaml

kubectl delete certificatesigningrequests.certificates.k8s.io alice
