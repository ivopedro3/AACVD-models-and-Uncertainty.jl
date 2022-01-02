(k₁, μ, σ²) = (ProbabilityDistribution(), 25, 4)
(k₂, Range₂) = (ProbabilityDistribution(), [150, 250])
(k₃, Range₃) = (ProbabilityDistribution(), [0.03, 0.05])

k = [k₁ ~ 𝓝(μ,σ²), k₂ ~ 𝓤(Range₂), k₃ ~ 𝓤(Range₃)]
h = [Interval(100, 300), Interval(4, 20), Interval(20, 50)]

numberOfSamples = 1000
outputConcentrations = filmFormation(k, h, numberOfSamples)

likelihood = getDensity(outputConcentrations)


Q = [1 10] * 1e-12    Precursor solution flow rate (m³/s)
ρ = [7 12] * 1e2      Droplet density (kg/m³)
μ = [3 11] * 1e-4     Droplet dynamic viscosity (N·s/m²)
σ = [2  5] * 1e-2     Droplet surface tension (N/m)
I = [1  3] * 1e3      Atomiser power surface intensity (W/m²)
f = [1  3] * 1e6      Atomiser frequency (Hz)

parameters = [Q, ρ, μ, σ, I, f];
samples = generateSamples(parameters);

💧d = simulateAerosol(samples);    Droplet diameter (m)

regTree = fitTree(parameters, 💧d);
sensitivity = rankPredictor(regTree);

δ = 20
x = 700 ± 3δ
y = x + [20, 50]
z = x / y



Size = 500
Range = [0, 20]
X = ProbabilityDistribution(Size, Range)
k = 7
X ~ 𝓧²(k)
X
A = :X

#CORRECT FROM
stats = quantiles(X.x, X.P)
X.percentile25 = stats[1]
X.median = stats[2]
X.percentile75 = stats[3]
#TO
stats = quantile.(Chisq(k), [0.25, 0.50, 0.75])
X.percentile25 = stats[1]
X.median = stats[2]
X.percentile75 = stats[3]



(k₁, μ, σ²) = (ProbabilityDistribution(), 25, 4)
(k₂, Range₂) = (ProbabilityDistribution(), [150, 250])
(k₃, Range₃) = (ProbabilityDistribution(), [0.03, 0.05])

k = [k₁ ~ 𝓝(μ,σ²), k₂ ~ 𝓤(Range₂), k₃ ~ 𝓤(Range₃)]
h = [Interval(100, 300), Interval(4, 20), Interval(20, 50)]


(Size, Range, k) = (500, [0, 20], 7)
X = ProbabilityDistribution(Size, Range)
X ~ 𝓧²(k) #Chi-squared distribution with k degrees of freedom

numberOfSamples = 1000
output = filmFormation(k, h, numberOfSamples)


(Size, Range, μ, σ²) = (500, [0, 100], 50, 16)
X = ProbabilityDistribution(Size, Range)
X ~ 𝓝(μ,σ²)


δ = 20
x = 700 ± 3δ
y = x + [20, 50]
z = x / y


(N, R, k) = (500, [0 30], 7)
W = ProbabilityDistribution(N, R)
W ~ 𝓧²(k)


δ = 20
x = 700 ± 3δ
y = x + [20, 50]



############ EGL-B

Q = [1 10] * 1e-12 #Precursor solution flow rate (m³/s)
ρ = [7 12] * 1e2   #Droplet density (kg/m³)
μ = [3 11] * 1e-4  #Droplet dynamic viscosity (N·s/m²)
σ = [2  5] * 1e-2  #Droplet surface tension (N/m)
I = [1  3] * 1e3   #Atomiser power surface intensity (W/m²)
f = [1  3] * 1e6   #Atomiser frequency (Hz)

parameters = [Q, ρ, μ, σ, I, f];
samples = generateSamples(parameters);

💧d = aerosolGen(samples); #Droplet diameter (m)

regTree = fitTree(parameters, 💧d);
sensitivity = predictorImportance(regTree);



(k₁, μ, σ²) = (ProbabilityDistribution(), 25, 4)
(k₂, Range₂) = (ProbabilityDistribution(), [150, 250])
(k₃, Range₃) = (ProbabilityDistribution(), [0.03, 0.05])

k = [k₁ ~ 𝓝(μ,σ²), k₂ ~ 𝓤(Range₂), k₃ ~ 𝓤(Range₃)]
h = [Interval(100, 300), Interval(4, 20), Interval(20, 50)]

numberOfSamples = 1000
outputConcentrations = filmFormation(k, h, numberOfSamples)

likelihoodConcentrations = densityOfVectors(outputConcentrations)
