# WIFA Project Deep Dive (Detailed)

WIFA (Weighted Instruction Frequency Analysis) is an LLVM 17 pass plus a React dashboard. The pass computes instruction statistics and structural metrics from LLVM IR. The dashboard calls a small Node API that compiles user code to LLVM IR, runs the pass, and visualizes the resulting JSON report.

This document is intentionally deep and code-oriented. Every major behavior is tied to the actual source files so you can trace the logic end-to-end.

## Repository Layout (What Lives Where)

- [README.md](README.md): Quick start, prerequisites, one-liners.
- [run.sh](run.sh): One-shot build + analyze + launch dashboard.
- [runeverything.sh](runeverything.sh): Wrapper that calls [run.sh](run.sh).
- [pass/](pass/): LLVM pass source code, headers, tests, output.
- [scripts/](scripts/): Shell helpers for IR generation and pass runs.
- [dashboard/](dashboard/): React app + Node API server.

## End-to-End Flow (Data and Control)

1) Frontend collects C/C++ source from the user.
2) Frontend sends source to the Node API via POST /api/analyze.
3) API writes the source to a temp directory and emits LLVM IR using clang-17.
4) API runs opt-17 with the WIFA pass plugin, which produces analysis_report.json.
5) API returns the JSON to the frontend.
6) Frontend parses JSON into UI-friendly structures and renders charts/tables.

Visually:

```
User source
  -> dashboard UI (POST /api/analyze)
  -> clang-17 (LLVM IR)
  -> opt-17 + WIFA pass (analysis_report.json)
  -> dashboard UI (parse + visualize)
```

## Build and Run (Detailed)

The recommended one-shot entry point is:

```bash
cd /home/karthik/llvm-project
./runeverything.sh
```

[runeverything.sh](runeverything.sh) simply calls [run.sh](run.sh). That script does the following:

1) Checks required tools on PATH: clang-17, llvm-config-17, node.
2) Ensures the nlohmann JSON header exists at [pass/include/json.hpp](pass/include/json.hpp).
3) Builds the pass (CMake + Ninja) into [pass/output/](pass/output/).
4) Runs the pass on test IR files using [scripts/run_pass.sh](scripts/run_pass.sh).
5) Starts the dashboard with npm run dev inside [dashboard/](dashboard/).

### Manual Build Steps (Pass Only)

```bash
cd /home/karthik/llvm-project/pass
mkdir -p build
cd build
cmake .. -G Ninja -DLLVM_DIR=$(llvm-config-17 --cmakedir)
ninja
```

The build is defined in [pass/CMakeLists.txt](pass/CMakeLists.txt). It compiles:

- [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp)
- [pass/src/WeightConfig.cpp](pass/src/WeightConfig.cpp)
- [pass/src/CFGAnalyzer.cpp](pass/src/CFGAnalyzer.cpp)
- [pass/src/LoopAnalyzer.cpp](pass/src/LoopAnalyzer.cpp)
- [pass/src/CallGraphAnalyzer.cpp](pass/src/CallGraphAnalyzer.cpp)
- [pass/src/CostModel.cpp](pass/src/CostModel.cpp)

The output plugin is written to [pass/output/libWeightedFreqPass.so](pass/output/libWeightedFreqPass.so).

### Manual Run Steps (Test Inputs)

```bash
cd /home/karthik/llvm-project
./scripts/run_pass.sh
```

The script:

- Calls [scripts/gen_ir.sh](scripts/gen_ir.sh) to compile C tests into LLVM IR.
- Runs opt-17 with the WIFA pass on each .ll file.
- Writes reports to [pass/output/analysis_report.json](pass/output/analysis_report.json) and [pass/output/analysis_report.csv](pass/output/analysis_report.csv).

## LLVM Pass Architecture (Actual Data Structures)

The public structs are defined in [pass/include/WeightedFreqPass.h](pass/include/WeightedFreqPass.h). These are the shapes that eventually become JSON.

### Core Output: AnalysisResult

- moduleName: name of the LLVM module
- totalInstructions: total instruction count across all functions
- totalWeightedScore: weighted sum across all instructions
- globalCounts: opcode -> count map for the entire module
- functions: array of per-function stats

### Per-Function Stats: FunctionStats

- name: function name (mangled in C++ by default)
- basicBlockCount: number of basic blocks
- totalInstructions: instruction count within the function
- weightedScore: weighted sum within the function
- instrCounts: opcode -> count map for that function

### Extra Analyses: AnalysisExtras

- cfg: per-function CFG nodes and edges
- cyclomatic: per-function complexity summary
- loops: per-function loop data
- callGraph: caller/callee relationships
- costModel: execution and memory estimates
- opcodeSequence: first 50 opcodes per function (for timeline UI)

## Weighted Instruction Frequency (How the Pass Works)

The main logic is in [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp).

1) Iterate every non-declaration function.
2) Iterate every basic block and instruction.
3) Count opcodes and accumulate a weighted score using getWeight.
4) Store per-function and global totals in AnalysisResult.

