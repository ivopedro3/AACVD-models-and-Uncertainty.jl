x₁ = Interval(80, 100)
x₂ = Interval(50, 70)
x₃ = Interval(20, 40)
x₄ = Interval(110, 140)
parameters = [x₁, x₂, x₃, x₄]
n = 500 #sample size

data = explore(energyConsumption, parameters, n)
λ = globalSensitivity(energyConsumption, parameters, n)

###


(x₁, μ₁, σ₁²) = (ProbabilityDistribution(), 228.5, 100)
x₁ ~ 𝓝(μ₁,σ₁²)

(x₂, μ₂, σ₂²) = (ProbabilityDistribution(), 533, 900)
x₂ ~ 𝓝(μ₂,σ₂²)

(x₃, range) = (ProbabilityDistribution(), [800, 850])
x₃ ~ 𝓤(range)

(x₄, μ₄, σ₄²) = (ProbabilityDistribution(), 312, 400)
x₄ ~ 𝓝(μ₄,σ₄²)

parameters = [x₁, x₂, x₃, x₄]
n = 500 #sample size
data = explore(energyConsumption, parameters, 500)
λ = globalSensitivity(energyConsumption, parameters, n)


###



(x₁, μ₁, σ₁²) = (ProbabilityDistribution(), 228.5, 100)
x₁ ~ 𝓝(μ₁,σ₁²)

(x₂, μ₂, σ₂²) = (ProbabilityDistribution(), 533, 900)
x₂ ~ 𝓝(μ₂,σ₂²)

(x₃, range) = (ProbabilityDistribution(), [800, 850])
x₃ ~ 𝓤(range)

(x₄, μ₄, σ₄²) = (ProbabilityDistribution(), 312, 400)
x₄ ~ 𝓝(μ₄,σ₄²)

parameters = [x₁, x₂, x₃, x₄]
n = 200 #sample size
globalSensitivity(energyConsumption, parameters, 200)
