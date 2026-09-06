#!/usr/bin/env bash
# One-shot: create github.com/hasky00/kizami-core and push this folder.
# Needs the GitHub CLI logged in:  gh auth login
set -e
git init -b master
git add .
git commit -m "kizami-core: timecode counter, LTC docs, roadmap"
gh repo create hasky00/kizami-core --public --source=. --push \
  --description "FPGA side of Kizami — cycle-exact timecode + audio witness on iCE40"
