#!/bin/bash
set -euo pipefail

# Label node-1 with disktype=ssd
kubectl label node node-1 disktype- --overwrite

echo "✅ Environment ready"
