#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait=false pod webweb
kubectl delete --ignore-not-found --wait=false -f ../yaml/webweb-deploy.yaml
