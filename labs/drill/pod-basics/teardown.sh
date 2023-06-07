#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-basic-pods.yaml
kubectl delete --ignore-not-found -f ~/singer.yaml
echo "Teardown complete"
