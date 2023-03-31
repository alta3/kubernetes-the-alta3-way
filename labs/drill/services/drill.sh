#!/usr/bin/bash
set -eou pipeline
echo STARTING ----------
kubectl apply -f ~/mycode/yaml/ctce-drill-services.yaml
echo END OF SETUP ----------
