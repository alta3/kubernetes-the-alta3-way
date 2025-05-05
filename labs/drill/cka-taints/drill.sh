#!/bin/bash
set -euo pipefail

# Label and taint node-1
kubectl label node node-1 dedicated=experimental --overwrite >/dev/null 2>&1
kubectl taint node node-1 dedicated=experimental:NoSchedule --overwrite >/dev/null 2>&1

echo "✅ Environment ready"
