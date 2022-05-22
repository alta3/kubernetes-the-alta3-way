#!/bin/bash
set -euo pipefail

kubectl delete \
  -f ~/mycode/yaml/prod-ns.yaml \
  -f ~/mycode/yaml/test-ns.yaml \
  -f ~/mycode/yaml/dev-ns.yaml
