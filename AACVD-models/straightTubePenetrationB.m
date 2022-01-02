%particle penetration through tubing

function P = straightTubePenetrationB(x)

%Goal: P = penetration = C/C0 = ratio between concentration at distance x and initial concentration
%x = [298, 1.205, .0003333333, 1.82076e-5, 1011.84, 8.68e-4, 1.00692e-5, .0254, 0, 2, 8.88127];


%Constants
%Standard gravity (g) in m/s2
g = 9.80665;

%Boltzmann constant (k) in m2 kg s-2 K-1
k = 1.38064852e-23;

%Parameters
%Carrier fluid
%Carrier fluid temperature (T)
T = x(1);

%Carrier fluid density (ro)
ro = x(2);

%Carrier fluid flow rate (Q)
Q = x(3);

%Carrier fluid dynamic viscosity (mu)
mu = x(4);

%Particles
%Particle density (ro_p)
ro_p = x(5);

%Particle dynamic viscosity (mu_p)
% ??? not used in this model
mu_p = x(6);

%Particle diameter (dp)
dp = x(7);

%Tube
%Tube inner diameter (d)
d = x(8);

%Inclination angle in radians (phi)
phi = x(9);

%Distance from the tube inlet (X)
X = x(10);

%Transport coefficient (K)
K = x(11);

%?????????????
nuplus = .05;


%% Brownian diffusion velocity (Vb)

%Particle mass (mp)
%Particle density (ro_p)
%Particle diameter (dp)
mp = ro_p*(4/3)*(pi*(dp/2)^3);

%Brownian diffusion velocity (Vb)
%Boltzmann constant (k)
%Carrier fluid temperature (T)
%Particle mass (mp)
Vb = sqrt ((k*T)/(2*pi*mp));


%% Turbulent diffusion velocity (Vt)

%Fluid flow mean velocity (U)
%Carrier fluid flow rate (Q)
%Tube inner diameter (d)
U = 4*Q/(pi*d^2);

%Reynolds number (Re)
%Fluid flow mean velocity (U)
%Tube inner diameter (d)
%Carrier fluid density (ro)
%Carrier fluid dynamic viscosity (mu)
Re = (U*d*ro)/(mu);

%Fanning friction factor (f) from Blasius equation ??? check valitity (range of Re)
%Reynolds number (Re)
f = 0.3164/(4*Re^.25);

%Cunningham slip correction (C)
% ??? FIND RIGHT MODEL!
C=.98711;

%Dimensionless diameter (dplus)
dplus = (dp*ro*U*sqrt(f/2))/(mu);

%Dimensionless (Splus)
Splus = ((U*ro*sqrt(f/2))/(mu))*((0.05*U*dp^2*ro_p*sqrt(f/2))/(mu)+dp/2);

% (Vf)
Vf = ((U*sqrt(f/2))/(4))*(nuplus*dplus/2+nuplus*Splus);

nu = Vf+Vb;

Vd = 1/((1/nu)+(1/K));

%Particle relaxation time (tau)
%Cunningham slip correction (C)
%Particle density (ro_p)
%Particle diameter (dp)
%Carrier fluid dynamic viscosity (mu)
tau = (C*ro_p*dp^2)/(18*mu);

%Component of the gravitational settling velocity in the direction of Vd (Vg)
%Module of the gravitational settling velocity vector (modVg)
%Inclination angle in radians (phi)
Vg = tau*g*cos(phi); %??????? sin or cos???

theta = atan((Vd)/(sqrt(abs(Vg^2-Vd^2))));

Ve = (0.5+theta/pi)*Vd + Vg*cos(theta)/pi;

%P = penetration = C/C0 = ratio between concentration at distance x and initial concentration
%Distance from the tube inlet (X)

P = exp(-(pi*d*Ve*X)/(Q));

end
