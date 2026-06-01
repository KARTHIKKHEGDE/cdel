#include "CFGAnalyzer.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"

#include <iterator>
#include <map>
#include <set>

namespace wifa
{

    static void dfs(const llvm::BasicBlock *BB,
                    std::set<const llvm::BasicBlock *> &visited,
                    std::set<const llvm::BasicBlock *> &inStack,
                    std::set<std::pair<const llvm::BasicBlock *,
                                       const llvm::BasicBlock *>> &backEdges)
    {
        visited.insert(BB);
        inStack.insert(BB);

        const llvm::Instruction *term = BB->getTerminator();
        for (unsigned i = 0, e = term->getNumSuccessors(); i < e; ++i)
        {
            const llvm::BasicBlock *succ = term->getSuccessor(i);
            if (inStack.count(succ))
            {
                backEdges.insert({BB, succ});
            }
            else if (!visited.count(succ))
            {
                dfs(succ, visited, inStack, backEdges);
            }
        }
        inStack.erase(BB);
    }

    CFGData buildCFG(const llvm::Function &F)
    {
        CFGData cfg;

        std::set<const llvm::BasicBlock *> visited;
        std::set<const llvm::BasicBlock *> inStack;
        std::set<std::pair<const llvm::BasicBlock *, const llvm::BasicBlock *>>
            backEdges;
        dfs(&F.getEntryBlock(), visited, inStack, backEdges);

        std::map<const llvm::BasicBlock *, std::string> bbId;
        int idx = 0;
        for (auto &BB : F)
        {
            std::string name = BB.getName().str();
            if (name.empty())
            {
                name = "bb" + std::to_string(idx);
            }
            bbId[&BB] = name;
            idx++;
        }

        for (auto &BB : F)
        {
            CFGNode node;
            node.id = bbId[&BB];
            node.label = bbId[&BB];
            node.instructionCount =
                static_cast<uint64_t>(std::distance(BB.begin(), BB.end()));
            for (auto &I : BB)
            {
                node.opcodes.push_back(I.getOpcodeName());
            }
            cfg.nodes.push_back(node);
        }

        for (auto &BB : F)
        {
            const llvm::Instruction *term = BB.getTerminator();
            unsigned numSucc = term->getNumSuccessors();

            for (unsigned i = 0; i < numSucc; ++i)
            {
                const llvm::BasicBlock *succ = term->getSuccessor(i);
                CFGEdge edge;
                edge.source = bbId[&BB];
                edge.target = bbId[succ];

                if (backEdges.count({&BB, succ}))
                {
                    edge.type = "back_edge";
                }
                else if (numSucc == 1)
                {
                    edge.type = "unconditional";
                }
                else if (i == 0)
                {
                    edge.type = "true";
                }
                else
                {
                    edge.type = "false";
                }
                cfg.edges.push_back(edge);
            }
        }

        return cfg;
    }

} // namespace wifa
