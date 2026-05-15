#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PASS_DIR="$ROOT_DIR/pass"
PLUGIN="$PASS_DIR/output/libWeightedFreqPass.so"

if [[ ! -f "$PLUGIN" ]]; then
  echo "Plugin not found: $PLUGIN"
  echo "Build it first:"
  echo "  cd pass && mkdir -p build && cd build"
  echo "  cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)"
  echo "  ninja"
  exit 1
fi

echo "==> Generating IR files"
"$ROOT_DIR/scripts/gen_ir.sh"

echo ""
echo "==> Running WIFA pass on all IR files"
mkdir -p "$PASS_DIR/output"

for ir in "$PASS_DIR"/ir_files/*.ll; do
  echo "  Analyzing: $ir"
  WIFA_OUTPUT_DIR="$PASS_DIR/output" \
  opt-17 --load-pass-plugin="$PLUGIN" \
         --passes="wifa" \
         "$ir" -o /dev/null 2>/dev/null
done

echo ""
echo "Reports written to: $PASS_DIR/output"
ls -lh "$PASS_DIR/output"
