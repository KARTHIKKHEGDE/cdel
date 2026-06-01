#include "CostModel.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"

#include <algorithm>
#include <set>
#include <unordered_map>

namespace wifa
{

    static const std::unordered_map<std::string, double> EXEC_COSTS = {
        {"add", 1.0},
        {"sub", 1.0},
        {"mul", 3.0},
        {"sdiv", 20.0},
        {"udiv", 20.0},
        {"srem", 20.0},
        {"urem", 20.0},

        {"fadd", 4.0},
        {"fsub", 4.0},
        {"fmul", 5.0},
        {"fdiv", 15.0},
        {"frem", 20.0},

        {"load", 4.0},
        {"store", 4.0},
        {"alloca", 1.0},
        {"getelementptr", 1.0},
        {"atomicrmw", 30.0},
        {"cmpxchg", 30.0},

        {"br", 1.0},
        {"switch", 2.0},
        {"ret", 1.0},
        {"call", 10.0},
        {"invoke", 10.0},

        {"and", 1.0},
        {"or", 1.0},
        {"xor", 1.0},
        {"shl", 1.0},
        {"lshr", 1.0},
        {"ashr", 1.0},
        {"icmp", 1.0},
        {"fcmp", 2.0},
        {"select", 2.0},

        {"trunc", 1.0},
        {"zext", 1.0},
        {"sext", 1.0},
        {"bitcast", 0.0},
        {"fptosi", 3.0},
        {"sitofp", 3.0},

        {"extractelement", 3.0},
        {"insertelement", 3.0},
        {"shufflevector", 5.0},

        {"phi", 0.0},
        {"unreachable", 0.0},
    };

    static const std::set<std::string> MEM_OPS = {
        "load",
        "store",
        "alloca",
        "getelementptr",
        "atomicrmw",
        "cmpxchg",
        "fence",
    };

    static const std::set<std::string> BOTTLENECK_OPS = {
        "sdiv",
        "udiv",
        "srem",
        "urem",
        "fdiv",
        "frem",
        "call",
        "invoke",
        "atomicrmw",
        "cmpxchg",
    };

    double getExecutionCost(const std::string &opcode)
    {
        auto it = EXEC_COSTS.find(opcode);
        return (it != EXEC_COSTS.end()) ? it->second : 1.0;
    }

    bool isMemoryOp(const std::string &opcode)
    {
        return MEM_OPS.count(opcode) > 0;
    }

    bool isBottleneckOp(const std::string &opcode)
    {
        return BOTTLENECK_OPS.count(opcode) > 0;
    }

    CostModelResult buildCostModel(const llvm::Module &M)
    {
        CostModelResult result;
        std::map<std::string, double> bottleneckTotals;

        for (auto &F : M)
        {
            if (F.isDeclaration())
            {
                continue;
            }

            FunctionCost fc;
            fc.name = F.getName().str();

            for (auto &BB : F)
            {
                for (auto &I : BB)
                {
                    std::string op = I.getOpcodeName();
                    double cost = getExecutionCost(op);

                    fc.executionEstimate += cost;
                    result.totalExecutionEstimate += cost;

                    if (isMemoryOp(op))
                    {
                        fc.memoryPressure += cost;
                        result.memoryPressureScore += cost;
                    }

                    if (isBottleneckOp(op))
                    {
                        result.bottleneckScore += cost;
                        bottleneckTotals[op] += cost;
                    }
                }
            }

            result.perFunction[fc.name] = fc;
        }

        std::vector<std::pair<std::string, double>> btSorted(bottleneckTotals.begin(),
                                                             bottleneckTotals.end());
        std::sort(btSorted.begin(), btSorted.end(),
                  [](auto &a, auto &b)
                  { return a.second > b.second; });

        for (int i = 0; i < std::min<int>(btSorted.size(), 5); ++i)
        {
            result.bottleneckInstructions.push_back(btSorted[i].first);
        }

        return result;
    }

} // namespace wifa
