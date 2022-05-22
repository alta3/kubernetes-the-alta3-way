#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" pod webweb
kubectl delete --ignore-not-found --wait="${WAIT}" -f ../yaml/webweb-deploy.yaml
