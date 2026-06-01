#include "LoopAnalyzer.h"

#include "WeightedFreqPass.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"

#include <algorithm>

namespace wifa
{

    static void processLoop(const llvm::Loop *L, int depth,
                            std::vector<LoopData> &results)
    {
        LoopData ld;
        ld.depth = depth;
        ld.isInnermost = L->getSubLoops().empty();
        ld.instructionCount = 0;
        ld.weightedScore = 0.0;

        if (L->getHeader())
        {
            ld.header = L->getHeader()->getName().str();
            if (ld.header.empty())
            {
                ld.header = "header_" + std::to_string(depth);
            }
        }

        llvm::SmallVector<llvm::BasicBlock *, 4> latches;
        L->getLoopLatches(latches);
        for (auto *latch : latches)
        {
            BackEdge be;
            be.from = latch->getName().str();
            if (be.from.empty())
            {
                be.from = "latch_" + std::to_string(depth);
            }
            be.to = ld.header;
            ld.backEdges.push_back(be);
        }

        for (auto *BB : L->blocks())
        {
            for (auto &I : *BB)
            {
                ld.instructionCount++;
                ld.weightedScore += getWeight(I.getOpcodeName());
            }
        }

        results.push_back(ld);

        for (auto *sub : L->getSubLoops())
        {
            processLoop(sub, depth + 1, results);
        }
    }

    std::vector<LoopData> analyzeLoops(const llvm::Function &F,
                                       llvm::LoopInfo &LI)
    {
        std::vector<LoopData> results;
        for (auto *L : LI)
        {
            processLoop(L, 1, results);
        }

        std::sort(results.begin(), results.end(),
                  [](const LoopData &a, const LoopData &b)
                  {
                      return a.weightedScore > b.weightedScore;
                  });
        return results;
    }

} // namespace wifa
