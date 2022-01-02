using Pkg
Pkg.activate("..")
using Uncertainty
using DifferentialEquations
using Gadfly #add Compat add Compose#master add Gadfly#master add Hexagons

include("arraySolutionsODEs.jl")
include("filmFormation.jl")

########## Exact
#parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC]
parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0; 2.7e1; 1.9e2; 5.4e-2; 1.7e2; 0.9e1; 3.9e1];
y0 = [1e3; 0; 0;  0; 0;  0; 0];

tspan = (0.000, 0.01)
prob = ODEProblem(filmFormation,y0,tspan, parameters)
sol = solve(prob)

out = arraySolutionsODEs(sol)
Cᴬ = layer(x = sol.t, y = out[:,1], Geom.smooth, Theme(default_color="red"))
Cᴮ = layer(x = sol.t, y = out[:,2], Geom.smooth, Theme(default_color="blue"))
Cᴰ = layer(x = sol.t, y = out[:,7], Geom.smooth, Theme(default_color="yellow"))
p = plot(Cᴬ, Cᴮ, Cᴰ, Guide.xlabel("Time (s)"), Guide.ylabel("Concentration (mol/m³)"), Guide.manual_color_key("Legend", ["Cᴬ","Cᴮ", "Cᴰ"], ["red","blue", "yellow"]))
draw(SVG("foo.svg", 6inch, 4inch), p) #NOT WORKING :(

########## Uncertain transfer coefficients
(k₁, μ, σ²) = (ProbabilityDistribution(), 25, 2)
k₁ ~ 𝓝(μ,σ²)
(k₂, μ, σ²) = (ProbabilityDistribution(), 200, 50)
k₂ ~ 𝓝(μ,σ²)
#k₂ = Interval(150, 250)
(k₃, μ, σ²) = (ProbabilityDistribution(), 0.04, 0.000025)
k₃ ~ 𝓝(μ,σ²)
#k₃ = Interval(0.03, 0.05)


k = [k₁, k₂, k₃]

h₁ = Interval(150, 200)
h₂ = Interval(5, 15)
(N, R) = (500, [0 50])
(μ, σ²) = (35, 10)
h₃ = ProbabilityDistribution(N, R)
h₃ ~ 𝓝(μ,σ²)
h = [h₁, h₂, h₃]

#k = [Interval(10, 40), Interval(100, 300), Interval(0.02, 0.06)]
#h = [Interval(100, 300), Interval(4, 20), Interval(20, 50)]

numberOfSamples = 3000

#TODO Generalising: query the size of the vector inputted by the user
output = filmFormation(k, h, numberOfSamples)
#concentration = uncertaintyFilmFormation(k₁, k₂, k₃, h₁, h₂, h₃, 10)
plot(x = output[1].x, Geom.point, Guide.xlabel("[A] for t = 0.1 s (mol/m³)"), Guide.ylabel("Run number"))
plot(x = output[2].x, Geom.point, Guide.xlabel("[D] for t = 0.1 s (mol/m³)"), Guide.ylabel("Run number"))

plot(x = output[1].x, y = x = output[2].x, Geom.point, Guide.xlabel("[A] for t = 0.1 s (mol/m³)"), Guide.ylabel("[D] for t = 0.1 s (mol/m³)"))

A = [output[1].x output[2].x]
result = densityOfVectors(A, 7, 7)

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$result")
end

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$(output[1].x) ___ $(output[2].x)")
end


######### filmFormation2 (version 2) BEGIN #########
########## Uncertain transfer coefficients
(k₁, μ, σ²) = (ProbabilityDistribution(), 0.7695, 0.00004)
k₁ ~ 𝓝(μ,σ²)
(k₂, μ, σ²) = (ProbabilityDistribution(), 0.000426, 0.000000001)
k₂ ~ 𝓝(μ,σ²)
(k₃, μ, σ²) = (ProbabilityDistribution(), 0.000266, 0.000000001)
k₃ ~ 𝓝(μ,σ²)
k = [k₁, k₂, k₃]

h₁ = Interval(0.00065, 0.00067) #0.0007    0.0120    0.0010         0
h₂ = Interval(0.0119, 0.0121)
(N, R) = (500, [0.001 0.02])
(μ, σ²) = (0.001, 0.00000001)
h₃ = ProbabilityDistribution(N, R)
h₃ ~ 𝓝(μ,σ²)
h₄ = Interval(0, 0)
h = [h₁, h₂, h₃, h₄]

