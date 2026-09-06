# kizami-core

The FPGA side of [Kizami](https://github.com/hasky00/kizami) — a Nostr-timestamped
audio witness. Runs on the open-hardware Alhambra II (iCE40HX4K).

- `rtl/` — Verilog. `timecode.v` is the HH:MM:SS:FF counter, `top.v` maps it to LEDs.
- `icestudio/` — `.ice` designs for Icestudio / FPGALab.
- `labs/` — FPGALab workbench configs.
- `docs/` — LTC frame layout and the roadmap.

## Simulate (no hardware)
1. Open `icestudio/` design in Icestudio, build once so `ice-build/` exists.
2. `fpga-lab --ice icestudio/<design>.ice --clock-hz 1200000` (slow mode, readable LEDs).

## Build & flash (Alhambra II)
```
pip install apio && apio install --all
apio build && apio upload
```

LED0–4 = frame count in binary, LED7 = blinks once per second.

License: MIT
