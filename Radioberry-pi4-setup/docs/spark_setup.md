# SparkSDR (Windows) — quick notes

SparkSDR is a practical OpenHPSDR-compatible client.
Reference: https://www.sparksdr.com/

## Network basics
- Pi and Windows should be in the same LAN/subnet for easiest discovery.
- Windows firewall can block UDP discovery.

## Pi checks (Terminal)
```bash
bash scripts/09_check_status.sh
bash scripts/11_capture_udp1024.sh eth0
```

If tcpdump shows packets but Spark still can’t see it:
- firewall rules, network profile, VLAN, or multiple adapters on Windows
