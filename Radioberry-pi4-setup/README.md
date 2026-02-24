# Radioberry on Raspberry Pi 4 (Bookworm 64-bit) — Clean Setup & Troubleshooting

Goal: a reproducible install of **Radioberry-2.x** on a **Raspberry Pi 4** running **Raspberry Pi OS / Debian Bookworm (64-bit)**.

This repo includes:
- build + install `wdsp` (`libwdsp.so`)
- build + install kernel module `radioberry.ko` (persistent across reboot)
- install daemon binary (`/usr/local/bin/radioberry`)
- install device tree overlay (`radioberry.dtbo`)
- enable SPI + overlay in `config.txt`
- systemd autostart + module autoload
- health checks + debugging scripts
- Spark/Thetis notes + test plan

Upstream sources (references):
- Radioberry-2.x: https://github.com/pa3gsb/Radioberry-2.x
- SparkSDR: https://www.sparksdr.com/
- Thetis: https://github.com/TAPR/OpenHPSDR-Thetis
- Metis “How it works” (discovery/UDP concepts): https://raw.githubusercontent.com/TAPR/OpenHPSDR-SVN/master/Metis/Documentation/Metis-%20How%20it%20works_V1.33.pdf

> Note: OpenHPSDR discovery typically involves UDP traffic around port **1024** (implementation dependent). Use `scripts/11_capture_udp1024.sh` to verify.

---

## Hardware prerequisites (real-world)
- Raspberry Pi 4 + Radioberry mounted **with perfect header contact**
  - “almost seated” is not enough → IRQ/RX can be dead or flaky.
- Network up (LAN/Wi-Fi) so your client (Spark/Thetis) can discover it.

---

## Quickstart (on the Pi — Terminal)

```bash
cd ~
git clone https://github.com/Area51FR/Radioberry-pi4-setup.git
cd Radioberry-pi4-setup
chmod +x scripts/*.sh

bash scripts/00_env_info.sh
bash scripts/01_install_deps.sh
bash scripts/02_clone_radioberry.sh
bash scripts/03_build_wdsp.sh
bash scripts/04_build_driver_firmware.sh
bash scripts/05_install_kernel_module.sh
bash scripts/06_install_daemon_overlay_config.sh
bash scripts/07_install_systemd_service.sh

# Gateware (rbf) — you must provide the file locally:
bash scripts/08_install_gateware.sh /path/to/radioberry.rbf

sudo reboot

# After reboot:
bash scripts/09_check_status.sh
```

---

## What gets installed

- `libwdsp.so` → `/usr/local/lib/`
- `radioberry.ko` → `/lib/modules/$(uname -r)/kernel/drivers/sdr/radioberry.ko`
- daemon binary `radioberry` → `/usr/local/bin/radioberry`
- overlay `radioberry.dtbo` → `<boot>/overlays/`
- `config.txt` updated:
  - `dtparam=spi=on`
  - `dtoverlay=radioberry`
- module autoload → `/etc/modules-load.d/radioberry.conf`
- systemd unit → `/etc/systemd/system/radioberry.service`

---

## Common pitfalls (fast checklist)

1) **Header contact**
   - Most frequent root cause of “no RX / IRQ not increasing”.

2) **Wrong gateware (CL016 vs CL025)**
   - Service can start, but samples/IRQ behave weird or stay dead.

3) **Module not persistent after reboot**
   - Only `insmod` is not enough → must be in `/lib/modules/...` + `depmod`.

4) **Client can’t discover device**
   - Windows firewall blocks UDP discovery.
   - Debug with `scripts/11_capture_udp1024.sh`.

---

## Docs
- Gateware & FPGA chip: `docs/chip_cl016_cl025.md`, `docs/gateware_notes.md`
- Spark: `docs/spark_setup.md`
- Thetis: `docs/thetis_setup.md`
- Test plan: `docs/testplan.md`
- Troubleshooting: `docs/troubleshooting.md`

---

## Uninstall / cleanup (Terminal)
```bash
bash scripts/99_uninstall.sh
```

---

## Credits
- Radioberry-2.x: Johan Maas (PA3GSB)
- wdsp / OpenHPSDR ecosystem
