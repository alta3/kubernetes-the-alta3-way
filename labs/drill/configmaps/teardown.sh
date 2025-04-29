#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-configmaps.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-configmaps.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/enter-sandman.yaml
#kubectl delete --ignore-not-found -f ~/mycode/yaml/metal.html << Not a yaml file. Can stay
kubectl delete --ignore-not-found configmap -n metallica nineteen-eighty-four
kubectl delete --ignore-not-found configmap -n metallica nginx-base-conf
echo "Teardown complete"
