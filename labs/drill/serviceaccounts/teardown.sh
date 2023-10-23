#!/bin/bash
set -euo pipefail

if [ -e ~/banana-deployment.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/banana-deployment.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-service-accounts.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-servicea-ccounts.yaml

echo "Teardown complete"
