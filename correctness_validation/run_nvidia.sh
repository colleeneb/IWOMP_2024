#!/bin/bash

# PrgEnv-nvhpc/8.5.0

export NVIDIA_FLAGS="-mp=gpu -gpu=cc80"

#rm -rf OvO
#git clone https://github.com/TApplencourt/OvO.git
cd OvO

export OVO_TIMEOUT=60s
rm -rf test_result

CXX='nvc++' CXXFLAGS="-std=c++17 ${NVIDIA_FLAGS}" FC="nvfortran" FFLAGS="${NVIDIA_FLAGS}" ./ovo.sh run test_src

./ovo.sh report --summary test_result
 
cd ..
#rm -rf OpenMP_VV
#git clone git@github.com:OpenMP-Validation-and-Verification/OpenMP_VV.git

cd OpenMP_VV
git checkout 72ec153c94491cabbc1912f3fb5466b2c8d62e53
export OMPVV_NO_COMPILER_CHANGES=1
make tidy

make OMP_VERSION=4.5 CC='nvc  ${NVIDIA_FLAGS}' CXX='nvc++  ${NVIDIA_FLAGS}'  FC='nvfortran ${NVIDIA_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.0 CC='nvc  ${NVIDIA_FLAGS}' CXX='nvc++  ${NVIDIA_FLAGS}'  FC='nvfortran ${NVIDIA_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.1 CC='nvc  ${NVIDIA_FLAGS}' CXX='nvc++  ${NVIDIA_FLAGS}'  FC='nvfortran ${NVIDIA_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.2 CC='nvc  ${NVIDIA_FLAGS}' CXX='nvc++  ${NVIDIA_FLAGS}'  FC='nvfortran ${NVIDIA_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=6.0 CC='nvc  ${NVIDIA_FLAGS}' CXX='nvc++  ${NVIDIA_FLAGS}'  FC='nvfortran ${NVIDIA_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy
