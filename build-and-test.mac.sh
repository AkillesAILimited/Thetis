#!/bin/bash

rm -Rvf build
rm -Rvf build_release
rm -Rvf build_release_julia
mkdir build
mkdir build_release
mkdir build_release_julia

pushd build_release_julia
git clone https://github.com/AkillesAILimited/julia-tree-macos.git
cd julia-tree-macos
./make-tree.sh
mv julia-1.4.2 ../..
cd ..
popd

source ./get-julia-pkgonly.sh
julia gen_ThetisSupport.jl
source ./env-julia.sh
mkdir $JULIA_HOME/org
mv -fv $JULIA_HOME/lib/julia/sys.dylib $JULIA_HOME/org
mv -fv sys.dylib  $JULIA_HOME/lib/julia/

pushd build_release_julia
cmake -DCMAKE_BUILD_TYPE=Release -DUSE_CUDA=OFF -DUSE_JULIA=ON -DUSE_OPENMP=OFF .. || exit 1
make -j6 || exit 1
./TestThetis || exit 1
popd

pushd build_release
cmake -DCMAKE_BUILD_TYPE=Release -DUSE_CUDA=OFF -DUSE_JULIA=OFF -DUSE_OPENMP=OFF .. || exit 1
make -j6 || exit 1
./TestThetis || exit 1
popd

pushd build
cmake -DCMAKE_BUILD_TYPE=Debug -DUSE_CUDA=OFF -DUSE_JULIA=OFF -DUSE_OPENMP=OFF .. || exit 1
make -j6 || exit 1
./TestThetis || exit 1
popd

cp -fv scripts/env-release.sh build_release
cp -fv scripts/env-release-julia.sh build_release_julia
zip -r thetis-mac.zip build_release/libThetis.dylib build_release/*.sh build_release/TestThetis build_release_julia/libThetis.dylib build_release_julia/TestThetis build_release_julia/*.sh testData/* licenses LICENSE $JULIA_HOME_SHORT
echo pwd is $PWD
ls -lh *.zip
#echo ls -lh /home/runner/work/Thetis/Thetis/thetis.zip
#ls -lh /home/runner/work/Thetis/Thetis/thetis.zip
