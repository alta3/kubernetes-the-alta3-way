#!/usr/bin/bash

kubectl run no-lr --image=nginx:1.19.6
kubectl apply -f ~/mycode/yaml/lim-ran.yml
