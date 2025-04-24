#!/bin/bash
set -euo pipefail

echo "📥 Downloading CoreDNS manifest template..."
wget -q https://raw.githubusercontent.com/coredns/deployment/master/kubernetes/coredns.yaml.sed -O coredns.yaml.sed

echo "📋 Creating editable copy..."
cp coredns.yaml.sed ~/coredns.yaml

echo "📥 Downloading CoreDNS deployment script..."
wget -q https://raw.githubusercontent.com/coredns/deployment/master/kubernetes/deploy.sh -O deploy.sh
chmod +x deploy.sh

echo "⚙️  Generating manifest with deploy.sh..."
./deploy.sh > ~/coredns.yaml

echo "🧹 Deleting existing KubeDNS if present..."
kubectl delete -f k8s-config/kube-dns.yaml >/dev/null 2>&1 || echo "KubeDNS already deleted."

echo "🧨 Removing existing CoreDNS deployment to avoid selector mutation errors..."
kubectl delete deployment coredns -n kube-system --ignore-not-found

echo "🚀 Applying CoreDNS manifest..."
kubectl apply -f ~/coredns.yaml

echo "✅ CoreDNS installed successfully!"

echo "💥 Introducing misconfiguration for troubleshooting practice..."
kubectl -n kube-system get configmap coredns -o yaml |
  sed 's/kubernetes/kubernetess/' |
  kubectl apply -f -

echo "♻️ Restarting CoreDNS pods..."
kubectl -n kube-system delete pod -l k8s-app=kube-dns

echo "✅ CoreDNS busted and ready for troubleshooting!"
