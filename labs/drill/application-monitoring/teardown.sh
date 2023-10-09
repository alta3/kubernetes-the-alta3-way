#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-monitoring.yaml
sleep 60

if [ -e ~/cpu-consume.txt ] 
then
  echo "deleting"
  rm ~/cpu-consume.txt
else
  echo "file does not exist"
fi
echo "Teardown complete"
