#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-security-contexts.yaml
kubectl delete --ignore-not-found -f ~/gold-bar.yaml
echo "Teardown complete"
