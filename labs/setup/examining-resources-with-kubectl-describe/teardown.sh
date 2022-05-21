#!/bin/bash
set -euo pipefail

kubectl delete pod webweb --now
kubectl delete -f ../yaml/webweb-deploy.yaml
