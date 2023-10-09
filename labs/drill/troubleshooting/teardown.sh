#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-debugging.yaml
kubectl delete --ignore-not-found deploy -n upsetti-spaghetti spaghetti-monster
echo "Teardown complete"
