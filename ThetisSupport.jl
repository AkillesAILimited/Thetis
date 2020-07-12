module ThetisSupport

Base.@ccallable function bar(x :: Cint) :: Cint
    println("bar:", x)
    return x+3
end

precompile(bar, (Cint,))

end
