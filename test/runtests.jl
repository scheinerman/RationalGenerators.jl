using Test, RationalGenerators

a = [t for t in RationalGenerator(5)]
b = collect(RationalGenerator(5))
@test a==b

@test maximum(b) == 4
@test minimum(b) == 1//4

a = collect(RationalGenerator(10))
b = 1 .// a 
@test sort(a) == sort(b)