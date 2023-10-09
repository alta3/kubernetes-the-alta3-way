#!/bin/bash
set -euo pipefail

if [ -e ~/snooper-fluentd.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f snooper-fluentd.yaml
else
  echo "file does not exist"
fi

if [ -e ~/snooper.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f snooper.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-multi-container-pods.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-multi-container-pods.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/snooper-fluentd.yaml
echo "Teardown complete"
