#!/bin/bash
set -euo pipefail
kubectl rollout undo deployment -n king-of-lions mufasa
kubectl delete deploy -n king-of-lions
echo "[-] No teardown"
