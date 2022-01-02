%% Global variables and boundaries (run first)

clear
clc

global esfdebug
esfdebug = 0;
global strawberry_numberofprocessors
strawberry_numberofprocessors = 1;
global strawberry_randomsolutionfn
strawberry_randomsolutionfn = @SBrandom;
global strawberry_neighbourfn
strawberry_neighbourfn = @SBneighbour;

% xLB = [2e-5; 1;  0.1e-6; 0.01];
% xUB = [5e-3; 10; 0.3e-6; 0.05];

xLB = [2e-5; 1; 4e-6;  0.01];
xUB = [5e-3; 10;10e-6; 0.05];


%% Aerosol generation
%


%% Aerosol transport (mean droplet)


%variables = [Q_T, N_p, dd, d]


a = xLB;
b = xUB;

x0 = (xUB-xLB).*0.5 + xLB;
ngen = 100;
npop = 15;
nrmax = 5;
ns = 50;                       %number of stable generations
population_strategy = 4;
output = 10;
[x, y, nf, ninf, bestgen] = strawberry(x0, a, b, @SBobjectAndConstraints, ngen, npop, nrmax, ns, population_strategy, output);


%% Aerosol transport (droplet distribution)


a = xLB;
b = xUB;

x0 = (xUB-xLB).*0.5 + xLB;

ngen = 200;
npop = 10;
nrmax = 5;
ns = 1000;                       %number of stable generations
population_strategy = 4;
output = 10;
[x, y, nf, ninf, bestgen] = strawberry(x0, a, b, @SBobjectAndConstraintsUncert, ngen, npop, nrmax, ns, population_strategy, output);
