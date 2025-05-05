#!/bin/bash
set -euo pipefail

echo "📦  Installing local-path-provisioner..."
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

echo "⌛ Waiting for provisioner pod to be ready..."
kubectl -n local-path-storage wait --for=condition=Ready pod -l app=local-path-provisioner --timeout=60s

echo "🔥 Deleting default local-path StorageClass..."
kubectl delete storageclass local-path --ignore-not-found --wait=true

echo "🛠️  Recreating StorageClass with reclaimPolicy=Retain..."
cat <<EOF | kubectl create -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-path
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: rancher.io/local-path
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
EOF

echo "✅ Environment ready"
