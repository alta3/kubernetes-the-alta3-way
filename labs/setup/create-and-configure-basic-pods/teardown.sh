#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found \
  -f ../yaml/simpleservice.yaml \
  -f ../yaml/webby-pod01.yaml
