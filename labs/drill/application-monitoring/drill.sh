#!/usr/bin/bash

echo STARTING ----------
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
CYAN='\033[0;36m'
echo -e ${CYAN} "This one minute pause is intentional. It allows the metrics server to finish to completion."
sleep 60
kubectl apply -f ~/mycode/yaml/ctce-drill-monitoring.yaml
sleep 60
echo END OF SETUP ----------
