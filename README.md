# WIFA - Weighted Instruction Frequency Analysis Pass

LLVM Instruction Frequency Analysis pipeline with a C++17 LLVM pass and a React dashboard.

## Quick Start

### 1) Build the LLVM pass

```bash
cd pass
mkdir -p build
cd build
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)
ninja
```

### 2) Run analysis on the test inputs

```bash
cd /home/karthik/llvm-project
./scripts/run_pass.sh
```

### 3) Launch the dashboard + API

```bash
cd dashboard
npm install
npm run dev
```

Paste or upload C/C++ source in the UI and the backend will run the LLVM pass.

## Tech Stack

- Backend: LLVM 17, Clang 17, C++17, CMake, nlohmann/json
- Frontend: React 18, Vite, Tailwind CSS, Recharts, Zustand, shadcn/ui
- OS: Ubuntu 22.04 / WSL2

## Notes

- The LLVM pass is built as a plugin and loaded via `opt` with `--passes="wifa"`.
- JSON output is the bridge between the pass and the dashboard.
- For `json.hpp`, download the single header once:

```bash
cd pass/include
wget https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp
```

## Scripts

- `scripts/gen_ir.sh` generates .ll files from the C tests.
- `scripts/run_pass.sh` runs the pass on all generated IR files.
# cdel
