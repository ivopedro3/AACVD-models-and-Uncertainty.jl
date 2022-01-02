function ~(LHS::ProbabilityDistribution, RHS::Distribution)

    numberOfPoints = length(LHS.x)
    step = (LHS.maximum - LHS.minimum) / (numberOfPoints-1)
    LHS.category = RHS
    LHS.x = collect(LHS.minimum:step:LHS.maximum)
    LHS.P = zeros(numberOfPoints)
    LHS.P = pdf.(LHS.category,LHS.x)

#=
    if RHS[3] == "Normal"

        μ = RHS[1]
        σ² = RHS[2]
        σ = sqrt(σ²)

        min = μ - 5*σ
        max = μ + 5*σ
        step = (max-min) / (numberOfPoints-1)

        LHS.x = collect(min:step:max)
        LHS.P = zeros(numberOfPoints)

        #Following line(Dot Syntax for Vectorizing Functions) is the same as the commented for below
        LHS.P = 𝓝.(LHS.x, μ, σ²)

    elseif RHS[3] == "LogNormal"

        μ = RHS[1]
        σ² = RHS[2]
        σ = sqrt(σ²)

        min = 1e-5
        max = exp(μ+σ²/2)*10
        step = (max-min) / (numberOfPoints-1)

        LHS.x = collect(min:step:max)
        LHS.P = zeros(numberOfPoints)

        #Following line(Dot Syntax for Vectorizing Functions) is the same as the commented for below
        LHS.P = Log𝓝.(LHS.x, μ, σ²)

    elseif RHS[3] == "Uniform"

        min = RHS[1]
        max = RHS[2]

        μ = (min+max)/2

        LHS.x = 𝓤(min, max, numberOfPoints-1)
        LHS.P = fill(1/(max-min), numberOfPoints)

    end
=#

    #stats = quantiles(LHS.x, LHS.P)

    LHS.mean = mean(LHS.category)
    #LHS.percentile25 = stats[1]
    #LHS.median = stats[2]
    #LHS.percentile75 = stats[3]

    return 0

end
