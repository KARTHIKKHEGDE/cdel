#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "Building WIFA (Weighted Instruction Freq Analysis)"
echo "========================================="

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
PASS_DIR="$ROOT_DIR/pass"

# 1. Check dependencies
if ! command -v cmake &> /dev/null; then
    echo "Error: cmake is required but not installed."
    exit 1
fi
if ! command -v ninja &> /dev/null; then
    echo "Error: ninja is required but not installed."
    exit 1
fi
if ! command -v llvm-config-17 &> /dev/null; then
    echo "Error: llvm-config-17 is required. Please install llvm-17."
    exit 1
fi

# 2. Download nlohmann/json if missing
if [ ! -f "$PASS_DIR/include/json.hpp" ]; then
    echo "Downloading nlohmann/json..."
    mkdir -p "$PASS_DIR/include"
    wget -q https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp -O "$PASS_DIR/include/json.hpp"
fi

# 3. Build the Pass
echo "Configuring CMake for LLVM Pass..."
mkdir -p "$PASS_DIR/build"
cd "$PASS_DIR/build"
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)

echo "Compiling Pass via Ninja..."
ninja

echo "========================================="
echo "Build complete! The pass plugin is located at:"
echo "pass/output/libWeightedFreqPass.so"
echo "You can now run: ./run.sh or ./scripts/run_all_tests.sh"
echo "========================================="
