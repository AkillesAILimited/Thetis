using PackageCompiler
using Libdl
using Pkg
dir = @__DIR__
pwd = @__DIR__

new_project = dir

sysimage_path = joinpath(pwd, "sys." * Libdl.dlext)
script = joinpath(@__DIR__, "gen_ThetisSupport_script.jl")
create_sysimage(:JSON; sysimage_path=sysimage_path,
    project=new_project,
    precompile_execution_file=joinpath(@__DIR__, "gen_ThetisSupport_execution.jl"),
    precompile_statements_file=joinpath(@__DIR__, "gen_ThetisSupport_precompile.jl"),
    script=script)

