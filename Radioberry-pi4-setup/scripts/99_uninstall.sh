#!/usr/bin/env bash
set -euo pipefail

# Boot dir detection
if [[ -d /boot/firmware ]]; then
  BOOT=/boot/firmware
else
  BOOT=/boot
fi

echo "== stop/disable service =="
sudo systemctl disable --now radioberry.service 2>/dev/null || true

echo "== unload module =="
sudo rmmod radioberry 2>/dev/null || true

echo "== remove files =="
sudo rm -f /etc/modules-load.d/radioberry.conf
sudo rm -f /usr/local/bin/radioberry
sudo rm -f "${BOOT}/overlays/radioberry.dtbo"
sudo rm -f /lib/firmware/radioberry.rbf
sudo rm -f /etc/systemd/system/radioberry.service

sudo rm -f "/lib/modules/$(uname -r)/kernel/drivers/sdr/radioberry.ko"
sudo depmod -a
sudo systemctl daemon-reload

echo
echo "OK: removed installed files."
echo "NOTE: config.txt lines remain."
echo "If you want, remove manually in (nano): ${BOOT}/config.txt"
echo " - dtparam=spi=on"
echo " - dtoverlay=radioberry"
