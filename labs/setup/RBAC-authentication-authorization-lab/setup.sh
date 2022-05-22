#!/bin/bash
set -euo pipefail

kubectl apply \
  -f ~/mycode/yaml/prod-ns.yaml \
  -f ~/mycode/yaml/test-ns.yaml \
  -f ~/mycode/yaml/dev-ns.yaml