Weights are defined in [pass/src/WeightConfig.cpp](pass/src/WeightConfig.cpp). If an opcode is not listed, it defaults to 1.0. Example weights:

- add, sub => 1.0
- mul => 3.0
- sdiv/udiv/srem/urem => 5.0
- load => 2.0
- store => 3.0
- call/invoke => 10.0

The pass sorts functions by weighted score so the hottest functions appear first in the UI.

## CFG + Cyclomatic Complexity

The CFG builder is in [pass/src/CFGAnalyzer.cpp](pass/src/CFGAnalyzer.cpp) and emits CFGData from [pass/include/CFGAnalyzer.h](pass/include/CFGAnalyzer.h).

Key steps:

1) DFS from the entry block to find back edges (loop edges) via a recursion stack.
2) Assign each basic block a stable id (explicit name or generated bbN).
3) Emit a node with:
   - id, label
   - instructionCount
   - opcodes list for the block
4) Emit edges with types:
   - back_edge for loop edges
   - unconditional for single-successor edges
   - true / false for branch edges

Cyclomatic complexity is computed in [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp) from CFG data using:

$$M = E - N + 2P$$

Where:

- $E$ is edge count
- $N$ is node count
- $P$ is connected components (always 1 in this implementation)

The UI renders this in [dashboard/src/components/ComplexityTable.jsx](dashboard/src/components/ComplexityTable.jsx).

## Loop Analysis

Loop analysis is in [pass/src/LoopAnalyzer.cpp](pass/src/LoopAnalyzer.cpp) and uses LLVM LoopInfo.

For each loop:

- header: name of the loop header block
- depth: loop nesting depth (1 = outermost)
- isInnermost: true if there are no subloops
- backEdges: all latch -> header edges
- instructionCount: total instructions inside the loop
- weightedScore: sum of opcode weights inside the loop

Results are sorted by weightedScore so the most expensive loops are shown first. The UI renders this in [dashboard/src/components/LoopAnalysis.jsx](dashboard/src/components/LoopAnalysis.jsx).

## Call Graph

Call graph extraction is in [pass/src/CallGraphAnalyzer.cpp](pass/src/CallGraphAnalyzer.cpp).

The logic:

- Walk every instruction and detect CallInst and InvokeInst.
- If the callee is a defined function, add caller/callee edge.
- Keep a node list and deduplicate edges.

The UI renders this as a graph with layered layout in [dashboard/src/components/CallGraph.jsx](dashboard/src/components/CallGraph.jsx).

## Cost Model

The cost model is in [pass/src/CostModel.cpp](pass/src/CostModel.cpp).

It computes:

- totalExecutionEstimate: sum of per-op execution costs
- memoryPressureScore: sum of costs for memory ops
- bottleneckScore: sum of costs for bottleneck ops
- bottleneckInstructions: top 5 opcodes by bottleneck cost
- perFunction: executionEstimate and memoryPressure per function

Cost categories:

- EXEC_COSTS gives a rough cycle cost per opcode (default 1.0).
- MEM_OPS defines what counts as memory pressure.
- BOTTLENECK_OPS defines high-latency ops (div, remainder, call, atomic, etc).

The UI shows summary cards plus a stacked bar chart in [dashboard/src/components/CostModelView.jsx](dashboard/src/components/CostModelView.jsx).

## Opcode Timeline

The pass records the first 50 opcodes per function in AnalysisExtras.opcodeSequence. This is created in [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp).

The UI renders these opcodes as a sequence of colored chips in [dashboard/src/components/OpcodeTimeline.jsx](dashboard/src/components/OpcodeTimeline.jsx). Colors are derived from opcode categories (see [dashboard/src/utils/categories.js](dashboard/src/utils/categories.js)).

## JSON Report Schema (Exact Fields)

The JSON output is written by exportJSON in [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp). The shape is:

```json
{
  "module": "<string>",
  "total_instructions": <number>,
  "weighted_score": <number>,
  "instructions": { "add": 10, "mul": 2, ... },
  "functions": [
    {
      "name": "<function>",
      "basic_blocks": <number>,
      "total_instructions": <number>,
      "weighted_score": <number>,
      "instructions": { "add": 3, "ret": 1, ... }
    }
  ],
  "cfg": {
    "func": {
      "nodes": [
        { "id": "bb0", "label": "bb0", "instructions": 5, "ops": ["add", "br"] }
      ],
      "edges": [
        { "source": "bb0", "target": "bb1", "type": "true" }
      ]
    }
  },
  "cyclomatic_complexity": {
    "func": { "complexity": 2, "edges": 3, "nodes": 3, "components": 1 }
  },
  "loops": {
    "func": [
      { "header": "header_1", "depth": 1, "is_innermost": true,
        "instruction_count": 12, "weighted_score": 28.0,
        "back_edges": [ { "from": "latch_1", "to": "header_1" } ] }
    ]
  },
  "call_graph": {
    "nodes": ["foo", "bar"],
    "edges": [ { "caller": "foo", "callee": "bar" } ]
  },
  "cost_model": {
    "total_execution_estimate": 120.0,
    "memory_pressure_score": 40.0,
    "bottleneck_score": 25.0,
    "bottleneck_instructions": ["sdiv", "call"],
    "per_function": {
      "foo": { "execution_estimate": 30.0, "memory_pressure": 6.0 }
    }
  },
  "opcode_sequence": { "foo": ["alloca", "load", "add", "ret"] }
}
```

