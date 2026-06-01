#include "WeightedFreqPass.h"
#include "json.hpp"

#include "llvm/Analysis/LoopAnalysisManager.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/raw_ostream.h"

#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>

using json = nlohmann::json;

namespace wifa
{

  llvm::PreservedAnalyses
  WeightedFreqPass::run(llvm::Module &M, llvm::ModuleAnalysisManager &MAM)
  {
    (void)MAM;

    AnalysisResult result;
    AnalysisExtras extras;
    result.moduleName = M.getName().str();
    if (result.moduleName.empty())
    {
      result.moduleName = "unknown_module";
    }

    for (auto &F : M)
    {
      if (F.isDeclaration())
      {
        continue;
      }

      FunctionStats fs;
      fs.name = F.getName().str();

      for (auto &BB : F)
      {
        fs.basicBlockCount++;

        for (auto &I : BB)
        {
          std::string opcode = I.getOpcodeName();

          fs.instrCounts[opcode]++;
          fs.totalInstructions++;
          fs.weightedScore += getWeight(opcode);

          result.globalCounts[opcode]++;
          result.totalInstructions++;
          result.totalWeightedScore += getWeight(opcode);
        }
      }

      result.functions.push_back(std::move(fs));
    }

    std::sort(result.functions.begin(), result.functions.end(),
              [](const FunctionStats &a, const FunctionStats &b)
              {
                return a.weightedScore > b.weightedScore;
              });

    auto &FAM =
        MAM.getResult<llvm::FunctionAnalysisManagerModuleProxy>(M).getManager();

    std::map<std::string, CFGData> cfgMap;

    for (auto &F : M)
    {
      if (F.isDeclaration())
      {
        continue;
      }

      auto &LI = FAM.getResult<llvm::LoopAnalysis>(F);
      extras.loops[F.getName().str()] = analyzeLoops(F, LI);

      cfgMap[F.getName().str()] = buildCFG(F);
    }

    extras.cfg = cfgMap;

    for (auto &entry : cfgMap)
    {
      const std::string &fname = entry.first;
      const CFGData &cfg = entry.second;
      int edges = static_cast<int>(cfg.edges.size());
      int nodes = static_cast<int>(cfg.nodes.size());
      int components = 1;
      int complexity = edges - nodes + (2 * components);
      if (complexity < 1)
      {
        complexity = 1;
      }

      CyclomaticData cd;
      cd.complexity = complexity;
      cd.edges = edges;
      cd.nodes = nodes;
      cd.components = components;
      extras.cyclomatic[fname] = cd;
    }

    extras.callGraph = buildCallGraph(M);
    extras.costModel = buildCostModel(M);

    for (auto &F : M)
    {
      if (F.isDeclaration())
      {
        continue;
      }
      auto &seq = extras.opcodeSequence[F.getName().str()];
      int count = 0;
      for (auto &BB : F)
      {
        for (auto &I : BB)
        {
          if (count++ >= 50)
          {
            break;
          }
          seq.push_back(I.getOpcodeName());
        }
        if (count >= 50)
        {
          break;
        }
      }
    }

    printSummary(result);

    const char *outDir = std::getenv("WIFA_OUTPUT_DIR");
    std::string outputDir = outDir ? outDir : "./output";

    exportJSON(result, extras, outputDir);
    exportCSV(result, outputDir);

    return llvm::PreservedAnalyses::all();
  }

  void WeightedFreqPass::printSummary(const AnalysisResult &result) const
  {
    llvm::outs() << "\n";
    llvm::outs() << "===============================================\n";
    llvm::outs() << "Weighted Instruction Frequency Analysis\n";
    llvm::outs() << "===============================================\n";
    llvm::outs() << "Module         : " << result.moduleName << "\n";
    llvm::outs() << "Total instr    : " << result.totalInstructions << "\n";
    llvm::outs() << "Weighted score : " << result.totalWeightedScore << "\n";
    llvm::outs() << "Functions      : " << result.functions.size() << "\n\n";

    llvm::outs() << "Top 10 instructions (module-wide):\n";
    std::vector<std::pair<std::string, uint64_t>> sorted(
        result.globalCounts.begin(), result.globalCounts.end());
    std::sort(sorted.begin(), sorted.end(),
              [](auto &a, auto &b)
              { return a.second > b.second; });

    int n = 0;
    for (auto &entry : sorted)
    {
      if (n++ >= 10)
      {
        break;
      }
      const std::string &op = entry.first;
      uint64_t cnt = entry.second;
      double w = getWeight(op);
      llvm::outs() << "  " << llvm::format("%-16s", op.c_str())
                   << "count=" << llvm::format("%5llu", cnt) << "  "
                   << "weight=" << llvm::format("%.1f", w) << "  "
                   << "score=" << llvm::format("%8.1f", (double)cnt * w)
                   << "\n";
    }
    llvm::outs() << "\n";
  }

