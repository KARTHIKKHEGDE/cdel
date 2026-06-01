#include "CallGraphAnalyzer.h"

#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"

#include <set>

namespace wifa
{

    CallGraphData buildCallGraph(const llvm::Module &M)
    {
        CallGraphData cg;
        std::set<std::string> seenNodes;
        std::set<std::pair<std::string, std::string>> seenEdges;

        for (auto &F : M)
        {
            if (F.isDeclaration())
            {
                continue;
            }

            std::string caller = F.getName().str();
            if (!seenNodes.count(caller))
            {
                cg.nodes.push_back(caller);
                seenNodes.insert(caller);
            }

            for (auto &BB : F)
            {
                for (auto &I : BB)
                {
                    if (auto *CI = llvm::dyn_cast<llvm::CallInst>(&I))
                    {
                        llvm::Function *callee = CI->getCalledFunction();
                        if (!callee || callee->isDeclaration())
                        {
                            continue;
                        }

                        std::string calleeName = callee->getName().str();
                        if (!seenNodes.count(calleeName))
                        {
                            cg.nodes.push_back(calleeName);
                            seenNodes.insert(calleeName);
                        }

                        auto edge = std::make_pair(caller, calleeName);
                        if (!seenEdges.count(edge))
                        {
                            cg.edges.push_back({caller, calleeName});
                            seenEdges.insert(edge);
                        }
                    }
                    else if (auto *II = llvm::dyn_cast<llvm::InvokeInst>(&I))
                    {
                        llvm::Function *callee = II->getCalledFunction();
                        if (!callee || callee->isDeclaration())
                        {
                            continue;
                        }

                        std::string calleeName = callee->getName().str();
                        if (!seenNodes.count(calleeName))
                        {
                            cg.nodes.push_back(calleeName);
                            seenNodes.insert(calleeName);
                        }

                        auto edge = std::make_pair(caller, calleeName);
                        if (!seenEdges.count(edge))
                        {
                            cg.edges.push_back({caller, calleeName});
                            seenEdges.insert(edge);
                        }
                    }
                }
            }
        }

        return cg;
    }

} // namespace wifa
