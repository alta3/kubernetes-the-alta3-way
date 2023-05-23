#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-logging.yaml
kubectl delete --ignore-not-found -n lincoln vampire-hunter
rm ~/lincoln-logs.txt
echo "Teardown complete"
