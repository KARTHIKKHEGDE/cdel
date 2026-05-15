#pragma once

#include "llvm/IR/Function.h"

#include <string>
#include <set>
#include <vector>

namespace wifa
{

    struct CFGNode
    {
        std::string id;
        std::string label;
        uint64_t instructionCount = 0;
        std::vector<std::string> opcodes;
    };

    struct CFGEdge
    {
        std::string source;
        std::string target;
        std::string type;
    };

    struct CFGData
    {
        std::vector<CFGNode> nodes;
        std::vector<CFGEdge> edges;
    };

    CFGData buildCFG(const llvm::Function &F);

} // namespace wifa
