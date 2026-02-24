#!/usr/bin/env bash
set -euo pipefail

cd ~/Radioberry-2.x/wdsp
make -j"$(nproc)"

sudo install -m 0644 libwdsp.so /usr/local/lib/libwdsp.so
sudo ldconfig

echo "OK: wdsp built + installed"
ldconfig -p | grep -i wdsp || true
