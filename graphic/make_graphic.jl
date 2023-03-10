using Plots, RationalGenerators

function make_graphic(max_n::Int = 10)
    numbers = collect(RationalGenerator(max_n))
    tops = numerator.(numbers)
    bots = denominator.(numbers)
    plot(bots,tops, marker=5, legend=false, aspect_ratio=1)
    xlabel!("Denominator")
    ylabel!("Numerator")
    xaxis!(collect(1:max_n-1))
    yaxis!(collect(1:max_n))
    title!("Generator Order")
end
