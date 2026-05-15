cmake_minimum_required(VERSION 3.16)
project(WeightedFreqPass LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(LLVM_LINK_LLVM_DYLIB ON)
find_package(LLVM 17 REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

include_directories(${CMAKE_SOURCE_DIR}/include)

add_library(WeightedFreqPass MODULE
  src/WeightedFreqPass.cpp
  src/WeightConfig.cpp
  src/CFGAnalyzer.cpp
  src/LoopAnalyzer.cpp
  src/CallGraphAnalyzer.cpp
  src/CostModel.cpp
)

target_link_libraries(WeightedFreqPass LLVM)

set_target_properties(WeightedFreqPass PROPERTIES
  LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/output
)
