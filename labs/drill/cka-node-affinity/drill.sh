#!/bin/bash
set -euo pipefail

# Label node-1 with disktype=ssd
kubectl label node node-1 disktype=ssd --overwrite

echo "✅ Environment ready"
