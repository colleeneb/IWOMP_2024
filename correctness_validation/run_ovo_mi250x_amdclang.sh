#!/bin/bash

# TODO: Adapt to the machine
module purge
module load gcc/12.2.0 rocm/6.4.0

export OMPFLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx90a"
export OVO_TIMEOUT=60s
export OMP_TARGET_OFFLOAD=mandatory

logfile=$PWD/ovo_report_amdclang.txt
rm -f $logfile

pushd OvO

rm -rf test_result

CXX="amdclang++" CXXFLAGS="-std=c++17 $OMPFLAGS" FC="amdflang" FFLAGS="$OMPFLAGS" ./ovo.sh run test_src

./ovo.sh report --summary test_result > $logfile

popd
