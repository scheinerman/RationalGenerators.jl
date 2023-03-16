export SmallRationalGenerator, SmallRatGen


"""
    SmallRationalGenerator()
    SmallRationalGenerator(last_denominator)

Create an iterator that gives rational numbers in the interval `(0,1]` without 
repetition. If `last_denominator` is specified, include all rationals with 
that denominator or smaller.
"""
struct SmallRationalGenerator
    last_den::Int
    function SmallRationalGenerator(last_den::Int = -1)
        new(last_den)
    end
end

SmallRatGen = SmallRationalGenerator

# State description: (a,n) ==> a//n 


function Base.iterate(SRG::SmallRatGen)
    if SRG.last_den == 0
        return nothing
    end
    return 1 // 1, (1, 2)
end

function Base.iterate(SRG::SmallRatGen, state::Tuple{Int,Int})
    a, n = state
    while n ≤ SRG.last_den || SRG.last_den < 0
        while a < n
            if gcd(a, n) == 1
                return a // n, (a + 1, n)
            end
            a += 1
        end
        a = 1
        n += 1
    end
    nothing
end

Base.eltype(::Type{SmallRatGen}) = Rational{Int}


function _size(SRG::SmallRatGen)
    if SRG.last_den == 0
        return 0
    end
    return sum(totient(k) for k = 1:SRG.last_den) 
end


function Base.IteratorSize(SRG::SmallRatGen)
    if SRG.last_den < 0
        return Base.IsInfinite()
    end
    return Base.HasLength()
end

Base.length(SRG::SmallRatGen) = _size(SRG)

