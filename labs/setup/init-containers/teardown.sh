#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait=false \
  -f ../yaml/init-cont-pod.yaml \
  -f ../yaml/myservice.yaml \
  -f ../yaml/mydb.yaml
