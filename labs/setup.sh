#!/bin/bash
set -euo pipefail

pushd setup >> /dev/null
if [ -z ${1+x} ]; then 
    echo "[-] missing lab-name, to run:"
    printf "\t./setup.sh lab-name\n"
    exit -1
fi

if [ ! -d "$1" ]; then
    echo "[-] $1 setup not found"
    exit -1
fi

echo "[+] Teardown:"
for f in *; do
    if [ -d "$f" ]; then
	bash "${f}/teardown.sh" &
    fi
done
wait
echo "[+] Setup:"
bash "${1}/setup.sh"
popd >> /dev/null
