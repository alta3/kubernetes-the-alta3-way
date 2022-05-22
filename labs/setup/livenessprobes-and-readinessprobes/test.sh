#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/sise-lp.yaml
kubectl apply -f ../yaml/sise-rp.yaml
kubectl apply -f ../yaml/badpod.yaml
