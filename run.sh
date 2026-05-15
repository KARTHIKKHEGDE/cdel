#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v clang-17 >/dev/null 2>&1; then
  echo "clang-17 not found. Install LLVM 17 first."
  exit 1
fi

if ! command -v llvm-config-17 >/dev/null 2>&1; then
  echo "llvm-config-17 not found. Install LLVM 17 first."
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js not found. Install Node.js 18+ first."
  exit 1
fi

if [[ ! -f "$ROOT_DIR/pass/include/json.hpp" ]]; then
  echo "Missing json.hpp. Downloading..."
  wget -q https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp \
    -O "$ROOT_DIR/pass/include/json.hpp"
fi

echo "==> Building LLVM pass"
mkdir -p "$ROOT_DIR/pass/build"
cd "$ROOT_DIR/pass/build"
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)
ninja

cd "$ROOT_DIR"

echo "==> Running pass on test inputs"
./scripts/run_pass.sh

echo "==> Starting dashboard"
cd "$ROOT_DIR/dashboard"
if [[ ! -d node_modules ]]; then
  npm install
fi

npm run dev
