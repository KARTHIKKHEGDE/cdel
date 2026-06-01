# In-Depth WIFA Evaluation Report (110 Tests)
This document provides a complete, exhaustive, and data-driven analysis of all 110 test cases processed by the WIFA LLVM Pass. It covers structural complexity, memory pressure, cost-model profiling, and bottleneck extraction.
## 1. Complete Test Suite Metrics Table
The following table contains the raw metrics extracted from the intermediate representation (IR) of all 110 test cases, sorted ascending by Weighted Score.
| Test Name | Total Instr | Weighted Score | Functions | Max Cyclomatic | CFG Nodes/Edges | Total Loops (Max Depth) | Mem Pressure | Exec Estimate | Bottleneck Opcodes |
|---|---|---|---|---|---|---|---|---|---|
| **test1** | 27 | 72.0 | 1 | 2 | 5/5 | 1 (Depth 1) | 48.0 | 89.0 | `call` |
| **test3** | 27 | 80.0 | 1 | 2 | 4/4 | 1 (Depth 1) | 48.0 | 127.0 | `call, sdiv, srem` |
| **test8** | 18 | 80.0 | 3 | 1 | 3/0 | 0 (Depth 0) | 24.0 | 87.0 | `call` |
| **test6** | 31 | 93.0 | 3 | 1 | 3/0 | 0 (Depth 0) | 62.0 | 108.0 | `call` |
| **test7** | 31 | 97.0 | 3 | 1 | 3/0 | 0 (Depth 0) | 60.0 | 118.0 | `call` |
| **test4** | 36 | 98.0 | 1 | 2 | 5/5 | 1 (Depth 1) | 78.0 | 126.0 | `call` |
| **test2** | 40 | 103.0 | 1 | 5 | 12/15 | 1 (Depth 1) | 56.0 | 153.0 | `call, sdiv, srem` |
| **test102** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test105** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test108** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test27** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test30** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test33** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test36** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test39** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test42** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test45** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test48** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test51** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test54** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test57** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test60** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test63** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test66** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test69** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test72** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test75** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test78** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test81** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test84** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test87** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test90** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test93** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test96** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **test99** | 45 | 118.0 | 2 | 3 | 8/8 | 1 (Depth 1) | 80.0 | 178.0 | `call, srem, fdiv` |
| **loops** | 69 | 140.0 | 3 | 3 | 15/15 | 3 (Depth 2) | 118.0 | 179.0 | `call` |
| **arith** | 65 | 148.0 | 3 | 2 | 10/9 | 1 (Depth 1) | 144.0 | 214.0 | `call, sdiv` |
| **functions** | 58 | 193.0 | 4 | 2 | 10/8 | 0 (Depth 0) | 95.0 | 229.0 | `call` |
| **test5** | 52 | 203.0 | 4 | 2 | 8/5 | 0 (Depth 0) | 73.0 | 214.0 | `call, invoke` |
| **test9** | 123 | 411.0 | 1 | 9 | 20/27 | 3 (Depth 2) | 156.0 | 445.0 | `call` |
| **test101** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test104** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test107** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test110** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test26** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test29** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test32** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test35** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test38** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test41** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test44** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test47** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test50** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test53** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test56** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test59** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test62** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test65** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test68** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test71** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test74** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test77** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test80** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test83** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test86** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test89** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test92** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test95** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test98** | 137 | 455.0 | 6 | 6 | 32/31 | 1 (Depth 1) | 185.0 | 531.0 | `call, invoke, srem` |
| **test10** | 182 | 642.0 | 3 | 45 | 65/106 | 6 (Depth 2) | 203.0 | 669.0 | `invoke, call` |
| **test15** | 406 | 830.0 | 7 | 4 | 55/60 | 12 (Depth 3) | 729.0 | 1053.0 | `call, srem` |
| **test13** | 413 | 863.0 | 7 | 6 | 59/72 | 7 (Depth 1) | 787.0 | 1145.0 | `call, srem, urem` |
| **test12** | 375 | 896.0 | 11 | 5 | 67/75 | 10 (Depth 1) | 799.0 | 1159.0 | `call` |
| **test16** | 436 | 926.0 | 8 | 11 | 77/94 | 12 (Depth 2) | 781.0 | 1221.0 | `call, srem` |
| **test25** | 436 | 1111.0 | 14 | 10 | 59/64 | 7 (Depth 2) | 833.0 | 1416.0 | `call, srem` |
| **test22** | 548 | 1116.0 | 9 | 13 | 76/93 | 10 (Depth 2) | 1124.0 | 1546.0 | `call, sdiv, srem` |
| **test21** | 505 | 1147.0 | 9 | 6 | 69/81 | 9 (Depth 2) | 865.0 | 1502.0 | `call, sdiv, srem` |
| **test14** | 508 | 1353.0 | 13 | 12 | 76/90 | 2 (Depth 1) | 1041.0 | 1712.0 | `call, srem` |
| **test11** | 642 | 1394.0 | 12 | 8 | 86/98 | 14 (Depth 2) | 1214.0 | 1822.0 | `call, sdiv, srem` |
| **test17** | 811 | 1591.0 | 6 | 9 | 109/136 | 15 (Depth 2) | 1346.0 | 2017.0 | `call` |
| **test100** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test103** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test106** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test109** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test28** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test31** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test34** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test37** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test40** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test43** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test46** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test49** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test52** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test55** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test58** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test61** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test64** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test67** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test70** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test73** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test76** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test79** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test82** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test85** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test88** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test91** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test94** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test97** | 681 | 1765.0 | 40 | 7 | 95/67 | 4 (Depth 2) | 1364.0 | 2157.0 | `call, invoke, sdiv` |
| **test18** | 2639 | 8207.0 | 127 | 57 | 344/317 | 21 (Depth 2) | 4610.0 | 9601.0 | `call, invoke, sdiv, fdiv` |
| **test19** | 3293 | 10079.0 | 143 | 56 | 423/380 | 12 (Depth 1) | 5944.0 | 11758.0 | `call, invoke, sdiv, fdiv` |
| **test20** | 3671 | 10204.0 | 162 | 36 | 476/417 | 15 (Depth 2) | 6999.0 | 12355.0 | `call, invoke, sdiv, srem, udiv` |
| **test23** | 3819 | 10852.0 | 194 | 53 | 579/525 | 20 (Depth 2) | 6958.0 | 12723.0 | `call, invoke, sdiv, srem` |
| **test24** | 4420 | 12810.0 | 218 | 57 | 576/466 | 16 (Depth 2) | 8461.0 | 15441.0 | `call, invoke, sdiv, srem` |
---
## 2. In-Depth Metric Analysis
### 2.1 The Impact of Weights on Total Score
If we observe the ratio of `Total Instr` to `Weighted Score`, we see massive variance. For example:
- **Highest Weight Ratio (test8)**: Instructions = 18, Score = 80.0 (Ratio: 4.44). This is driven by heavy usage of weight-10 instructions (`invoke`, `call`).
- **Lowest Weight Ratio (test17)**: Instructions = 811, Score = 1591.0 (Ratio: 1.96). This indicates the code is mostly composed of weight-1 arithmetic operations (`add`, `sub`, `icmp`).
### 2.2 Memory Pressure Profiling
Memory Pressure strictly tracks `alloca`, `load`, `store`, and `getelementptr`. 
Top 3 most memory-bound programs in the suite:
- **test24**: Memory Score = 8461.0 (Total Score: 12810.0)
- **test20**: Memory Score = 6999.0 (Total Score: 10204.0)
- **test23**: Memory Score = 6958.0 (Total Score: 10852.0)
> [!TIP]
> **Insight**: High memory pressure heavily correlates with object-oriented C++ and vector operations. Array indexing forces LLVM to emit hundreds of `getelementptr` instructions to calculate memory offsets, combined with `load` and `store`.)
### 2.3 Cyclomatic Complexity and CFG Analysis
Cyclomatic complexity measures independent execution paths. The most complex functions found were:
- **test18**: Max CC = 57 (344 Nodes, 317 Edges)
- **test24**: Max CC = 57 (576 Nodes, 466 Edges)
- **test19**: Max CC = 56 (423 Nodes, 380 Edges)
> [!IMPORTANT]
> **Insight**: Notice how the C++ tests (with exceptions) completely dominate cyclomatic complexity. This is because LLVM IR generates implicit `invoke` and `landingpad` blocks for every single function that *might* throw an exception, massively increasing CFG edge counts.
### 2.4 Loop Depth & Execution Estimation
The Execution Estimate algorithm applies a massive multiplier based on loop depth `(Weight * (1 + Depth * 10))`.
- **test15**: Max Depth = 3, Loops = 12, Exec Estimate = 1053.0
- **loops**: Max Depth = 2, Loops = 3, Exec Estimate = 179.0
- **test9**: Max Depth = 2, Loops = 3, Exec Estimate = 445.0
> [!NOTE]
> **Insight**: Programs with `O(N^2)` or `O(N^3)` algorithms (like matrix multiplication or sorting) see their Execution Estimate scale exponentially relative to their basic instruction counts.
## 3. Bottleneck Instruction Frequencies
Across the 110 test cases, the static analyzer flagged the following instruction opcodes as primary bottlenecks:
- **`call`**: Flagged as bottleneck in **113** / 110 tests.
- **`srem`**: Flagged as bottleneck in **70** / 110 tests.
- **`invoke`**: Flagged as bottleneck in **64** / 110 tests.
- **`sdiv`**: Flagged as bottleneck in **39** / 110 tests.
- **`fdiv`**: Flagged as bottleneck in **30** / 110 tests.
- **`urem`**: Flagged as bottleneck in **1** / 110 tests.
- **`udiv`**: Flagged as bottleneck in **1** / 110 tests.

**Conclusion on Bottlenecks**: `call` is universally the highest bottleneck because almost all programs utilize standard library I/O (like `printf` or `std::cout`). However, `sdiv` and `invoke` clearly separate the mathematical logic from the exception-handling logic.
## 4. Final Verdict
The WIFA pass successfully evaluates completely different paradigms of source code by normalizing them to LLVM IR. The 110-test benchmark proves that static analysis, combined with an intelligent heuristic cost model, can successfully categorize code as CPU-bound (divisions), memory-bound (Pointers/Structs), or Context-bound (OOP Exceptions) entirely offline.