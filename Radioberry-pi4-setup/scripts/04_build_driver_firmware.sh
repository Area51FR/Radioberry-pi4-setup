#!/usr/bin/env bash
set -euo pipefail

cd ~/Radioberry-2.x
make driver firmware -j"$(nproc)"

echo "OK: driver + firmware built"
