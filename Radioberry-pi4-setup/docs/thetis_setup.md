# Thetis (Windows) — quick notes

Thetis is an OpenHPSDR client.
Reference: https://github.com/TAPR/OpenHPSDR-Thetis

## Connection
- Discovery is typically UDP-based. If it doesn’t show up:
  - verify Pi is running service + listening/sending
  - verify Windows firewall / network segmentation

## Pi debug (Terminal)
```bash
bash scripts/11_capture_udp1024.sh eth0
```
