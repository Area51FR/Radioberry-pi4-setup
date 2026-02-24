# FPGA type: CL016 vs CL025 (Radioberry)

Why it matters:
- Your gateware file (`radioberry.rbf`) must match the FPGA type.
- Wrong gateware can look “kind of running” but RX/IRQ/samples stay dead or weird.

## How to identify (practical)
- Take a clear macro photo of the FPGA marking.
- Put it into the repo: `docs/images/fpga.jpg` (create folder if needed).
- Record:
  - CL016 or CL025
  - board revision (if printed)
  - gateware source/version

## Repo policy
- Do NOT commit gateware unless you are sure redistribution is allowed.
- Instead: document where to get it + install from a local file path.
