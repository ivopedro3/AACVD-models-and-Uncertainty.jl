#############################
statsC_A = quantiles(concA)
PC_A = fill(1/(statsC_A[6]-statsC_A[2]), numberOfSamples)
C_A = ProbabilityDistribution(concA, PC_A, statsC_A[1], statsC_A[2], statsC_A[3], statsC_A[4], statsC_A[5], statsC_A[6])

statsC_D = quantiles(concD)
PC_D = fill(1/(statsC_D[6]-statsC_D[2]), numberOfSamples)
C_D = ProbabilityDistribution(concD, PC_D, statsC_D[1], statsC_D[2], statsC_D[3], statsC_D[4], statsC_D[5], statsC_D[6])

#############################
    k₁ = k[1].range
    k₂ = k[2].range
    k₃ = k[3].range

    h₁ = h[1].range
    h₂ = h[2].range
    h₃ = h[3].range

#############################


#############################
Uncertain constants
k₁ = [20, 30] to k₁ = Interval(20, 30)


#############################
function 𝓝(μ, σ²)

    return Normal(μ, σ², "Normal")

end


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

#############################
a = typeof(LHS)
b = typeof(RHS)
println("Value of X: $LHS and $RHS")
println("Value of X: $a and $b")


############# X array
function ~(LHS::Array{Float64,1}, RHS)

    P = LHS

    numberOfPoints = length(P)
    μ = RHS[1]
    σ² = RHS[2]
    σ = sqrt(σ²)

    min = μ - 5*σ
    max = μ + 5*σ
    step = (max-min) / (numberOfPoints-1)

    x = collect(min:step:max)

    #Following line(Dot Syntax for Vectorizing Functions) is the same as the commented for below
    P = 𝓝.(x, μ, σ²)
    #=
    for i=1:numberOfPoints
        P[i] = 𝓝(x[i], μ, σ²)
    end
    =#

    scat = scatterplot(x, P, title = "PDF")

    return x,P,scat

end

# X array
X = zeros(1000)
X ~ 𝓝(μ,σ²)
Out = X ~ 𝓝(μ,σ²)
X,P,scat = X ~ 𝓝(μ,σ²)


############# X integer
function ~(LHS, RHS)

    numberOfPoints = 5000
    μ = RHS[1]
    σ² = RHS[2]
    σ = sqrt(σ²)

    min = μ - 5*σ
    max = μ + 5*σ
    step = (max-min) / numberOfPoints

    x = collect(min:step:max)

    P = zeros(numberOfPoints+1)

    #Following line (Dot Syntax for Vectorizing Functions) is the same as the commented "for" below
    P = 𝓝.(x, μ, σ²)
    #=
    for i=1:numberOfPoints+1
        P[i] = 𝓝(x[i], μ, σ²)
    end
    =#

    scat = scatterplot(x, P, title = "PDF")

    #sleep(5)

    #println("Size of x: $(size(x))")
    #println("X: $x and P $P")

    return x,P,scat

end

# X integer
X2 = 0
X2 ~ 𝓝(μ,σ²)
X2, P2, scat2 = X2 ~ 𝓝(μ,σ²)



#= #TESTS
xxx = ProbabilityDistribution(20)
xxx.mean
a=@distributions(xxx, X ~ 𝓝(μ,σ²), Y ~ 𝓤(a,b) )
@distributions 2.7+7.45+8.4+7.7
@distributions a v x
@distributions(m, x >= lb)

xx = ProbabilityDistribution(20)
a=@distributions xx
aa=@distributions(xx, yy)

g(;a) = 2+a
=#


#=

import Base: ~
include("overloadTilde.jl")
include("probability-distributions.jl")

struct ProbabilityDistribution
    x::Float64
    y::Float64
end

X = ProbabilityDistribution(0,0)

μ=5
σ²=10

aaa=typeof(X)

X ~ 𝓝(μ,σ²)

=#


#=
a=50
b=70
c=:($a = $b)
c

iid(n) = dist -> iid(n,dist)

iid(a,b) = a + b


a = dist -> iid(n,dist)

n=5
a(3)
a=iid(3)
b= iid(4)

a(3)
=#



#############################

function uncertaintyFilmFormation(uncertainParameters, N)


    k₁ = uncertainParameters[1]
    k₂ = uncertainParameters[2]
    k₃ = uncertainParameters[3]

    h₁ = uncertainParameters[4]
    h₂ = uncertainParameters[5]
    h₃ = uncertainParameters[6]

    samples = latinHypercubeSampling([k₁[1]; k₂[1]; k₃[1]; h₁[1]; h₂[1]; h₃[1]], [k₁[2]; k₂[2]; k₃[2]; h₁[2]; h₂[2]; h₃[2]], N);
    parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0]
    y0 = [1e3; 0; 0;  0; 0;  0; 0]
    tspan = (0.000, 0.001)

    conc = zeros(N);

    for i=1:N
        parameters = [parameters; samples[i,:]]
        prob = ODEProblem(filmFormation,y0,tspan, parameters)
        sol = solve(prob)
        conc[i] = sol.u[end][1]
        parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0]
    end

    #=
    min = minimum(conc)
    max = maximum(conc)
    mean = mean(conc)
    P = fill(1/(max-min), N)
    stats = quantiles(conc, P)
    =#

    stats = quantiles(conc)
    P = fill(1/(stats[6]-stats[2]), N)
    output = ProbabilityDistribution(conc, P, stats[1], stats[2], stats[3], stats[4], stats[5], stats[6])

return output

end

#############################

function uncertaintyFilmFormation(k₁, k₂, k₃, h₁, h₂, h₃, N)

    samples = latinHypercubeSampling([k₁[1]; k₂[1]; k₃[1]; h₁[1]; h₂[1]; h₃[1]], [k₁[2]; k₂[2]; k₃[2]; h₁[2]; h₂[2]; h₃[2]], N);
    parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0]
    y0 = [1e3; 0; 0;  0; 0;  0; 0]
    tspan = (0.000, 0.001)

    conc = zeros(N);

    for i=1:N
        parameters = [parameters; samples[i,:]]
        prob = ODEProblem(filmFormation,y0,tspan, parameters)
        sol = solve(prob)
        conc[i] = sol.u[end][1]
        parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0]
    end

return conc

end

#############################

    min = minimum(conc)
    max = maximum(conc)
    mean = mean(conc)
    P = fill(1/(max-min), numberOfSamples)
    stats = quantiles(conc, P)


#############################

function Log𝓝(x, μ, σ²)

    σ = sqrt(σ²)
    P = 1 / (σ*sqrt(2*π)*x) * exp(-(log(x) - μ)^2 / (2 * σ²))
    return P

end

function Log𝓝(μ, σ²)

    return μ, σ², "LogNormal"

end

function 𝓝(x, μ, σ²)

    σ = sqrt(σ²)
    P = 1 / (σ*sqrt(2*π)) * exp(-(x - μ)^2 / (2 * σ²))
    return P

end

function 𝓝(μ, σ²)

    return μ, σ², "Normal"

end


function 𝓤(min, max, n)

    interval = (max - min) / n
    x = zeros(n+1)
    x[1] = min

    for i = 2:n+1
        x[i] = x[i-1] + interval
    end

    return x

end

function 𝓤(min, max)

    return min, max, "Uniform"

end

#############################
