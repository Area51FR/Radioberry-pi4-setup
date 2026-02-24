# Troubleshooting (short & real-world)

## 1) `modprobe radioberry` -> "Module not found"
Cause:
- module not in `/lib/modules/$(uname -r)/...` or no `depmod`.

Fix (Terminal):
```bash
bash scripts/05_install_kernel_module.sh
```

## 2) `/dev/radioberry` missing
Cause:
- module not loaded or driver init failed.

Fix (Terminal):
```bash
sudo modprobe radioberry
dmesg | grep -i radioberry | tail -n 150
```

## 3) IRQ not increasing / RX dead
Very often:
1) board not seated perfectly (contact!)
2) wrong gateware (CL016 vs CL025)
3) SPI/overlay not active

Debug (Terminal):
```bash
bash scripts/10_debug_rx_irq.sh
```

## 4) Spark/Thetis can’t discover
Discovery is typically UDP; Windows firewall can block it.

Pi debug (Terminal):
```bash
bash scripts/09_check_status.sh
bash scripts/11_capture_udp1024.sh eth0   # or wlan0
```

If you see packets in tcpdump but client still finds nothing:
- Windows firewall / network profile / VLAN issues
