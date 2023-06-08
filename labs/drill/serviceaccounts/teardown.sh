#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-service-accounts.yaml
if [ -e ~/banana-deployment.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/banana-deployment.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
