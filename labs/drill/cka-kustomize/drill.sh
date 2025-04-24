#!/bin/bash
set -euo pipefail

mkdir -p ~/kustomize/base ~/kustomize/overlay-prod

cat <<EOF > ~/kustomize/base/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-app
  labels:
    app: hello
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello
  template:
    metadata:
      labels:
        app: hello
    spec:
      containers:
      - name: hello
        image: nginx:1.19
        ports:
        - containerPort: 80
EOF

cat <<EOF > ~/kustomize/base/kustomization.yaml
resources:
- deployment.yaml
EOF

cat <<EOF > ~/kustomize/overlay-prod/kustomization.yaml
resources:
- ../base

namePrefix: prod-
labels:
  - pairs:
      environment: production

images:
- name: nginx
  newTag: "1.21"
EOF

echo "✅ Environment ready"
