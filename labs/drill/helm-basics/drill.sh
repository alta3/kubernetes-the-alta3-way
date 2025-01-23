#!/bin/bash
set -euo pipefail

# Check if Helm is installed
if ! helm version &>/dev/null; then
  echo "Helm is not installed. Installing Helm..."
  sudo snap install helm --classic
else
  echo "Helm is already installed."
fi

# Define the Helm chart directory
HELM_CHART_DIR="/home/student/ckad-helm-task"

# Ensure the Helm chart directory exists
if [ ! -d "$HELM_CHART_DIR" ]; then
  echo "Helm chart directory does not exist. Creating..."
  mkdir -p "$HELM_CHART_DIR/templates"
else
  echo "Helm chart directory exists."
fi

# Create Chart.yaml with the specified content
echo "Creating Chart.yaml in the Helm chart directory..."
cat <<EOF > "$HELM_CHART_DIR/Chart.yaml"
apiVersion: v2
name: ckad-helm-task
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.0"
EOF

# Clear the templates directory without affecting other files
echo "Clearing the templates directory..."
rm -rf "$HELM_CHART_DIR/templates/*"

# Add deployment.yaml to the templates directory
echo "Creating deployment.yaml in templates..."
cat <<EOF > "$HELM_CHART_DIR/templates/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gimli
  namespace: battleofhelmsdeep
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: gimli
  template:
    metadata:
      labels:
        app: gimli
    spec:
      containers:
      - name: gimli
        image: {{ .Values.image.repository }}
        ports:
        - containerPort: 80
EOF

# Add namespace.yaml to the templates directory
echo "Creating namespace.yaml in templates..."
cat <<EOF > "$HELM_CHART_DIR/templates/namespace.yaml"
apiVersion: v1
kind: Namespace
metadata:
  name: battleofhelmsdeep
EOF

# Replace the values.yaml file
echo "Replacing values.yaml in the Helm chart directory..."
cat <<EOF > "$HELM_CHART_DIR/values.yaml"
# Default values for ckad-helm-task.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

# This will set the replicaset count more information can be found here: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/
replicaCount: 1

# This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/containers/images/
image:
  repository: nginx
EOF

echo "Script execution completed successfully."
