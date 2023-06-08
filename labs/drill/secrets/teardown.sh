#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-secrets.yaml
if [ -e ~/juicysecret.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/juicysecret.yaml
else
  echo "file does not exist"
fi
if [ -e ~/kiwi-secret-pod.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/kiwi-secret-pod.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
