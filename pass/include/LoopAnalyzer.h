#pragma once

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Function.h"

#include <string>
#include <vector>

namespace wifa
{

    struct BackEdge
    {
        std::string from;
        std::string to;
    };

    struct LoopData
    {
        std::string header;
        int depth = 0;
        bool isInnermost = false;
        std::vector<BackEdge> backEdges;
        uint64_t instructionCount = 0;
        double weightedScore = 0.0;
    };

    std::vector<LoopData> analyzeLoops(const llvm::Function &F,
                                       llvm::LoopInfo &LI);

} // namespace wifa
