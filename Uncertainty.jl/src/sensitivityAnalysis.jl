function localSensitivity(model, x)
    gradient = ForwardDiff.gradient(model, x)
    f₀ = model(x)
    relativeGradient = gradient
    return f₀, gradient
end


function localSensitivity(model, x, percent)
    numberOfParameters = size(x)[1]
    relativeImpact = zeros(numberOfParameters)
    outputBefore = model(x)
    for i = 1:numberOfParameters
        temp = x[i]
        x[i] = x[i]*(1 + percent/100)
        outputAfter = model(x)
        relativeImpact[i] = (outputAfter - outputBefore) / outputBefore*100
        x[i] = temp
    end
    f₀ = outputBefore
    return f₀, relativeImpact
end


function localSensitivity(model, x, percent::Array{Int64,1})
    numberOfParameters = size(x)[1]
    relativeImpact = zeros(numberOfParameters)
    outputBefore = model(x)
    for i = 1:numberOfParameters
        temp = x[i]
        x[i] = x[i]*(1 + percent[i]/100)
        outputAfter = model(x)
        relativeImpact[i] = (outputAfter - outputBefore) / outputBefore*100
        x[i] = temp
    end
    f₀ = outputBefore
    return f₀, relativeImpact
end


function globalSensitivity(model, x::Array{Interval,1}, numberOfSamples)
    numberOfParameters = size(x)[1]
    samples = generateSamples(x, numberOfSamples)
    output = zeros(numberOfSamples)
    for i=1:numberOfSamples
        output[i] = model(samples[i,:])
    end
    interval = (Interval(minimum(output), maximum(output)))
    return interval
    #return Interval, impact
end

function globalSensitivity(model, x::Array{ProbabilityDistribution,1}, numberOfSamples)
    numberOfParameters = size(x)[1]
    samples = generateSamples(x, numberOfSamples)
    output = zeros(numberOfSamples)
    for i=1:numberOfSamples
        output[i] = model(samples[i,:])
    end
    interval = (Interval(minimum(output), maximum(output)))
    #impact = varImportance(samples, output)

    return interval
    #return ProbabilityDistribution, impact

end

function explore(model, x::Array{Interval,1}, numberOfSamples)
    numberOfParameters = size(x)[1]
    samples = generateSamples(x, numberOfSamples)
    output = zeros(numberOfSamples)
    for i=1:numberOfSamples
        output[i] = model(samples[i,:])
    end
    #saving data in file#
    data = [samples output]
    open("C:/Users/Pedro/Documents/phd_pedro/Coding/Uncertainty_and_sensitivity_analysis/inputOutput.txt", "w") do f
        write(f, "$data")
    end
end


function explore(model, x::Array{ProbabilityDistribution,1}, numberOfSamples)
    numberOfParameters = size(x)[1]
    samples = generateSamples(x, numberOfSamples)
    output = zeros(numberOfSamples)
    for i=1:numberOfSamples
        output[i] = model(samples[i,:])
    end




    #saving data in file#
    data = [samples output]
    open("C:/Users/Pedro/Documents/phd_pedro/Coding/Uncertainty_and_sensitivity_analysis/inputOutput.txt", "w") do f
        write(f, "$data")
    end

    A = [samples[:,4] output]
    dataProb = densityOfVectors(A,5,5)
    open("C:/Users/Pedro/Documents/phd_pedro/Coding/Uncertainty_and_sensitivity_analysis/dataProb.txt", "w") do f
        write(f, "$dataProb")
    end

end


explore(energyConsumption, parameters, 500)

###########Thesis##########

function energyConsumption(x)

    x = x/1000
    x₁ = x[1]
    x₂ = x[2]
    x₃ = x[3]
    x₄ = x[4]

    fact1a = (x₁ + x₂ + x₃ + x₄)^2
    fact1b = 19 - 14x₁ + 3x₁^2 - 14x₂ + 6x₁*x₂ + 3x₂^2
    fact1 = 1 + fact1a*fact1b

    fact2a = (2x₁ - 3x₂ - x₃ - 5x₄)^2
    fact2b = 18 - 32x₁ + 12x₁^2 + 48x₂ - 36x₁*x₂ + 27x₂^2
    fact2 = 30 + fact2a*fact2b

    consumption = fact1*fact2/10

end

parameters = [228.5, 533, 827, 312]

(E, ∇model) = localSensitivity(energyConsumption, parameters)
(E, percentageChange₁) = localSensitivity(energyConsumption, parameters, 10)
(E, percentageChange₂) = localSensitivity(energyConsumption, parameters, [5, -10, -8, 4])


#global - intervals
(x₁, x₂, x₃, x₄) = [Interval(80, 100), Interval(50, 70), Interval(20, 40), Interval(110, 140)]

parameters = [x₁, x₂, x₃, x₄]
globalSensitivity(energyConsumption, parameters, 500)
explore(energyConsumption, parameters, 500)



#global - prob distributions
(x₁, μ₁, σ₁²) = (ProbabilityDistribution(), 228.5, 100)
x₁ ~ 𝓝(μ₁,σ₁²)

(x₂, μ₂, σ₂²) = (ProbabilityDistribution(), 533, 900)
x₂ ~ 𝓝(μ₂,σ₂²)

(x₃, range) = (ProbabilityDistribution(), [800, 850])
x₃ ~ 𝓤(range)

(x₄, μ₄, σ₄²) = (ProbabilityDistribution(), 312, 400)
x₄ ~ 𝓝(μ₄,σ₄²)

parameters = [x₁, x₂, x₃, x₄]
globalSensitivity(energyConsumption, parameters, 200)

explore(energyConsumption, parameters, 500)

####TEST SOBOL#####
using GlobalSensitivityAnalysis

model = energyConsumption
x = parameters
numberOfSamples = 200

numberOfParameters = size(x)[1]
samples = generateSamples(x, numberOfSamples)
output = zeros(numberOfSamples)
for i=1:numberOfSamples
    output[i] = model(samples[i,:])
end
interval = (Interval(minimum(output), maximum(output)))

analyze(samples, output)


#########TESTS##############
function dropletDiameterLang1961(x)
    #x =  [2.2e-2; 786.6; 1.6e6]
    σ = x[1]
    ρ = x[2]
    f = x[3]

    💧d = 0.34*((8*π*σ)/(ρ*f^2))^(1/3)
end

x =  [2.2e-2; 786.6; 1.6e6]

globalSensitivity(dropletDiameterLang1961, x, 200)
