#!/usr/bin/bash

echo STARTING ----------
kubectl get nodes || printf "\n\n Looks like K8s may not be installed?\n\n"
kubectl apply -f ~/mycode/yaml/prod-ns.yaml -f ~/mycode/yaml/test-ns.yaml -f ~/mycode/yaml/dev-ns.yaml
kubectl create configmap nginx-conf --from-file=/home/student/mycode/config/nginx.conf
kubectl create configmap index-file --from-file=/home/student/mycode/config/index.html
cd ~/k8s-certs
openssl genrsa -out webby.com.key 2048
openssl req -new -key webby.com.key -out webby.com.key.csr -subj "/C=US/ST=PA/L=Harrisbug/O=webby/OU=webby/CN=localhost"
openssl x509 -req -in  webby.com.key.csr -CA ~/k8s-certs/ca.pem -CAkey ~/k8s-certs/ca-key.pem -CAcreateserial -out webby.com.crt -days 1825 -sha256
kubectl create secret generic webby-keys --from-file=/home/student/k8s-certs/webby.com.crt --from-file=/home/student/k8s-certs/webby.com.key
echo "It was a bright cold day in April, and the clocks were striking thirteen." >> /home/student/nginx.txt
kubectl create configmap nginx-txt --from-file=/home/student/nginx.txt
kubectl delete pod nginx
sleep 30
kubectl get pod nginx-configured
echo END OF SETUP ----------
