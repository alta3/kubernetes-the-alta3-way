#!/usr/bin/env bash

set -euo pipefail

# Temporary proof that this setup script executed.
date --iso-8601=seconds > /home/student/proof.txt

ssh controller 'sudo bash -s' <<'EOF'
set -euo pipefail

UNIT="/etc/systemd/system/kube-apiserver.service"
BACKUP="${UNIT}.kubectl-top-backup"

BROKEN='  --requestheader-allowed-names="front-proxy-client"'
FIXED='  --requestheader-allowed-names="front-proxy-client" \'

# Ensure the expected service file exists.
if [[ ! -f "$UNIT" ]]; then
    echo "ERROR: $UNIT was not found." >&2
    exit 1
fi

# Ensure the certificate files referenced later in the unit exist.
for REQUIRED_FILE in \
    /var/lib/kubernetes/front-proxy-client.pem \
    /var/lib/kubernetes/front-proxy-client-key.pem
do
    if [[ ! -f "$REQUIRED_FILE" ]]; then
        echo "ERROR: Required file not found: $REQUIRED_FILE" >&2
        exit 1
    fi
done

# If the line is already fixed, do nothing.
if grep -Fqx -- "$FIXED" "$UNIT"; then
    echo "Kubernetes API aggregation configuration is already correct."

# If the known broken line exists, repair it once.
elif grep -Fqx -- "$BROKEN" "$UNIT"; then
    cp --preserve=all "$UNIT" "$BACKUP"

    sed -i \
        '/^  --requestheader-allowed-names="front-proxy-client"$/s/$/ \\/' \
        "$UNIT"

    # Confirm the edit produced exactly the expected corrected line.
    if ! grep -Fqx -- "$FIXED" "$UNIT"; then
        cp --preserve=all "$BACKUP" "$UNIT"
        echo "ERROR: Could not safely correct $UNIT. The original was restored." >&2
        exit 1
    fi

    systemctl daemon-reload

    # Restore the original unit if kube-apiserver cannot restart successfully.
    if ! systemctl restart kube-apiserver; then
        cp --preserve=all "$BACKUP" "$UNIT"
        systemctl daemon-reload
        systemctl restart kube-apiserver || true
        echo "ERROR: kube-apiserver could not start. The original unit was restored." >&2
        exit 1
    fi

    if ! systemctl is-active --quiet kube-apiserver; then
        cp --preserve=all "$BACKUP" "$UNIT"
        systemctl daemon-reload
        systemctl restart kube-apiserver || true
        echo "ERROR: kube-apiserver is not active. The original unit was restored." >&2
        exit 1
    fi

    echo "Kubernetes API aggregation configuration corrected."

# Refuse to modify an unexpected configuration.
else
    echo "ERROR: The expected kube-apiserver configuration line was not found." >&2
    echo "No changes were made." >&2
    exit 1
fi
EOF

# Wait up to 60 seconds for the API server to answer again.
for ((ATTEMPT = 1; ATTEMPT <= 30; ATTEMPT++)); do
    if kubectl get --raw=/readyz >/dev/null 2>&1; then
        echo "Kubernetes API server is ready."
        exit 0
    fi

    sleep 2
done

echo "ERROR: Kubernetes API server did not become ready within 60 seconds." >&2
exit 1
