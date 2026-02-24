#!/usr/bin/env bash
set -euo pipefail

echo "== systemd =="
systemctl is-enabled radioberry 2>/dev/null || true
systemctl is-active radioberry 2>/dev/null || true
echo
systemctl status radioberry --no-pager -n 50 || true
echo

echo "== module + device node =="
lsmod | grep -i radioberry || true
ls -l /dev/radioberry 2>/dev/null || true
echo

echo "== network ports (1024 is common in OpenHPSDR discovery) =="
sudo ss -lunp | grep ':1024' || echo "no UDP :1024 seen (may still be OK depending on implementation/state)"
sudo ss -ltnp | grep ':1024' || echo "no TCP :1024 seen"
echo

echo "== dmesg radioberry (tail) =="
dmesg | grep -i radioberry | tail -n 150 || true
echo

echo "== device-tree radio node (if present) =="
if [[ -f /proc/device-tree/radio/compatible ]]; then
  echo -n "compatible: "
  tr -d '\0' < /proc/device-tree/radio/compatible
  echo
else
  echo "No /proc/device-tree/radio node found"
fi
