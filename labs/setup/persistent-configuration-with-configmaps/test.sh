#!/usr/bin/bash

kubectl create configmap nginx-base-conf --from-file=nginx.conf=mycode/config/nginx-base.conf
kubectl create configmap index-html-zork  --from-file=index.html=mycode/config/index-html-zork.html
kubectl create configmap nineteen-eighty-four  --from-file=1984.txt=mycode/config/nineteen-eighty-four.txt
kubectl apply -f ~/mycode/yaml/nginx-configured.yaml
kubectl wait --for condition=Ready --timeout 30s pod/nginx-configured
kubectl get pod nginx-configured
