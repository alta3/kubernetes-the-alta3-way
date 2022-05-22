#!/bin/bash
set -euo pipefail

kubectl delete -f ../yaml/simpleservice.yaml --ignore-not-found
kubectl delete -f ../yaml/webby-pod01.yaml --ignore-not-found
