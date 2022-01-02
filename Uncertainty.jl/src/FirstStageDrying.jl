workspace()

include("firstStageDryingDifferentials.jl")

using ODE;

# Define time vector and interval grid
const dt = 1e-5
const tf = 2.37e-3
t = 0:5*dt:tf

# Initial position in space
const D0 = [10e-6;298]

(t, D) = ode23(firstStageDryingDifferentials, D0, t)
R_d = map(v -> v[1], D)
T_d = map(v -> v[2], D)

using PyPlot
PyPlot.ticklabel_format(style="sci", axis="both", scilimits=(0,0))
plot(t, R_d);
figure();
PyPlot.ticklabel_format(style="sci", axis="both", scilimits=(0,0))
plot(t, T_d);
