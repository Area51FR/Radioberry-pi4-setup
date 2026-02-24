#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage (Terminal): $0 /path/to/radioberry.rbf"
  exit 1
fi

SRC="$1"
DST="/lib/firmware/radioberry.rbf"

sudo install -m 0644 "$SRC" "$DST"
ls -l "$DST"

echo "OK: gateware installed to $DST"
