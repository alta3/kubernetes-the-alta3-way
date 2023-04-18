#!/usr/bin/bash

echo STARTING ----------
kubectl apply -f ~/mycode/yaml/ctce-drill-configmaps.yaml
kubectl create configmap -n metallica nineteen-eighty-four --from-file=1984.txt=mycode/config/nineteen-eighty-four.txt
kubectl create configmap -n metallica nginx-base-conf --from-file=nginx.conf=mycode/config/nginx-base.conf
echo END OF SETUP ----------
