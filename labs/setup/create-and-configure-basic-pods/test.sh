#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/simpleservice.yaml
kubectl wait --for condition=Ready --timeout 60s -f ../yaml/simpleservice.yaml
kubectl apply -f ../yaml/webby-pod01.yaml
kubectl wait --for condition=Ready --timeout 60s -f ../yaml/webby-pod01.yaml
