#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/t3-support.yaml
kubectl apply -f ../yaml/alice-csr.yaml
kubectl certificate approve alice
kubectl apply -f ../yaml/t3-support-binding.yaml
