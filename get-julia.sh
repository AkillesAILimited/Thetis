#!/bin/bash 

if [ -d julia-1.4.2 ]; then
    echo "julia is apparently there";
else
    wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.2-linux-x86_64.tar.gz
fi
tar zxvf julia-1.4.2-linux-x86_64.tar.gz || exit 1

export PATH=$PWD/julia-1.4.2/bin:$PATH

if [-z $GITPOD_INSTANCE_ID ]; then
    echo "not a gitpod env, ok";
else
    echo "gitpod env. nuking some .so shared libs";
    rm -fv julia-1.4.2/lib/julia/libstdc++* julia-1.4.2/lib/julia/libcurl*;
fi

julia install-juliapkgs.jl

export JULIA_HOME=$PWD/julia-1.4.2
export JULIA_HOME_SHORT=julia-1.4.2

