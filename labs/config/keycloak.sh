#!/bin/bash

# ==========================================
# AUTOMATED KEYCLOAK SETUP FOR CLEARML LAB
# ==========================================

# 1. IDENTIFY UUID & CONSTRUCT URL
# ------------------------------------------
if [ -f /var/lib/cloud/data/instance-id ]; then
    # Extracts the UUID (e.g., d62b0f5e...) from "bchd.d62b0f5e..."
    VM_ID=$(cut -d. -f2 /var/lib/cloud/data/instance-id)
else
    echo "ERROR: Could not find instance-id file. Cannot determine UUID."
    exit 1
fi

# We use the requested 'kc-' subdomain prefix
KC_URL="kc-${VM_ID}.lms-us-east-1.alta3.com"

echo "Detected Environment ID: $VM_ID"
echo "Target Keycloak URL:     $KC_URL"
echo "------------------------------------------"

# 2. INSTALL DEPENDENCIES (JAVA & TOOLS)
# ------------------------------------------
echo "[1/5] Installing Java and dependencies..."
sudo apt update -qq
sudo apt install -y openjdk-17-jdk unzip curl jq -qq > /dev/null

# 3. INSTALL KEYCLOAK 26
# ------------------------------------------
echo "[2/5] Downloading and installing Keycloak 26..."
cd /opt
if [ ! -d "keycloak" ]; then
    sudo wget -q https://github.com/keycloak/keycloak/releases/download/26.0.0/keycloak-26.0.0.tar.gz
    sudo tar -xzf keycloak-26.0.0.tar.gz
    sudo mv keycloak-26.0.0 keycloak
    sudo chown -R student:student /opt/keycloak
fi

# 4. START KEYCLOAK (DETACHED MODE)
# ------------------------------------------
echo "[3/5] Starting Keycloak in background..."

# Define admin credentials for the server itself
export KEYCLOAK_ADMIN=admin
export KEYCLOAK_ADMIN_PASSWORD=admin

# Start command
# We use 'nohup' so it keeps running if the shell closes.
# We redirect logs to keycloak.log so we don't spam the student's terminal.
nohup /opt/keycloak/bin/kc.sh start-dev \
  --db=dev-file \
  --http-port=3456 \
  --http-enabled=true \
  --proxy-headers=xforwarded \
  --hostname="$KC_URL" \
  --hostname-strict=false > /opt/keycloak/keycloak.log 2>&1 &

# Store the PID so we can check it
KC_PID=$!
echo "Keycloak started with PID $KC_PID. Logs at /opt/keycloak/keycloak.log"

# 5. WAIT FOR STARTUP
# ------------------------------------------
echo "[4/5] Waiting for Keycloak to accept connections..."
TIMEOUT=0
while ! curl -s http://localhost:3456 > /dev/null; do
    sleep 2
    TIMEOUT=$((TIMEOUT+2))
    if [ $TIMEOUT -gt 60 ]; then
        echo "Error: Keycloak failed to start within 60 seconds."
        tail -n 20 /opt/keycloak/keycloak.log
        exit 1
    fi
    echo -n "."
done
echo " UP!"

# 6. CONFIGURE REALM, USER, AND CLIENT
# ------------------------------------------
echo "[5/5] Configuring 'clearml' Realm and Student User..."

KCADM="/opt/keycloak/bin/kcadm.sh"

# Authenticate CLI as Admin
$KCADM config credentials --server http://localhost:3456 --realm master --user admin --password admin

# Create Realm
$KCADM create realms -s realm=clearml -s enabled=true

# Create User 'student'
$KCADM create users -r clearml -s username=student -s enabled=true

# Set Password to 'student'
$KCADM set-password -r clearml --username student --new-password student

# Create Permissive Client 'lab-app'
# publicClient=true (No client secret required)
# redirectUris=["*"] (Allows redirects to anywhere - permissive for labs)
# webOrigins=["*"] (Allows CORS from anywhere)
$KCADM create clients -r clearml \
  -s clientId=lab-app \
  -s enabled=true \
  -s publicClient=true \
  -s "redirectUris=[\"*\"]" \
  -s "webOrigins=[\"*\"]" \
  -s standardFlowEnabled=true \
  -s directAccessGrantsEnabled=true

# ==========================================
# SETUP COMPLETE
# ==========================================
echo ""
echo "################################################################"
echo "  SETUP COMPLETE"
echo "################################################################"
echo ""
echo "  1. Keycloak URL (For your App):"
echo "     $KC_URL"
echo ""
echo "  2. Realm Name:"
echo "     clearml"
echo ""
echo "  3. Client ID:"
echo "     lab-app"
echo ""
echo "  4. Student Login Credentials:"
echo "     User:     student"
echo "     Password: student"
echo ""
echo "  5. Admin Console (If you need to debug):"
echo "     $KC_URL/admin"
echo "     (Login: admin / admin)"
echo ""
echo "################################################################"
