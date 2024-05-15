
#building out of llvm sources  is not possible, see:
#https://lists.llvm.org/pipermail/llvm-dev/2019-March/130706.html
message (STATUS "Found tool harness")

cmake_minimum_required(VERSION 3.20.0)

project("harness")

enable_language(ASM_NASM)

set(LLVM_LINK_COMPONENTS
  AllTargetsAsmParsers
  AllTargetsDescs
  AllTargetsDisassemblers
  AllTargetsInfos
  MC
  MCParser
  Support
  TargetParser
  )

message (STATUS "${PROJECT_BINARY_DIR}$")
message (STATUS "${PROJECT_SOURCE_DIR}$")

set_source_files_properties(foo.cpp PROPERTIES COMPILE_FLAGS -f elf64 -O0)

add_llvm_tool(harness
  llvm-harness.cpp
  Disassembler.cpp
  timing-harness/rdpmc.c
  timing-harness/harness.c
  timing-harness/run_test.nasm
  )

#add_subdirectory(timing-harness)

target_link_libraries(harness PRIVATE ${llvm_libs})
