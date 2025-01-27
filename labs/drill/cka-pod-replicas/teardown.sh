#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f https://static.alta3.com/courses/cka/exam/dragon.yml --force --grace-period=0

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
