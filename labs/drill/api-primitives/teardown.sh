#!/bin/bash
kubectl delete --ignore-not-found pods apricot -n pineapple
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-api-primitives.yaml
echo "Teardown complete"
