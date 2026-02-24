# Gateware (`radioberry.rbf`) — notes

- You need a `radioberry.rbf` matching your FPGA (CL016 vs CL025).
- Install destination: `/lib/firmware/radioberry.rbf`

Install (Terminal):
```bash
bash scripts/08_install_gateware.sh /path/to/radioberry.rbf
```

If the gateware is wrong, you can see symptoms like:
- service starts, but no real RX / no IRQ increase
- clients may connect but waterfall stays dead
