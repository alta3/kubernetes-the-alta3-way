#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f https://static.alta3.com/courses/cka/exam/basenginx.yml --force --grace-period=0 --ignore-not-found &> /dev/null
kubectl delete -f https://static.alta3.com/courses/cka/exam/lowcpunginx.yml --force --grace-period=0 --ignore-not-found &> /dev/null
kubectl delete -f https://static.alta3.com/courses/cka/exam/highcpunginx.yml --force --grace-period=0 --ignore-not-found &> /dev/null
kubectl delete ns integration --force --grace-period=0 --ignore-not-found &> /dev/null

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
