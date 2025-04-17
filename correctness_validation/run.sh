#!/bin/bash

export INTEL_FLAGS="-fiopenmp -fopenmp-targets=spir64 -fp-model=precise"

rm -rf OvO
git clone https://github.com/TApplencourt/OvO.git
cd OvO

export OVO_TIMEOUT=60s

CXX='icpx' CXXFLAGS="-std=c++17 ${INTEL_FLAGS}" FC="ifx" FFLAGS="${INTEL_FLAGS}" ./ovo.sh run test_src

./ovo.sh report --summary test_result
 

rm -rf OpenMP_VV

git clone git@github.com:OpenMP-Validation-and-Verification/OpenMP_VV.git

cd OpenMP_VV

make OMP_VERSION=4.5 CC='icx  ${INTEL_FLAGS}' CXX='icpx  ${INTEL_FLAGS}'  FC='ifx ${INTEL_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.0 CC='icx  ${INTEL_FLAGS}' CXX='icpx  ${INTEL_FLAGS}'  FC='ifx ${INTEL_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.1 CC='icx  ${INTEL_FLAGS}' CXX='icpx  ${INTEL_FLAGS}'  FC='ifx ${INTEL_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.2 CC='icx  ${INTEL_FLAGS}' CXX='icpx  ${INTEL_FLAGS}'  FC='ifx ${INTEL_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=6.0 CC='icx  ${INTEL_FLAGS}' CXX='icpx  ${INTEL_FLAGS}'  FC='ifx ${INTEL_FLAGS}' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy
