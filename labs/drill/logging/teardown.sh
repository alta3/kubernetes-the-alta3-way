#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-logging.yaml
rm ~/lincoln-logs.txt
if [ -e ~/lincoln vampire-hunter ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -n ~/lincoln vampire-hunter
else
  echo "file does not exist"
fi
echo "Teardown complete"
