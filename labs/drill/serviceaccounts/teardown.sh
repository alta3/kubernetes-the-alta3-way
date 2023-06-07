#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-service-accounts.yaml
kubectl delete --ignore-not-found -f ~/banana-deployment.yaml
echo "Teardown complete"
