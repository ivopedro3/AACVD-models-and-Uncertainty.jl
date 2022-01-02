module Uncertainty

#importall Base.Operators

using Distributions
using Gadfly #add Compat add Compose#master add Gadfly#master add Hexagons
using ForwardDiff

#using UnicodePlots
#using Plots

import
    Base: ~, Meta.isexpr
    #Distributions: Distribution , UncertainParameter
export
    𝓝, Log𝓝, latinHypercubeSampling, generateSamples, densityOfVectors,
    #Distribution,
    plot, drawSample,
    ProbabilityDistribution, Interval #constructors for the types

include("probabilityDistributions.jl")
include("latinHypercubeSampling.jl")
include("typeDefinitions.jl")
include("densityOfVectors.jl")
include("generateSamples.jl")
include("overloadTilde.jl")
include("visualisation.jl")
include("statistics.jl")
include("operators.jl")
include("macros.jl")

δ = 20
x = 700 ± 3δ
y = x + [20, 50]

concentration = [conc(x) for x ∈ 300:500]
concentration(T₁, T₂) = [conc(x) for x ∈ T₁:T₂]

y = Interval(660, 810)

W = Interval(50.0, 100.2)
W2 = Interval(55, 70)


###OLD
#=
X = ProbabilityDistribution(500)
(μ, σ²) = (30, 16)
X ~ 𝓝(μ,σ²)
plot(X)
=#

#parameters
(N, R, k) = (500, [0 30], 7)
W = ProbabilityDistribution(N, R)
W ~ 𝓧²(k)
plot(W)

(N, R, μ, σ²) = (500, [-20 40], 10, 16)
X = ProbabilityDistribution(N, R)
X ~ 𝓝(μ,σ²)
plot(X)

(N, R) = (1000, [0 20])
(μ, σ²) = (1, 1)
Y = ProbabilityDistribution(N, R)
Y ~ Log𝓝(μ,σ²)
plot(Y)

(N, R) = (70, [20 80])
Z = ProbabilityDistribution(N, R)
Z ~ 𝓤(R)
plot(Z)


for i ∈ 1:10
    println(Z[i])
end

end # module
