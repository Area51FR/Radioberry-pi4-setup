# Test plan (minimal but reliable)

## A) Build smoke test (Pi — Terminal)
1) `bash scripts/03_build_wdsp.sh` -> `ldconfig -p | grep wdsp`
2) `bash scripts/04_build_driver_firmware.sh` -> no errors
3) `bash scripts/05_install_kernel_module.sh` -> `/dev/radioberry` exists

## B) Boot test
1) `sudo reboot`
2) `bash scripts/09_check_status.sh`
Expected:
- systemd: active
- module loaded
- `/dev/radioberry` present
- dmesg shows radioberry init (and often gateware load)

## C) Network/discovery test
1) On Pi: `bash scripts/11_capture_udp1024.sh eth0`
2) On Windows: start Spark/Thetis -> press discovery
3) tcpdump should show UDP traffic (common for OpenHPSDR discovery)
