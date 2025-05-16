#!/bin/bash

module purge
module load gcc/13.3.1 rocm/6.4.0

export OMPFLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx942"
export OVO_TIMEOUT=60s
export OMP_TARGET_OFFLOAD=mandatory

pushd OvO

rm -rf test_result

CXX="amdclang++" CXXFLAGS="-std=c++17 $OMPFLAGS" FC="amdflang" FFLAGS="$OMPFLAGS" ./ovo.sh run test_src

./ovo.sh report --summary test_result

popd
