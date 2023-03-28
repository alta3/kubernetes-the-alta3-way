#!/bin/bash
set -euo pipefail
kubectl create -f ~/mycode/yaml/test-ns.yaml
kubectl create ns dev
kubectl create ns prod
