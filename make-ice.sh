#!/usr/bin/env bash
# Rebuild the fake-Icestudio layout FPGALab reads from rtl/
set -e
mkdir -p icestudio/ice-build/kizami
sed 's/^module top/module main/' rtl/top.v > icestudio/ice-build/kizami/main.v
cat rtl/timecode.v rtl/seg7.v rtl/display.v >> icestudio/ice-build/kizami/main.v
cp rtl/alhambra_ii.pcf icestudio/ice-build/kizami/main.pcf
echo "icestudio/ice-build/kizami/main.v rebuilt"
