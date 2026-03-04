#!/usr/bin/env bash

# setup.sh
# Simulate a worker node failure by stopping kubelet on node-1

set -e

NODE="node-1"

echo "Simulating node failure..."
echo

echo "Checking that ${NODE} exists in the cluster..."
kubectl get node ${NODE} >/dev/null 2>&1 || {
    echo "ERROR: Node ${NODE} not found in cluster."
    exit 1
}

echo "Stopping kubelet service on ${NODE}..."

ssh ${NODE} "sudo systemctl stop kubelet"

echo
echo "Verifying kubelet has stopped..."

ssh ${NODE} "sudo systemctl is-active kubelet || true"

echo
echo "Setup complete."
echo
echo "Within ~30 seconds the node should transition to NotReady."
echo
echo "You can observe this with:"
echo
echo "kubectl get nodes -w"
