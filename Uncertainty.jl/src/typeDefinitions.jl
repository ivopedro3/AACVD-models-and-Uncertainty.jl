
### Use something like a switch/case to use other distributions (the code below is just a proof of concept using the Normal distribution)

abstract type UncertainParameter end

mutable struct Exact <: UncertainParameter

    x::Float64

end

mutable struct ProbabilityDistribution <: UncertainParameter

    x::Array{Float64,1}
    minimum::Float64
    maximum::Float64
    P::Array{Float64,1}
    mean::Float64
    percentile25::Float64
    median::Float64
    percentile75::Float64
    category::Distribution

    ProbabilityDistribution() = new([0, 1],0,1)
    ProbabilityDistribution(x) = new(x)
    ProbabilityDistribution(numberOfPoints, range) = new(zeros(numberOfPoints), range[1], range[2])
    #ProbabilityDistribution(x, P, mean, minimum, percentile25, median, percentile75, maximum) = new(x, P, mean, minimum, percentile25, median, percentile75, maximum)

end

mutable struct Interval <: UncertainParameter

    min::Float64
    max::Float64
    nominalValue::Float64
    range::Array{Float64,1}
    plusMinus::Array{Float64,1} #if symmetrical
    percentage::Array{Float64,1} #if symmetrical

    Interval(min, max) = new(min, max, (min+max)/2, [min, max], [], [])

end

mutable struct PrimalDual <: UncertainParameter

    primal::Array{Float64,2}
    dual::Array{Float64,2}

end
