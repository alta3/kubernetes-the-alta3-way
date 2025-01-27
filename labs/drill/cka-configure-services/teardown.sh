#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f https://static.alta3.com/courses/cka/exam/deppy.yml

# kill whatever service the student made to expose deppy
kubectl delete svc --ignore-not-found $(kubectl get svc --no-headers | awk '/deppy/ {print $1}')

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
