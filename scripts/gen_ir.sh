#!/usr/bin/env bash
set -euo pipefail

PASS_DIR="$(cd "$(dirname "$0")/.." && pwd)/pass"
IR_DIR="$PASS_DIR/ir_files"

mkdir -p "$IR_DIR"

for src in "$PASS_DIR"/test/*.c; do
  name=$(basename "$src" .c)
  clang-17 -S -emit-llvm -O0 "$src" -o "$IR_DIR/${name}.ll"
  echo "${src} -> ${IR_DIR}/${name}.ll"
done
