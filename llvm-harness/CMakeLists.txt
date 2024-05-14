
#building out of llvm sources  is not possible, see:
#https://lists.llvm.org/pipermail/llvm-dev/2019-March/130706.html
message (STATUS "Found tool harness")

project("harness")

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

include_directories(include ${LLVM_BINARY_DIR}/lib/Target/ARM ${LLVM_SOURCE_DIR}/lib/Target/ARM ${LLVM_BINARY_DIR}/lib/Target/RISCV ${LLVM_SOURCE_DIR}/lib/Target/RISCV)

add_llvm_tool(harness
  llvm-harness.cpp
  Disassembler.cpp
  )

#add_subdirectory(lib)

target_link_libraries(harness PRIVATE ${llvm_libs})

# cmake_minimum_required(VERSION 3.20.0)
# project(llvm-harness)

# find_package(LLVM REQUIRED CONFIG)

# message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
# message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# # Set your project compile flags.
# # E.g. if using the C++ header files
# # you will need to enable C++11 support
# # for your compiler.

# include_directories(${LLVM_INCLUDE_DIRS})
# separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
# add_definitions(${LLVM_DEFINITIONS_LIST})

# # Now build our tools
# add_executable(llvm-harness llvm-harness.cpp)

# # Find the libraries that correspond to the LLVM components
# # that we wish to use
# llvm_map_components_to_libnames(llvm_libs all-targets mc mcparser support targetparser)
# # llvm_map_components_to_libnames(llvm_libs support core irreader)

# # Link against LLVM libraries
# target_link_libraries(llvm-harness ${llvm_libs})

# # set(LLVM_LINK_COMPONENTS
# #   AllTargetsAsmParsers
# #   AllTargetsDescs
# #   AllTargetsDisassemblers
# #   AllTargetsInfos
# #   MC
# #   MCParser
# #   Support
# #   TargetParser
# #   )

# # add_llvm_tool(llvm-mc
# #   llvm-mc.cpp
# #   Disassembler.cpp
# #   )
