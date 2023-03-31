#!/usr/bin/bash
set -eou pipeline
echo STARTING ----------
kubectl apply -f ~/mycode/yaml/ctce-drill-network-policies.yaml
echo END OF SETUP ----------
