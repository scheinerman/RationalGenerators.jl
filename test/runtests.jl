using Test, RationalGenerators

@testset "Rationals" begin
    a = [t for t in RationalGenerator(5)]
    b = collect(RationalGenerator(5))
    @test a == b

    @test maximum(b) == 4
    @test minimum(b) == 1 // 4

    a = collect(RatGen(10))
    b = 1 .// a
    @test sort(a) == sort(b)

end

@testset "Small Rationals" begin
    a = [t for t in SmallRationalGenerator(10)]
    b = collect(SmallRationalGenerator(10))
    @test a == b

    @test minimum(a) == 1 // 10
    @test maximum(a) == 1

    aa = 1 .// a
    @test all(aa .>= 1)

end
