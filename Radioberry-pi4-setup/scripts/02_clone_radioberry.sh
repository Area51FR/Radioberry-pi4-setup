#!/usr/bin/env bash
set -euo pipefail

cd ~
rm -rf Radioberry-2.x
git clone --depth 1 https://github.com/pa3gsb/Radioberry-2.x.git
cd Radioberry-2.x
git submodule update --init --recursive

echo "OK: cloned ~/Radioberry-2.x (with submodules)"
