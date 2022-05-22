#!/bin/bash
set -euo pipefail

kubectl apply \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml

KTA3W="${HOME}/git/kubernetes-the-alta3-way/labs"
kubectl create configmap index-file --from-file="${KTA3W}/config/index.html"
echo "It was a bright cold day in April, and the clocks were striking thirteen." >> "${HOME}/nginx.txt"
kubectl create configmap nginx-txt --from-file="${HOME}/nginx.txt"

CERTS="${HOME}/k8s-certs"
openssl genrsa -out "${CERTS}/webby.com.key" 2048
openssl req -new \
  -key "${CERTS}/webby.com.key" \
  -out "${CERTS}/webby.com.key.csr" \
  -subj "/C=US/ST=PA/L=Harrisbug/O=webby/OU=webby/CN=localhost"
openssl x509 -req \
  -in  "${CERTS}/webby.com.key.csr" \
  -CA "${CERTS}/ca.pem" \
  -CAkey "${CERTS}/ca-key.pem" \
  -CAcreateserial \
  -out "${CERTS}/webby.com.crt" \
  -days 1825 -sha256
kubectl create secret generic webby-keys \
  --from-file="${CERTS}/webby.com.crt" \
  --from-file="${CERTS}/webby.com.key"
