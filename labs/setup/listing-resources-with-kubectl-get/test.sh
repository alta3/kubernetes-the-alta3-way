#!/bin/bash
set -xeuo pipefail

kubectl get services -A
kubectl get deployments.apps -A
kubectl get secrets
