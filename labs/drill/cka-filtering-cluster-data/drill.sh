#!/bin/bash
set -euo pipefail

# drill setup tasks go here
kubectl create ns integration &> /dev/null
kubectl apply -f https://static.alta3.com/courses/cka/exam/basenginx.yml &> /dev/null
kubectl apply -f https://static.alta3.com/courses/cka/exam/lowcpunginx.yml &> /dev/null
kubectl apply -f https://static.alta3.com/courses/cka/exam/highcpunginx.yml &> /dev/null

echo "[+] Task setup complete! You can now begin. Good luck!"
