#!/bin/bash -e

module load cmake

## OpenMP Flop/s:
rm -rf abc-pvc-deepdive
echo "OpenMP flop-rate"
git clone https://github.com/UoB-HPC/abc-pvc-deepdive
cd abc-pvc-deepdive/microbenchmark
mpicxx -fiopenmp -fopenmp-targets=spir64 flops.cpp -o flops
ZE_AFFINITY_MASK=0.0 mpirun -n 1  ./flops

## SYCL Flop/s:
echo "SYCL flop-rate"
cd ../../
mpicxx -fsycl -fopenmp flops.sycl.cpp -o flops.sycl
ZE_AFFINITY_MASK=0.0  mpirun -n 1 ./flops.sycl

## OpenMP Stream:
echo "OpenMP flop-rate"
rm -rf BabelStream
git clone https://github.com/UoB-HPC/BabelStream.git
cd BabelStream
mkdir build
cd build
cmake ../  -DMODEL=omp -DOFFLOAD=ON -DCXX_EXTRA_FLAGS="-fiopenmp -fopenmp-targets=spir64"
make
ZE_AFFINITY_MASK=0.0 ./omp-stream -n 300 -s 320000000 --mibibytes

## SYCL Stream:
echo "SYCL flop-rate"
make clean
cmake ../  -DMODEL=sycl -DSYCL_COMPILER=ONEAPI-ICPX -DCXX_EXTRA_FLAGS="-fsycl -fsycl-targets=spir64"
make
ZE_AFFINITY_MASK=0.0 ./sycl-stream -n 300 -s 320000000 --mibibytes
