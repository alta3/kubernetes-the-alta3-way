#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-configmaps.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/enter-sandman.yaml
kubectl delete --ignore-not-found configmap -n metallica nineteen-eighty-four
kubectl delete --ignore-not-found configmap -n metallica nginx-base-conf
echo "Teardown complete"