  void WeightedFreqPass::exportJSON(const AnalysisResult &result,
                                    const AnalysisExtras &extras,
                                    const std::string &outputDir) const
  {
    json j;
    j["module"] = result.moduleName;
    j["total_instructions"] = result.totalInstructions;
    j["weighted_score"] = result.totalWeightedScore;

    json globalMap = json::object();
    for (auto &entry : result.globalCounts)
    {
      globalMap[entry.first] = entry.second;
    }
    j["instructions"] = globalMap;

    json funcsArr = json::array();
    for (auto &fs : result.functions)
    {
      json f;
      f["name"] = fs.name;
      f["basic_blocks"] = fs.basicBlockCount;
      f["total_instructions"] = fs.totalInstructions;
      f["weighted_score"] = fs.weightedScore;

      json imap = json::object();
      for (auto &entry : fs.instrCounts)
      {
        imap[entry.first] = entry.second;
      }
      f["instructions"] = imap;
      funcsArr.push_back(f);
    }
    j["functions"] = funcsArr;

    json cfgJson = json::object();
    for (const auto &entry : extras.cfg)
    {
      const std::string &fname = entry.first;
      const CFGData &cfg = entry.second;
      json fn;
      json nodes = json::array();
      for (const auto &n : cfg.nodes)
      {
        json node;
        node["id"] = n.id;
        node["label"] = n.label;
        node["instructions"] = n.instructionCount;
        node["ops"] = n.opcodes;
        nodes.push_back(node);
      }
      json edges = json::array();
      for (const auto &e : cfg.edges)
      {
        json edge;
        edge["source"] = e.source;
        edge["target"] = e.target;
        edge["type"] = e.type;
        edges.push_back(edge);
      }
      fn["nodes"] = nodes;
      fn["edges"] = edges;
      cfgJson[fname] = fn;
    }
    j["cfg"] = cfgJson;

    json complexityJson = json::object();
    for (const auto &entry : extras.cyclomatic)
    {
      json c;
      c["complexity"] = entry.second.complexity;
      c["edges"] = entry.second.edges;
      c["nodes"] = entry.second.nodes;
      c["components"] = entry.second.components;
      complexityJson[entry.first] = c;
    }
    j["cyclomatic_complexity"] = complexityJson;

    json loopsJson = json::object();
    for (const auto &entry : extras.loops)
    {
      json arr = json::array();
      for (const auto &loop : entry.second)
      {
        json l;
        l["header"] = loop.header;
        l["depth"] = loop.depth;
        l["is_innermost"] = loop.isInnermost;
        l["instruction_count"] = loop.instructionCount;
        l["weighted_score"] = loop.weightedScore;
        json backEdges = json::array();
        for (const auto &be : loop.backEdges)
        {
          json b;
          b["from"] = be.from;
          b["to"] = be.to;
          backEdges.push_back(b);
        }
        l["back_edges"] = backEdges;
        arr.push_back(l);
      }
      loopsJson[entry.first] = arr;
    }
    j["loops"] = loopsJson;

    json cgJson;
    cgJson["nodes"] = extras.callGraph.nodes;
    json cgEdges = json::array();
    for (const auto &e : extras.callGraph.edges)
    {
      json edge;
      edge["caller"] = e.caller;
      edge["callee"] = e.callee;
      cgEdges.push_back(edge);
    }
    cgJson["edges"] = cgEdges;
    j["call_graph"] = cgJson;

    json cmJson;
    cmJson["total_execution_estimate"] = extras.costModel.totalExecutionEstimate;
    cmJson["memory_pressure_score"] = extras.costModel.memoryPressureScore;
    cmJson["bottleneck_score"] = extras.costModel.bottleneckScore;
    cmJson["bottleneck_instructions"] =
        extras.costModel.bottleneckInstructions;
    json pfJson = json::object();
    for (const auto &entry : extras.costModel.perFunction)
    {
      json x;
      x["execution_estimate"] = entry.second.executionEstimate;
      x["memory_pressure"] = entry.second.memoryPressure;
      pfJson[entry.first] = x;
    }
    cmJson["per_function"] = pfJson;
    j["cost_model"] = cmJson;

    json seqJson = json::object();
    for (const auto &entry : extras.opcodeSequence)
    {
      seqJson[entry.first] = entry.second;
    }
    j["opcode_sequence"] = seqJson;

    std::string path = outputDir + "/analysis_report.json";
    std::ofstream ofs(path);
    ofs << j.dump(2);
    ofs.close();

    llvm::outs() << "[JSON] Written to " << path << "\n";
  }

  void WeightedFreqPass::exportCSV(const AnalysisResult &result,
                                   const std::string &outputDir) const
  {
    std::string path = outputDir + "/analysis_report.csv";
    std::ofstream ofs(path);

    ofs << "Function,Instruction,Count,Weight,Score\n";

    for (auto &fs : result.functions)
    {
      std::vector<std::pair<std::string, uint64_t>> sorted(
          fs.instrCounts.begin(), fs.instrCounts.end());
      std::sort(sorted.begin(), sorted.end(),
                [](auto &a, auto &b)
                { return a.second > b.second; });

      for (auto &entry : sorted)
      {
        const std::string &op = entry.first;
        uint64_t cnt = entry.second;
        double w = getWeight(op);
        ofs << fs.name << "," << op << "," << cnt << ","
            << std::fixed << std::setprecision(1) << w << ","
            << std::fixed << std::setprecision(1) << (cnt * w) << "\n";
      }
    }

    ofs.close();
    llvm::outs() << "[CSV] Written to " << path << "\n\n";
  }

} // namespace wifa

llvm::PassPluginLibraryInfo getWeightedFreqPassPluginInfo()
{
  return {LLVM_PLUGIN_API_VERSION, "WeightedFreqPass", LLVM_VERSION_STRING,
          [](llvm::PassBuilder &PB)
          {
            PB.registerPipelineParsingCallback(
                [](llvm::StringRef Name, llvm::ModulePassManager &MPM,
                   llvm::ArrayRef<llvm::PassBuilder::PipelineElement>)
                {
                  if (Name == "wifa")
                  {
                    MPM.addPass(wifa::WeightedFreqPass());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
  return getWeightedFreqPassPluginInfo();
}
