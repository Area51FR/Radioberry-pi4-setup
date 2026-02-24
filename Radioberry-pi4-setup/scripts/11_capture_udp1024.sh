#!/usr/bin/env bash
set -euo pipefail

IFACE="${1:-}"
if [[ -z "$IFACE" ]]; then
  echo "Usage (Terminal): $0 <iface>   (example: $0 eth0  or  $0 wlan0)"
  echo
  echo "Interfaces:"
  ip -br link | awk '{print " - " $1}'
  exit 1
fi

echo "Capturing UDP port 1024 on $IFACE (Ctrl+C to stop)"
sudo tcpdump -ni "$IFACE" udp port 1024 -vv
