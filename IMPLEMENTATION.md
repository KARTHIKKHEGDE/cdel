# WIFA Instruction Weight Heuristics & Implementation

## Core Analysis Logic
The foundation of WIFA's analysis is not raw instruction counts, but rather a **Weighted Instruction Model** implemented within a modern LLVM 17 `ModulePass`. This allows the analyzer to statically guess at potential runtime bottlenecks based on the computational cost of specific opcodes.

## The Cost Model (Weights)
Not all LLVM intermediate representation instructions map equally to CPU clock cycles. To reflect this, WIFA assigns static heuristic weights to instructions in `WeightedFreqPass.cpp`.

### 1. Control Flow & Context Switches (Weight: 10)
**Instructions:** `call`, `invoke`
- **Rationale**: Function calls are extremely expensive. They require pushing registers to the stack, setting up stack frames, and jumping to new memory addresses (thrashing the instruction cache). In C++, `invoke` is paired with exception handling overhead (`landingpad`), making it even more costly. These instructions are the primary driver of the "Bottleneck Score" in Object-Oriented code.

### 2. Complex Arithmetic (Weight: 5)
**Instructions:** `sdiv`, `udiv`, `urem`, `srem`, `fdiv`
- **Rationale**: Hardware division is notoriously slow compared to addition or multiplication. While an `add` might take 1 clock cycle, a 64-bit integer division can take 15-40 clock cycles. Mathematical programs heavily utilizing these opcodes are immediately flagged as CPU-bound.

### 3. Memory Access & Simple Math (Weight: 2 to 3)
**Instructions:** `store`, `fmul`, `mul` (Weight: 3) | `load`, `getelementptr` (Weight: 2)
- **Rationale**: Writing to memory (`store`) forces cache synchronization, which is more expensive than a read (`load`). Address computations (`getelementptr`) are common but map to simple lea (load effective address) x86 instructions, so they receive a mild weight.

### 4. Standard Operations (Weight: 1)
**Instructions:** `add`, `sub`, `icmp`, `alloca`, `br`
- **Rationale**: Basic arithmetic, comparisons, and branches are heavily optimized by modern superscalar CPUs (branch prediction, ALUs). They form the baseline weight of 1.

## Derived Metrics

### Execution Estimate Multiplier
WIFA calculates a simulated `total_execution_estimate`. It does this by combining the **Instruction Weights** with the **Loop Depth**:
```cpp
ExecutionEstimate = Sum(Instruction Weight * (1 + LoopDepth * 10))
```
An expensive instruction like `sdiv` (weight 5) placed inside a double-nested loop (depth 2) evaluates to `5 * (1 + 20) = 105` execution cost, instantly surfacing `O(N^2)` bottlenecks.

### Memory Pressure
Memory Pressure focuses exclusively on data footprint weights:
```cpp
MemoryPressure = Sum(Weights of alloca, load, store, getelementptr)
```

### Cyclomatic Complexity
Computed per function using the CFG of Basic Blocks: `M = Edges - Nodes + 2`. Exception-heavy C++ code results in massive edge graphs due to implicit unwinding paths.
