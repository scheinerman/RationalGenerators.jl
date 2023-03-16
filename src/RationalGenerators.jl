module RationalGenerators

using Primes

export RationalGenerator, RatGen

"""
    RationalGenerator(n)
    RationalGenerator()

Create an iterator that produces positive rational numbers without repetition. 

`RationalGenerator(n)` creates all rational numbers of the form `a//b`
where `gcd(a,b) = 1` and `a+b ≤ n`. 

`RationalGenerator()` creates all rational numbers.

Note: `RatGen` may be used an abbrevation in place of `RationalGenerator`.
"""
struct RationalGenerator
    max_n::Int
    function RationalGenerator(last::Int = -1)
        new(last)
    end
end

RatGen = RationalGenerator


# State description: (a,n) ==> a//(n-a)

function Base.iterate(RG::RationalGenerator)
    if RG.max_n == 0
        return nothing
    end
    return 1 // 1, (1, 3)
end


function Base.iterate(RG::RationalGenerator, state::Tuple{Int,Int})
    a, n = state
    while n ≤ RG.max_n || RG.max_n < 0
        while a < n
            b = n - a
            if gcd(a, b) == 1
                return a // b, (a + 1, n)
            end
            a += 1
        end
        a = 1
        n += 1
    end

    return nothing
end

Base.eltype(::Type{RationalGenerator}) = Rational{Int}

function _size(RG::RationalGenerator)
    if RG.max_n == 0
        return 0
    end

    if RG.max_n == 1
        return 1
    end

    return sum(totient(k) for k = 1:RG.max_n) - 1
end

function Base.IteratorSize(RG::RationalGenerator)
    if RG.max_n < 0
        return Base.IsInfinite()
    end
    return Base.HasLength()
end

Base.length(RG::RationalGenerator) = _size(RG)


include("SmallRatGen.jl")

end # module RationalGenerators
