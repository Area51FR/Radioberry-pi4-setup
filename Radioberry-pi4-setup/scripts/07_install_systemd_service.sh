#!/usr/bin/env bash
set -euo pipefail

UNIT_DST="/etc/systemd/system/radioberry.service"
RB=~/Radioberry-2.x

# This supports BOTH:
# - If /etc/init.d/radioberryd exists -> use it (forking)
# - Else -> run /usr/local/bin/radioberry directly (simple)

# Optionally install init.d wrapper if present in upstream tree:
INIT_SRC_CANDIDATE="${RB}/SBC/rpi-4/device_driver/firmware/radioberryd"
if [[ -f "$INIT_SRC_CANDIDATE" ]]; then
  echo "== installing init.d wrapper =="
  sudo install -m 0755 "$INIT_SRC_CANDIDATE" /etc/init.d/radioberryd
fi

echo "== install systemd unit =="
if [[ -x /etc/init.d/radioberryd ]]; then
  sudo tee "$UNIT_DST" >/dev/null <<'EOF'
[Unit]
Description=Radioberry SDR (init.d wrapper)
Wants=network-online.target
After=network-online.target

[Service]
Type=forking
User=root
Group=root
ExecStart=/etc/init.d/radioberryd start
ExecStop=/etc/init.d/radioberryd stop
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
else
  sudo tee "$UNIT_DST" >/dev/null <<'EOF'
[Unit]
Description=Radioberry SDR (direct daemon)
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=root
Group=root
ExecStart=/usr/local/bin/radioberry
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
fi

sudo chmod 644 "$UNIT_DST"

echo "== enable module autoload =="
echo radioberry | sudo tee /etc/modules-load.d/radioberry.conf >/dev/null

echo "== reload + enable now =="
sudo systemctl daemon-reload
sudo systemctl enable --now radioberry.service

echo "OK: radioberry.service installed + enabled"
echo "Tip: reboot once, then run: bash scripts/09_check_status.sh"
