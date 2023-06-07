#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-probes.yaml
kubectl delete --ignore-not-found -f ~/plumpod.yaml
echo "Teardown complete"
