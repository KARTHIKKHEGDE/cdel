# Design

## 1. Goal and Approach
The objective of WIFA (Weighted Instruction Frequency Analysis) is to extract actionable intelligence from C/C++ programs without executing them. By operating at the LLVM Intermediate Representation (IR) layer, WIFA transcends source-level syntactic sugar and provides a normalized view of program execution. 

We approach this by building an **Out-of-Tree LLVM Module Pass**. The pass iterates through modules, functions, basic blocks, and individual instructions to compute aggregated metrics.

## 2. Architecture
The system consists of three distinct layers:
1. **Compilation Layer (`scripts/gen_ir.sh`)**: Translates standard C and C++ code into `.ll` files using `clang-17` and `clang++-17`. It uses `-O0` to preserve the original structural complexity before LLVM's aggressive optimization passes erase them.
2. **Analysis Layer (`WeightedFreqPass.cpp`)**: An LLVM 17 modern module pass (`PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM)`) that performs the heavy lifting.
3. **Visualization Layer (`dashboard/`)**: A React/Vite frontend coupled with an Express backend that ingests the JSON output to generate interactive charts and UI elements.

## 3. Data Structures & Output Format
We standardized on JSON as the primary communication medium between the LLVM C++ pass and the UI. The JSON schema encompasses:
- `instructions`: Raw frequency count of opcodes.
- `functions`: Per-function metrics and instruction counts.
- `cyclomatic_complexity`: Structural complexity of basic blocks and edges.
- `loops`: Nesting depths, basic block counts, and innermost loop classification.
- `cost_model`: Bottlenecks, memory pressure, and execution estimations.
- `cfg` / `call_graph`: Graph-based representation of the program flow.

## 4. Alternative Approaches Considered
- **Clang AST Analysis**: We considered analyzing the Abstract Syntax Tree via a Clang plugin. *Reason for rejection*: ASTs are language-dependent (C vs C++) and highly verbose. Analyzing LLVM IR provides a uniform instruction set (e.g., `br`, `alloca`, `getelementptr`) regardless of the frontend language.
- **Dynamic Binary Instrumentation (DBI)**: Tools like Intel Pin or Valgrind could provide true runtime frequencies. *Reason for rejection*: DBI introduces massive runtime overhead and requires comprehensive test input data to trigger all code paths. Static analysis (our approach) achieves full code coverage instantly.
- **LLVM Function Pass**: We considered writing a `FunctionPass`. *Reason for rejection*: Function passes cannot easily construct a global Call Graph or aggregate module-wide statistics efficiently. A `ModulePass` was strictly necessary to capture cross-function interactions and module-level aggregates.
