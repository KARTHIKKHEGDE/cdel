#pragma once

#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "CFGAnalyzer.h"
#include "CallGraphAnalyzer.h"
#include "CostModel.h"
#include "LoopAnalyzer.h"

#include <map>
#include <string>
#include <vector>

namespace wifa
{

  struct FunctionStats
  {
    std::string name;
    uint64_t basicBlockCount = 0;
    uint64_t totalInstructions = 0;
    double weightedScore = 0.0;
    std::map<std::string, uint64_t> instrCounts;
  };

  struct AnalysisResult
  {
    std::string moduleName;
    uint64_t totalInstructions = 0;
    double totalWeightedScore = 0.0;
    std::map<std::string, uint64_t> globalCounts;
    std::vector<FunctionStats> functions;
  };

  struct CyclomaticData
  {
    int complexity = 0;
    int edges = 0;
    int nodes = 0;
    int components = 1;
  };

  struct AnalysisExtras
  {
    std::map<std::string, CFGData> cfg;
    std::map<std::string, CyclomaticData> cyclomatic;
    std::map<std::string, std::vector<LoopData>> loops;
    CallGraphData callGraph;
    CostModelResult costModel;
    std::map<std::string, std::vector<std::string>> opcodeSequence;
  };

  struct WeightedFreqPass : llvm::PassInfoMixin<WeightedFreqPass>
  {
    llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &MAM);

    void exportJSON(const AnalysisResult &result,
                    const AnalysisExtras &extras,
                    const std::string &outputDir) const;
    void exportCSV(const AnalysisResult &result,
                   const std::string &outputDir) const;
    void printSummary(const AnalysisResult &result) const;
  };

  double getWeight(const std::string &opcode);

} // namespace wifa
