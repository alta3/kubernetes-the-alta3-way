#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/mysql-secret.yaml
kubectl apply -f ../yaml/mysql-locked.yaml