The frontend validates and normalizes this data in [dashboard/src/utils/parseReport.js](dashboard/src/utils/parseReport.js).

## Dashboard UI (What Each Panel Uses)

- Summary cards: [dashboard/src/components/SummaryCards.jsx](dashboard/src/components/SummaryCards.jsx)
  - module name, total instruction count, weighted score, hottest function
- Per-function table: [dashboard/src/components/FunctionTable.jsx](dashboard/src/components/FunctionTable.jsx)
  - sorted by weighted score; expandable opcode breakdown
- CFG viewer: [dashboard/src/components/CFGViewer.jsx](dashboard/src/components/CFGViewer.jsx)
  - uses cfg nodes/edges and edge types for styling
- Cyclomatic complexity: [dashboard/src/components/ComplexityTable.jsx](dashboard/src/components/ComplexityTable.jsx)
  - shows M, E, N with risk categories
- Loop analysis: [dashboard/src/components/LoopAnalysis.jsx](dashboard/src/components/LoopAnalysis.jsx)
  - shows loop depth, score, back edges
- Call graph: [dashboard/src/components/CallGraph.jsx](dashboard/src/components/CallGraph.jsx)
  - visualizes caller/callee graph
- Cost model: [dashboard/src/components/CostModelView.jsx](dashboard/src/components/CostModelView.jsx)
  - shows execution estimate, memory pressure, bottleneck ops
- Opcode timeline: [dashboard/src/components/OpcodeTimeline.jsx](dashboard/src/components/OpcodeTimeline.jsx)
  - renders the first 50 opcodes per function
- Source upload + samples: [dashboard/src/components/UploadPanel.jsx](dashboard/src/components/UploadPanel.jsx)
  - lets users paste source or select hardcoded samples

## Node API Details

The API lives in [dashboard/server/index.js](dashboard/server/index.js).

### POST /api/analyze

Input JSON:

```json
{ "source": "<code>", "filename": "input.c", "language": "c" }
```

Behavior:

1) Validate source text.
2) Verify the pass plugin exists at [pass/output/libWeightedFreqPass.so](pass/output/libWeightedFreqPass.so).
3) Create a temp directory under /tmp using fs.mkdtemp.
4) Write source file (input.c or input.cpp).
5) Run clang-17 to emit LLVM IR at input.ll.
6) Run opt-17 with --load-pass-plugin and --passes=wifa.
7) Read analysis_report.json from the temp output directory.
8) Return { report: <json> } to the UI.
9) Cleanup temp directory.

The pass uses the environment variable WIFA_OUTPUT_DIR to decide where to write the JSON and CSV. The API sets this to the temporary output directory so each request stays isolated.

### POST /api/demangle

Input JSON:

```json
{ "symbols": ["_Z3fooi", "_Z3bari"] }
```

Behavior:

- Uses c++filt to demangle C++ names.
- If c++filt is missing, returns an identity mapping.

The UI uses this for nicer names in graphs and tables.

## Scripts (What They Actually Do)

- [scripts/gen_ir.sh](scripts/gen_ir.sh)
  - Compiles every C file in [pass/test/](pass/test/) into LLVM IR.
  - Output goes to [pass/ir_files/](pass/ir_files/).
- [scripts/run_pass.sh](scripts/run_pass.sh)
  - Verifies the plugin exists.
  - Iterates all .ll files in [pass/ir_files/](pass/ir_files/).
  - Runs opt-17 with the pass on each file.
  - Writes reports to [pass/output/](pass/output/).

## Troubleshooting (Common Problems)

- clang-17 or llvm-config-17 missing: install LLVM 17 and ensure they are on PATH.
- opt-17 missing: install LLVM tools (often comes with clang-17 on Ubuntu).
- json.hpp missing: [run.sh](run.sh) downloads it, or place it manually in [pass/include/](pass/include/).
- UI says Failed to fetch: the Node API is not running, start with npm run dev in [dashboard/](dashboard/).
- Plugin not found: rebuild the pass so [pass/output/libWeightedFreqPass.so](pass/output/libWeightedFreqPass.so) exists.

## Extending The Project (Where To Plug In)

- Add new analysis fields: update [pass/src/WeightedFreqPass.cpp](pass/src/WeightedFreqPass.cpp) and extend AnalysisExtras in [pass/include/WeightedFreqPass.h](pass/include/WeightedFreqPass.h).
- Add new charts: create a component in [dashboard/src/components/](dashboard/src/components/) and parse new fields in [dashboard/src/utils/parseReport.js](dashboard/src/utils/parseReport.js).
- Adjust weights or cost model: edit [pass/src/WeightConfig.cpp](pass/src/WeightConfig.cpp) and [pass/src/CostModel.cpp](pass/src/CostModel.cpp).
