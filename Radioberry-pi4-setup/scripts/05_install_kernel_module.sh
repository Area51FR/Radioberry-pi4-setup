#!/usr/bin/env bash
set -euo pipefail

DRVDIR=~/Radioberry-2.x/SBC/rpi-4/device_driver/driver
MODDST="/lib/modules/$(uname -r)/kernel/drivers/sdr"

cd "$DRVDIR"

# Optional: upstream install (may do insmod / headers). Not required for persistence.
sudo make install || true

# Required for reboot-persistent modprobe:
sudo install -D -m 0644 radioberry.ko "${MODDST}/radioberry.ko"
sudo depmod -a

echo "OK: installed ${MODDST}/radioberry.ko and ran depmod"
echo "Test load:"
sudo modprobe radioberry
lsmod | grep -i radioberry || true
ls -l /dev/radioberry 2>/dev/null || true
