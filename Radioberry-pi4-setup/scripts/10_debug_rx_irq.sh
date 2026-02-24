#!/usr/bin/env bash
set -euo pipefail

echo "== IRQ entry (proc) =="
grep -n "radioberry" /proc/interrupts || echo "NO radioberry IRQ entry"
echo

sum_irq() {
  awk '
    /radioberry/ {
      s=0;
      for(i=2;i<=NF;i++){
        if($i ~ /^[0-9]+$/) s+=$i
        else break
      }
      print s
    }' /proc/interrupts | head -n 1
}

echo "== IRQ delta test (2s) =="
A="$(sum_irq || true)"
sleep 2
B="$(sum_irq || true)"
echo "IRQ sum before: ${A:-?} after: ${B:-?}"
echo

echo "== debugfs pinctrl (optional) =="
if ! mount | grep -q "/sys/kernel/debug"; then
  sudo mount -t debugfs none /sys/kernel/debug 2>/dev/null || true
fi
sudo grep -RIn "gpio25" /sys/kernel/debug/pinctrl 2>/dev/null | head -n 30 || true
echo

echo "== raspi-gpio (optional) =="
if command -v raspi-gpio >/dev/null 2>&1; then
  sudo raspi-gpio get 23 || true
  sudo raspi-gpio get 24 || true
  sudo raspi-gpio get 25 || true
  sudo raspi-gpio get 26 || true
  sudo raspi-gpio get 27 || true
else
  echo "raspi-gpio not found (ok)"
fi
