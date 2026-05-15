#pragma once

#include "llvm/IR/Module.h"

#include <map>
#include <string>
#include <vector>

namespace wifa
{

    struct FunctionCost
    {
        std::string name;
        double executionEstimate = 0.0;
        double memoryPressure = 0.0;
    };

    struct CostModelResult
    {
        double totalExecutionEstimate = 0.0;
        double memoryPressureScore = 0.0;
        double bottleneckScore = 0.0;
        std::vector<std::string> bottleneckInstructions;
        std::map<std::string, FunctionCost> perFunction;
    };

    double getExecutionCost(const std::string &opcode);
    bool isMemoryOp(const std::string &opcode);
    bool isBottleneckOp(const std::string &opcode);

    CostModelResult buildCostModel(const llvm::Module &M);

} // namespace wifa
