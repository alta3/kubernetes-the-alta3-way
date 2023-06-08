#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-security-contexts.yaml
if [ -e ~/gold-bar.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/gold-bar.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
