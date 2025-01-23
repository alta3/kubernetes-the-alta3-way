#!/bin/bash
set -euo pipefail

# Grab the release name for the chart "ckad-helm-task"
RELEASE_NAME=$(helm list --all-namespaces | grep "ckad-helm-task" | awk '{print $1}')

# Check if the release name was found
if [ -z "$RELEASE_NAME" ]; then
  echo "No release found for 'ckad-helm-task'. Nothing to uninstall."
  exit 0
fi

# Uninstall the Helm release
echo "Uninstalling release: $RELEASE_NAME"
if helm uninstall "$RELEASE_NAME" --namespace "$(helm list --filter "$RELEASE_NAME" -o json | jq -r '.[0].namespace')"; then
  echo "Release $RELEASE_NAME has been uninstalled successfully."

  # Check if ~/ckad-helm-task directory exists and delete it
  if [ -d "$HOME/ckad-helm-task" ]; then
    echo "Directory ~/ckad-helm-task exists. Deleting it..."
    rm -rf "$HOME/ckad-helm-task"
    echo "Directory ~/ckad-helm-task has been deleted."
  else
    echo "Directory ~/ckad-helm-task does not exist. No action needed."
  fi
else
  echo "Failed to uninstall release $RELEASE_NAME. Directory ~/ckad-helm-task will not be deleted."
  exit 1
fi
