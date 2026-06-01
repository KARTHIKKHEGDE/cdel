#include "WeightedFreqPass.h"

#include <unordered_map>

namespace wifa {

static const std::unordered_map<std::string, double> WEIGHTS = {
    {"add", 1.0},   {"sub", 1.0},   {"mul", 3.0},   {"sdiv", 5.0},
    {"udiv", 5.0},  {"srem", 5.0},  {"urem", 5.0},  {"neg", 1.0},

    {"fadd", 2.0},  {"fsub", 2.0},  {"fmul", 4.0},  {"fdiv", 8.0},
    {"frem", 8.0},  {"fneg", 2.0},

    {"alloca", 1.0}, {"load", 2.0},  {"store", 3.0},
    {"getelementptr", 2.0}, {"fence", 3.0}, {"atomicrmw", 6.0},
    {"cmpxchg", 6.0},

    {"br", 1.0},    {"switch", 2.0}, {"ret", 1.0},
    {"call", 10.0}, {"invoke", 10.0}, {"resume", 5.0},
    {"callbr", 10.0}, {"indirectbr", 5.0},

    {"and", 1.0},   {"or", 1.0},    {"xor", 1.0},
    {"shl", 1.0},   {"lshr", 1.0},  {"ashr", 1.0},

    {"icmp", 1.0},  {"fcmp", 2.0},  {"select", 2.0},

    {"trunc", 1.0}, {"zext", 1.0},  {"sext", 1.0},
    {"fptrunc", 1.0}, {"fpext", 1.0},
    {"fptosi", 2.0}, {"fptoui", 2.0},
    {"sitofp", 2.0}, {"uitofp", 2.0},
    {"ptrtoint", 1.0}, {"inttoptr", 1.0}, {"bitcast", 0.5},

    {"extractelement", 3.0}, {"insertelement", 3.0},
    {"shufflevector", 4.0}, {"extractvalue", 1.0},
    {"insertvalue", 1.0},

    {"phi", 1.0}, {"landingpad", 2.0},
    {"unreachable", 0.0}, {"va_arg", 3.0},
};

double getWeight(const std::string &opcode) {
  auto it = WEIGHTS.find(opcode);
  if (it != WEIGHTS.end()) {
    return it->second;
  }
  return 1.0;
}

} // namespace wifa
