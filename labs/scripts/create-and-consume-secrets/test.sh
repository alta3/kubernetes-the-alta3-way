#!/usr/bin/bash

openssl genrsa -out webby.com.key 2048
openssl req -new -key webby.com.key -out webby.com.key.csr -subj "/C=US/ST=PA/L=Harrisbug/O=webby/OU=webby/CN=localhost"
openssl x509 -req -in  webby.com.key.csr -CA ~/k8s-certs/ca.pem -CAkey ~/k8s-certs/ca-key.pem -CAcreateserial -out webby.com.crt -days 1825 -sha256
kubectl create secret generic webby-keys --from-file=/home/student/k8s-certs/webby.com.crt --from-file=/home/student/k8s-certs/webby.com.key
