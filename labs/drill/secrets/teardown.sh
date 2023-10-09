#!/bin/bash
set -euo pipefail

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

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-secrets.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-secrets-juicysecret.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-secrets-pod.yaml

echo "Teardown complete"
