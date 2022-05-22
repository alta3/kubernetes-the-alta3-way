#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait=false \
  -f ../yaml/simpleservice.yaml \
  -f ../yaml/webby-pod01.yaml
