#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
kubectl apply -f ~/mycode/yaml/prod-ns.yaml -f ~/mycode/yaml/test-ns.yaml -f ~/mycode/yaml/dev-ns.yaml
kubectl create configmap nginx-conf --from-file=/home/student/mycode/config/nginx.conf
kubectl create configmap index-file --from-file=/home/student/mycode/config/index.html
echo "It was a bright cold day in April, and the clocks were striking thirteen." >> /home/student/nginx.txt
kubectl create configmap nginx-txt --from-file=/home/student/nginx.txt
kubectl get configmap
kubectl delete pod nginx
kubectl create -f ~/mycode/yaml/nginx-configured.yaml
sleep 30
kubectl get pod nginx-configured
echo END OF SETUP ----------
