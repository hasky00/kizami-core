#!/usr/bin/env bash
# Build the fake-Icestudio layout FPGALab reads, OUTSIDE the apio project tree
set -e
SIM=~/kizami-sim/ice-build/kizami
mkdir -p "$SIM"
cp icestudio/kizami.ice ~/kizami-sim/
sed 's/^module top/module main/' rtl/top.v > "$SIM/main.v"
cat rtl/timecode.v rtl/seg7.v rtl/display.v >> "$SIM/main.v"
cp rtl/alhambra_ii.pcf "$SIM/main.pcf"
echo "sim tree ready: ~/kizami-sim/kizami.ice"
