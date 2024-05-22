#!/bin/bash

VER="18.1.4"

rele() {
  cd build || exit
  cmake \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -Wno-dev \
    -Wno-suggest-override \
    -DLLVM_USE_LINKER=lld \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_INCLUDE_BENCHMARKS=OFF \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DLLVM_OPTIMIZED_TABLEGEN=ON \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -GNinja \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DLLVM_EXTERNAL_HARNESS_SOURCE_DIR=../llvm-harness \
    -DLLVM_EXTERNAL_PROJECTS="harness" \
    ../dependencies/llvm-$VER.src
  cp compile_commands.json ../compile_commands.json
}

build() {
  cd build || exit
  ninja -k 100
  cd ..
}

cla() {
  rm -rf build
  rm compile_commands.json
  cd dependencies || exit
  rm -rf llvm*.src clang*.src cmake*
  cd ..
}

cl() {
  rm -rf build
  rm -rf .cache
}

getllvm() {
  if [ ! -d dependencies/llvm-$VER.src ]; then
    while true; do
      echo "Do you wish to install llvm-$VER [Y/N]?"
      read -r yn
      case $yn in
      [Yy]*)
        cd dependencies || exit
        wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/llvm-$VER.src.tar.xz
        tar -xf llvm-$VER.src.tar.xz
        rm llvm-$VER.src.tar.xz
        cd ..
        break
        ;;
      [Nn]*) break ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    echo "It seems llvm-$VER is already checked out!"
    echo "If that is not the case please remove the folder and try again."
  fi
}

getcmake() {
  if [ ! -f dependencies/cmake-$VER ]; then
    while true; do
      echo "Do you wish to install cmake-$VER , which is neede to build llvm and clang [Y/N]?"
      read -r yn
      case $yn in
      [Yy]*)
        cd dependencies || exit
        wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/cmake-$VER.src.tar.xz
        tar -xf cmake-$VER.src.tar.xz
        rm cmake-$VER.src.tar.xz
        mv cmake-$VER.src cmake
        touch cmake-$VER
        cd ..
        break
        ;;
      [Nn]*) break ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    echo "It seems cmake-$VER is already checked out!"
    echo "If that is not the case please remove the folder and try again."
  fi
}

getclang() {
  if [ ! -d dependencies/clang-$VER.src ]; then
    while true; do
      echo ""
      echo "Do you wish to install clang-$VER [Y/N]?"
      read -r yn
      case $yn in
      [Yy]*)
        cd dependencies || exit
        wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/clang-$VER.src.tar.xz
        tar -xf clang-$VER.src.tar.xz
        rm clang-$VER.src.tar.xz
        cd ..
        break
        ;;
      [Nn]*) break ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    echo "It seems clang-$VER is already checked out!"
    echo "If that is not the case please remove the folder and try again."
  fi
}

pre() {
  getllvm
  getcmake
  #getclang
  BUILD_DIR="build/"
  if [ ! -d "$BUILD_DIR" ]; then
    mkdir build
  else
    echo "Build directory exists already, you may consider a clean!"
  fi

  COMPILE_COMMANDS="compile_commands.json"
  if [ ! -f "$COMPILE_COMMANDS" ]; then
    rm $COMPILE_COMMANDS
  fi
}

case $1 in
config | c)
  pre
  rele
  ;;
build | b)
  build
  ;;
clang)
  pre
  clang
  ;;
clean)
  cl
  ;;
cleanall)
  cla
  ;;
*)
  if [ $1 ]; then
    echo "Unknown argument: $1"
  fi
  echo "Script to configure llvm, clang and llvm-harness:"
  echo "  c | config                 Configure for MinSizeRelease."
  echo "  b | build                  Build the project."
  echo "  clean                      Removes build folder."
  echo "  cleanall                   Removes build folder and llvm + clang."
  exit
  ;;
esac
