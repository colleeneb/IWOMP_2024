#!/bin/bash

rm -rf OvO
git clone https://github.com/TApplencourt/OvO.git
cd OvO

export OVO_TIMEOUT=600s

CXX='icpx' CXXFLAGS="-std=c++17 -fiopenmp -fopenmp-targets=spir64" FC="ifx" FFLAGS="-fiopenmp -fopenmp-targets=spir64" ./ovo.sh run test_src

./ovo.sh report --summary test_result
 

rm -rf OpenMP_VV

git clone git@github.com:OpenMP-Validation-and-Verification/OpenMP_VV.git

cd OpenMP_VV

make OMP_VERSION=4.5 CC='icx -std=c99 -fiopenmp -fopenmp-targets=spir64' CXX='icpx -std=c++11 -fiopenmp -fopenmp-targets=spir64'  FC='ifx -fiopenmp -fopenmp-targets=spir64' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.0 CC='icx -std=c99 -fiopenmp -fopenmp-targets=spir64' CXX='icpx -std=c++11 -fiopenmp -fopenmp-targets=spir64'  FC='ifx -fiopenmp -fopenmp-targets=spir64' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy

make OMP_VERSION=5.1 CC='icx -std=c99 -fiopenmp -fopenmp-targets=spir64' CXX='icpx -std=c++11 -fiopenmp -fopenmp-targets=spir64'  FC='ifx -fiopenmp -fopenmp-targets=spir64' VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all
make report_summary

make tidy
