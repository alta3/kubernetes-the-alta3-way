#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f kubectl apply -f https://static.alta3.com/courses/cka/exam/filenotfound.yml
sudo rm /opt/cka/answers/sorted_log.log &> /dev/null

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
