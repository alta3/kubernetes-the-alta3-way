#!/usr/bin/bash

kubectl delete secret webby-keys
kubectl delete cm nginx-conf
kubectl delete -f ~/mycode/yaml/nginx-locked-n-loaded-02.yaml
