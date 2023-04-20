#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-logging.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -n lincoln vampire-hunter
rm ~/lincoln-logs.txt
echo "Teardown complete"
