#pragma once

#include "llvm/IR/Module.h"

#include <set>
#include <string>
#include <vector>

namespace wifa
{

    struct CallEdge
    {
        std::string caller;
        std::string callee;
    };

    struct CallGraphData
    {
        std::vector<std::string> nodes;
        std::vector<CallEdge> edges;
    };

    CallGraphData buildCallGraph(const llvm::Module &M);

} // namespace wifa
