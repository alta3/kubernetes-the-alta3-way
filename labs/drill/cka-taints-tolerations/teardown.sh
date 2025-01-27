#!/bin/bash
set -euo pipefail

# teardown tasks go here
rm -f /opt/cka/answers/controller.taint /opt/cka/answers/node-1.taint &> /dev/null

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
