#!/usr/bin/bash

kubectl apply -f ~/mycode/yaml/netgrabber.yaml
kubectl exec netgrab -c busybox -- sh "ping 8.8.8.8 -c 10"
sleep 10
kubectl delete pod netgrab
kubectl delete configmap nginx-conf
kubectl create -f ~/mycode/yaml/nginx-conf.yaml
kubectl create -f ~/mycode/yaml/webby-nginx-combo.yaml
sudo rm /etc/nginx/sites-enabled/fruit-ingress
sudo nginx -s reload

