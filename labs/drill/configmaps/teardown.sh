#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-configmaps.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/enter-sandman.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" configmap -n metallica nineteen-eighty-four
kubectl delete --ignore-not-found --wait="${WAIT}" configmap -n metallica nginx-base-conf
echo "Teardown complete"
