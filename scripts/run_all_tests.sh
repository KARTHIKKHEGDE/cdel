#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PASS_DIR="$ROOT_DIR/pass"
PLUGIN="$PASS_DIR/output/libWeightedFreqPass.so"
RESULTS_DIR="$PASS_DIR/output/per_test"

mkdir -p "$RESULTS_DIR"

echo "==> Generating IR files"
"$ROOT_DIR/scripts/gen_ir.sh"

echo ""
echo "==> Running WIFA pass on each IR file individually"

for ir in "$PASS_DIR"/ir_files/*.ll; do
  name=$(basename "$ir" .ll)
  echo "  Analyzing: $name"
  WIFA_OUTPUT_DIR="$PASS_DIR/output" \
  opt-17 --load-pass-plugin="$PLUGIN" \
         --passes="wifa" \
         "$ir" -o /dev/null 2>/dev/null

  # Copy the generated report with per-test name
  cp "$PASS_DIR/output/analysis_report.json" "$RESULTS_DIR/${name}.json"
  cp "$PASS_DIR/output/analysis_report.csv"  "$RESULTS_DIR/${name}.csv"
done

echo ""
echo "==> All per-test reports saved to: $RESULTS_DIR"
ls -lh "$RESULTS_DIR"
