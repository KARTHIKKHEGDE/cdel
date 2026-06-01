# WIFA - Weighted Instruction Frequency Analysis

LLVM Instruction Frequency Analysis pipeline with a C++17 LLVM pass and a React dashboard.

## Requirements

- LLVM 17 tools in PATH: `clang-17`, `opt-17`, `llvm-config-17`
- CMake + Ninja
- Node.js 18+
- `wget` (for the json header download)
- `lsof` (optional, used by `stopeverything.sh`)

## Quick Start

The fastest way to build, run the pass on test inputs, and start the dashboard:

```bash
./run.sh
```

## Manual Setup

### 1) Download json.hpp (one-time)

```bash
cd pass/include
wget https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp
```

### 2) Build the LLVM pass

```bash
cd pass
mkdir -p build
cd build
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)
ninja
```

### 3) Run analysis on test inputs

```bash
./scripts/run_pass.sh
```

Reports are written to `pass/output/analysis_report.json` and
`pass/output/analysis_report.csv`.

### 4) Launch the dashboard + API

```bash
cd dashboard
npm install
npm run dev
```

Open the UI and paste or upload C/C++ code. The API runs at
`http://localhost:3001` by default.

## Project Layout

- `pass/` - LLVM pass source, build, and output
- `scripts/` - helper scripts for IR generation and batch runs
- `dashboard/` - React UI and Express API server

## Scripts

- `run.sh` - build pass, run tests, then start the dashboard
- `runeverything.sh` - same as `run.sh`
- `stopeverything.sh` - stop UI and API processes on common ports
- `scripts/gen_ir.sh` - generate `.ll` files from `pass/test/*.c`
- `scripts/run_pass.sh` - run the pass on all IR files

## Notes

- The pass is built as a plugin and loaded via `opt-17 --passes=wifa`.
- The pass writes JSON and CSV reports to the directory in `WIFA_OUTPUT_DIR`.
- The dashboard expects `pass/output/libWeightedFreqPass.so` to exist.
