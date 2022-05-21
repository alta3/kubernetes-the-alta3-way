#!/bin/bash
set -euo pipefail

# kubectl delete pod webweb
# kubectl delete -f ~/mycode/yaml/webweb-deploy.yaml
kubectl delete pod webweb --now
kubectl delete -f ../yaml/webweb-deploy.yaml
