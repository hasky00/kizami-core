# Kizami Core — plan

Hardware side of Kizami: a cycle-exact timecode + audio witness on an
iCE40 (Alhambra II), talking to the Rust app (hasky00/kizami) over UART.

```
mic / LTC audio → ADC (on-board, 12-bit x4) → iCE40: LTC decode + hash
                                                    │ UART (FTDI 2232H)
                                                    ▼
                                    Kizami (Rust) → Nostr → hasky.chat
```

## Milestones
1. [x] timecode counter on LEDs (simulate in FPGALab, then flash)
2. [ ] 7-segment display HH:MM:SS:FF on the FPGALab workbench
3. [ ] LTC encoder: pack frame (docs/ltc-frame.md) + biphase-mark out on a GPIO
4. [ ] UART TX: stream timecode to Kizami (lift from FPGAwars/Alhambra-II-FPGA examples)
5. [ ] LTC decoder via on-board ADC
6. [ ] SHA-256 core over the audio stream (check it fits HX4K in Verilator first)

## Assumptions
- 12 MHz clock → 480000 cycles/frame at 25 fps
- Open toolchain only: yosys / nextpnr / icestorm via Apio or Icestudio
- FPGALab (AGPL) is a tool, not a dependency; this repo stays MIT
