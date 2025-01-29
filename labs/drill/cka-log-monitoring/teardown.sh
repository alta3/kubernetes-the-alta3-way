#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f https://static.alta3.com/courses/cka/exam/filenotfound.yml --ignore-not-found --force --grace-period=0
sudo rm /opt/cka/answers/sorted_log.log &> /dev/null

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