include("filmFormation.jl")

numberOfSamples = 3000
include("filmFormation.jl")
output = filmFormation2(k, h, numberOfSamples)

plot(x = output[1].x, Geom.point, Guide.xlabel("[A] for t = 300 s (mol/m³)"), Guide.ylabel("Run number"))
plot(x = output[2].x, Geom.point, Guide.xlabel("[D] for t = 300 s (mol/m³)"), Guide.ylabel("Run number"))

plot(x = output[1].x, y = x = output[2].x, Geom.point, Guide.xlabel("[A] for t = 0.1 s (mol/m³)"), Guide.ylabel("[D] for t = 300 s (mol/m³)"))

A = [output[1].x output[2].x]
result = densityOfVectors(A, 7, 7)

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$result")
end

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$(output[1].x) ___ $(output[2].x)")
end


########## Uncertain transfer coefficients (different values)
(k₁, μ, σ²) = (ProbabilityDistribution(), 1.6201, 0.00004)
k₁ ~ 𝓝(μ,σ²)
(k₂, μ, σ²) = (ProbabilityDistribution(), 0.0008961, 0.000000001)
k₂ ~ 𝓝(μ,σ²)
(k₃, μ, σ²) = (ProbabilityDistribution(), 0.00056, 0.000000001)
k₃ ~ 𝓝(μ,σ²)
k = [k₁, k₂, k₃]

h₁ = Interval(0.00072, 0.00076)
h₂ = Interval(0.0119, 0.0121)
(N, R) = (500, [0.001 0.02])
(μ, σ²) = (0.0014, 0.00000001)
h₃ = ProbabilityDistribution(N, R)
h₃ ~ 𝓝(μ,σ²)
h₄ = Interval(0, 0)
h = [h₁, h₂, h₃, h₄]

include("filmFormation.jl")

numberOfSamples = 3000

output = filmFormation2(k, h, numberOfSamples)

plot(x = output[1].x, Geom.point, Guide.xlabel("[A] for t = 120 s (mol/m³)"), Guide.ylabel("Run number"))
plot(x = output[2].x, Geom.point, Guide.xlabel("[D] for t = 120 s (mol/m³)"), Guide.ylabel("Run number"))

plot(x = output[1].x, y = x = output[2].x, Geom.point, Guide.xlabel("[A] for t = 0.1 s (mol/m³)"), Guide.ylabel("[D] for t = 300 s (mol/m³)"))

A = [output[1].x output[2].x]
result = densityOfVectors(A, 7, 7)

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$result")
end

open("C:/Users/Pedro/Documents/phd_pedro/Coding/CVD/GlobalProcess/data.txt", "w") do f
    write(f, "$(output[1].x) ___ $(output[2].x)")
end


########## Exact
#parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC]

k = [0.405; 0.024; 0.0021]*1e-5
h = [0.0067; 0.12; 0.01; 0]*1e-5

parameters = [0.0768; 0.00384; 3.84; 68796.07; 0.008; 0.008; 1e3; 0; 0; 0; k; h]
y0 = [0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0]

tspan = (0.000, 500)
prob = ODEProblem(filmFormation2, y0, tspan, parameters)
sol = solve(prob)

out = arraySolutionsODEs(sol)
Cᴬ = layer(x = sol.t, y = out[:,1], Geom.smooth, Theme(default_color="red"))
Cᴮ = layer(x = sol.t, y = out[:,2], Geom.smooth, Theme(default_color="blue"))
Cᴰ = layer(x = sol.t, y = out[:,7], Geom.smooth, Theme(default_color="yellow"))
p = plot(nᴬ, nᴮ, nᴰ, Guide.xlabel("Time (s)"), Guide.ylabel("Concentration (mol/m³)"), Guide.manual_color_key("Legend", ["Cᴬ","Cᴮ", "Cᴰ"], ["red","blue", "yellow"]))
draw(SVG("foo.svg", 6inch, 4inch), p) #NOT WORKING :(

######### filmFormation2 (version 2) END #########

########## TESTS

a = Interval(1, 10)
b = Interval(10, 20)
c = Interval(20, 30)

parameters = [a b c]
parameters = [a; b; c]
parameters = [a, b, c]

ns = 200
samples = [drawSample(p) for p in parameters, i in 1:ns]
typeof(samples)

typeof(a)
drawSample(a)
