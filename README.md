# WIFA - Weighted Instruction Frequency Analysis

LLVM Instruction Frequency Analysis pipeline with a C++17 LLVM pass, comprehensive test suite, and a React dashboard.

## Overview
WIFA is a comprehensive LLVM-based analysis tool designed to statically analyze intermediate representation (IR) files. It identifies code complexity, potential bottlenecks, memory pressure, and structural characteristics like cyclomatic complexity and loop depths. 

The project evaluates source code by translating it to LLVM IR and analyzing opcode frequencies using a weighted scoring model.

## Quick Start
The fastest way to build, run the pass on all 25 test inputs, and start the dashboard is using the provided shell script:

```bash
./run.sh
```

## Manual Setup

### 1) Prerequisites
- LLVM 17 tools in your PATH: `clang-17`, `clang++-17`, `opt-17`, `llvm-config-17`
- CMake + Ninja
- Node.js 18+

### 2) Download Dependencies
Download the required `nlohmann/json` library (one-time):
```bash
cd pass/include
wget https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp
cd ../..
```

### 3) Build the LLVM Pass
The pass must be compiled as an out-of-tree LLVM plugin.
```bash
cd pass
mkdir -p build && cd build
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)
ninja
cd ../..
```

### 4) Run the Test Suite & Pass
We provide a comprehensive suite of 25 C/C++ test programs (algorithms, OOP, DP, etc.).
```bash
./scripts/run_all_tests.sh
```
This script automatically:
1. Compiles all `.c` and `.cpp` files in `pass/test/` to LLVM IR (`.ll`).
2. Runs the `libWeightedFreqPass.so` LLVM plugin over each file.
3. Outputs individual JSON reports to `pass/output/per_test/`.

### 5) Launch Dashboard
The dashboard provides a visual React interface for analyzing individual files dynamically.
```bash
cd dashboard
npm install
npm run dev
```
Open `http://localhost:3000` to view the UI. The API server runs at `http://localhost:3001`.

## Project Structure
- `src/` (symlinked to `pass/`) - The C++ LLVM pass source code and headers.
- `testcases/` (symlinked to `pass/test/`) - 110 diverse C/C++ test programs used for baseline and complex evaluations.
  - `pass/ir_files/` - Compiled LLVM intermediate representation code.
  - `pass/output/` - Output directory for CSV and JSON metrics.
- `scripts/` - Shell scripts (`gen_ir.sh`, `run_all_tests.sh`, `run_pass.sh`) to execute the pipeline.
- `./build.sh` - Standard build script to compile the LLVM pass.
- `./run.sh` - Full execution script to compile, run tests, and start the dashboard.
- `dashboard/` - React/Vite front-end and Express.js back-end for visualization.
- `output_images/` - Generated images and visual demonstration artifacts.

## Documentation
Please refer to the following documents in this repository for in-depth details:
- **[DESIGN.md](./DESIGN.md)** - Explores the design approach, architecture, and alternative considerations.
- **[IMPLEMENTATION.md](./IMPLEMENTATION.md)** - Details the LLVM pass logic, cost models, and structural CFG extractions.
- **[EVALUATION.md](./EVALUATION.md)** - Provides an exhaustive analysis of the 25 test cases, benchmark comparisons, and metrics.
