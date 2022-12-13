#!/usr/bin/bash

kubectl create configmap nginx-base-conf --from-file=nginx.conf=../config/nginx-base.conf
kubectl create configmap index-html-zork  --from-file=index.html=../config/index-html-zork.html
kubectl create configmap nineteen-eighty-four  --from-file=1984.txt=../config/nineteen-eighty-four.txt
kubectl apply -f ../yaml/nginx-configured.yaml
kubectl wait --for condition=Ready --timeout 30s pod/nginx-configured
kubectl get pod nginx-configured
