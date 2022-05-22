#!/bin/bash
set -euo pipefail

# NOTE: ${WAIT} is exported from the parent script, do not hard code it
#kubectl delete --ignore-not-found --wait="${WAIT}" \
#  -f ../yaml/example1.yaml \
#  -f ../yaml/example2.yaml \
#  -f ../yaml/example3.yaml 

#kubectl delete --ignore-not-found --wait="${WAIT}" pod not-created-by-a-manifest
#kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/yaml-in-a-namespace.yaml --namespace=test
