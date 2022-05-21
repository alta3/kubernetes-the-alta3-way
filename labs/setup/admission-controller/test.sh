#!/usr/bin/bash

kubectl run no-lr --image=nginx:1.19.6
sleep 20
get pods
kubectl apply -f ~/mycode/yaml/lim-ran.yml
kubectl get limitrange
