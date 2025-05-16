#!/bin/bash

module purge
module load gcc/13.3.1 rocm/6.4.0

export OMPFLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx942"
export OMPVV_NO_COMPILER_CHANGES=1

versions=("4.5" "5.0" "5.1" "5.2" "6.0")

pushd OpenMP_VV

for version in ${versions[@]}; do
	make tidy

	make OMP_VERSION=$version CC="amdclang $OMPFLAGS" CXX="amdclang++ $OMPFLAGS" FC="amdflang $OMPFLAGS" VERBOSE_TESTS=1 VERBOSE=1 LOG=1 LOG_ALL=1 all

	echo "========== Report for OpenMP $version =========="
	make report_summary
done

popd
