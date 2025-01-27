#!/bin/bash
set -euo pipefail

# drill setup tasks go here
kubectl apply -f https://static.alta3.com/courses/cka/exam/deppy.yml

echo "[+] Task setup complete! You can now begin. Good luck!"
