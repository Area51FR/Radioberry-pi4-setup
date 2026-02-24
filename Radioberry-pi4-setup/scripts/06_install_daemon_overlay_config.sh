#!/usr/bin/env bash
set -euo pipefail

RB=~/Radioberry-2.x

# Boot dir detection (Bookworm often uses /boot/firmware)
if [[ -d /boot/firmware ]]; then
  BOOT=/boot/firmware
else
  BOOT=/boot
fi

CFG="${BOOT}/config.txt"
OVL_DIR="${BOOT}/overlays"

OVL_SRC="${RB}/SBC/rpi-4/device_driver/driver/radioberry.dtbo"
DAEMON_SRC="${RB}/SBC/rpi-4/device_driver/firmware/radioberry"
DAEMON_DST="/usr/local/bin/radioberry"

echo "== stop service (avoid restart loop during install) =="
sudo systemctl disable --now radioberry.service 2>/dev/null || true

echo "== install overlay =="
sudo install -D -m 0644 "$OVL_SRC" "${OVL_DIR}/radioberry.dtbo"
ls -l "${OVL_DIR}/radioberry.dtbo"

echo "== install daemon binary =="
sudo install -m 0755 "$DAEMON_SRC" "$DAEMON_DST"
ls -l "$DAEMON_DST"

echo "== backup config.txt =="
sudo cp -a "$CFG" "${CFG}.bak.$(date +%Y%m%d-%H%M%S)"

echo "== ensure SPI + dtoverlay in config.txt =="
# Ensure dtparam=spi=on
if grep -qE '^[#[:space:]]*dtparam=spi=on' "$CFG"; then
  sudo sed -i 's/^[#[:space:]]*dtparam=spi=on/dtparam=spi=on/' "$CFG"
else
  grep -q '^dtparam=spi=on$' "$CFG" || echo 'dtparam=spi=on' | sudo tee -a "$CFG" >/dev/null
fi

# Ensure dtoverlay=radioberry
grep -q '^dtoverlay=radioberry$' "$CFG" || echo 'dtoverlay=radioberry' | sudo tee -a "$CFG" >/dev/null

echo "OK: overlay + daemon installed, config updated: $CFG"
echo "Relevant lines:"
sudo grep -nE '(^dtparam=spi=on$|^dtoverlay=radioberry$)' "$CFG" || true
