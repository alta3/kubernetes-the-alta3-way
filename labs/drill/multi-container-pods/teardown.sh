#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-multi-container-pods.yaml
kubectl delete --ignore-not-found -f snooper-fluentd.yaml
if [ -e ~/snooper-fluentd.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f snooper-fluentd.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
