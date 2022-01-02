%particle penetration through tubing

function Ve = effectiveDepositionalVelocity(x)

%Goal: P = penetration = C/C0 = ratio between concentration at distance x and initial concentration
%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];

%% Constants
%Standard gravity (g) SI units: m s-2
g = 9.80665;

%Boltzmann constant (k) SI units: m2 kg s-2 K-1
k = 1.38064852e-23;

%% Parameters
%Carrier fluid
%Carrier fluid temperature (T) SI units: K
T = x(1);

%Carrier fluid density (ro) SI units: kg m-3
ro = x(2);

%Carrier fluid flow rate (Q) SI units: m3 s-1
Q = x(3);

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
mu = x(4);

%Droplets
%Droplet density (ro_d) SI units: kg m-3
ro_d = x(5);

%Droplet dynamic viscosity (mu_d) SI units: N s m-2
mu_d = x(6);

%Droplet diameter (dd) SI units: m
dd = x(7);

%Tube
%Tube inner diameter (d) SI units: m
d = x(8);

%Inclination angle in radians (phi) SI units: rad
phi = x(9);

%Distance from the tube inlet (L) SI units: m
L = x(10);

%This is just a flag to test some boundaries. If in the end error is not
%null, there are problems.
error = 0;

%% Brownian diffusion velocity (Vb)

%Droplet mass (mp) SI units: kg
%Droplet density (ro_d) SI units: kg m-3
%Droplet diameter (dd) SI units: m
mp = ro_d*(4/3)*(pi*(dd/2)^3);

%Brownian diffusion velocity (Vb) SI units: m s-1
%Boltzmann constant (k) SI units: m2 kg s-2 K-1
%Carrier fluid temperature (T) SI units: K
%Droplet mass (mp) SI units: kg
Vb = sqrt ((k*T)/(2*pi*mp));


%% Turbulent diffusion velocity (Vt)

%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m
U = 4*Q/(pi*d^2);

%Reynolds number (Re)
%Fluid flow mean velocity (U) SI units: m s-1
%Tube inner diameter (d) SI units: m
%Carrier fluid density (ro) SI units: kg m-3
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
Re = (U*d*ro)/(mu);

%Fanning friction factor, Blasius equation for turbulent pipe flow (f) dimensionless
%Reynolds number (Re) dimensionless
f = 0.3164/(4*Re^.25); %????Divided by 4? Find better correlation?

%Blasius equation is not applicable for the following range of Reynolds
%numbrer:
if (Re < 3000 || Re > 100000)
    error=error+1;
end

%Friction velocity (Vf) SI units: m s-1
%Fluid flow mean velocity (U) SI units: m s-1
%Fanning friction factor (f) dimensionless
Vf = U*sqrt(f/2);

%Cunningham slip correction (C)
%Mean free path of the carrier fluid (lambda)
%For air at std T and P: lambda = .067e-6;
p=101325; % ??? Pressure changes inside pipe... Check this! Parameter?
MM=28.97/(1000*6.02214179e23); %average molar mass air
%Model for the Mean free path of the carrier fluid (lambda)
lambda = (mu/p)*sqrt((pi*k*T)/(2*MM));
%droplet diameter (dd) SI units: m
C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*dd/lambda));

%Droplet relaxation time (tau)
%Cunningham slip correction (C)
%droplet density (ro_d) SI units: kg m-3
%droplet diameter (dd) SI units: m
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
tau = (C*ro_d*dd^2)/(18*mu);
%tau=6.8e-4;

%Parameter Rplus (ParamRplus)
%droplet diameter (dd) SI units: m
%Friction velocity (Vf)
%Carrier fluid density (ro) SI units: kg m-3
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
ParamRplus = (dd*Vf*ro)/(2*mu);

%Parameter S (ParamS)
%Droplet relaxation time (tau)
%Friction velocity (Vf)
%droplet diameter (dd) SI units: m
ParamS = 0.9*tau*Vf + dd/2;

%Parameter Splus (ParamSplus)
%Parameter S (ParamS)
%Friction velocity (Vf)
%Carrier fluid density (ro) SI units: kg m-3
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
ParamSplus = (ParamS*Vf*ro)/(mu);

Vs=0; %debug
%Dimensionless depositional velocity (Vs)
if (ParamSplus >= 0 && ParamSplus <= 10)
    Vs = 0.05*ParamSplus;
elseif (ParamSplus > 10 && ParamSplus <= 3000)
    Vs = 0.5 + 0.0125*(ParamSplus - 10);
end

Vr=0; %debug
%Dimensionless depositional velocity (Vr)
if (ParamRplus >= 0 && ParamRplus <= 10)
    Vr = 0.05*ParamRplus;
elseif (ParamRplus > 10 && ParamRplus <= 30) %??? strictly greater than?
    Vr = 0.5 + 0.0125*(ParamSplus - 10);
end

%Debuging...
if (Vr == 0  || Vs == 0)
    error = error + 1;
end

%Turbulent diffusional velocity (Vt)
%Friction velocity (Vf)
%Dimensionless depositional velocity (Vs)
%Dimensionless depositional velocity (Vr)
Vt = (Vf*(Vs+Vr))/(4);


%% Gravitational settling velocity (Vg)

%gPROMS model used the modVg defined below, but I could not find reference
%for it.
%Module of the gravitational settling velocity vector (modVg)
%droplet diameter (dd) SI units: m
%droplet density (ro_d) SI units: kg m-3
%Carrier fluid density (ro) SI units: kg m-3
%Standard gravity (g)
%Droplet dynamic viscosity (mu_d)
%modVg = (2*(dd/2)^2*(ro_d-ro)*g)/(9*mu_d);

%Component of the gravitational settling velocity in the direction of Vd (Vg)
%Module of the gravitational settling velocity vector (modVg)
%Inclination angle in radians (phi) SI units: rad
%Vg = modVg*sin(phi);

Vg = tau*g*cos(phi);

%% Penetration

%Sum of Vt and Vb is defined as Vd (Vd)
%Turbulent diffusion velocity (Vt)
%Brownian diffusion velocity (Vb)
Vd = Vt + Vb;

%Critical angle (TETAc)
%Sum of Vt and Vb is defined as Vd (Vd)
%Component of the gravitational settling velocity in the direction of Vd (Vg)
TETAc = asin(Vd/Vg);



%Ve is the effective depositional velocity, given by the vector sum of velocities due to turbulent diffusion (Vt),
%Brownian diffusion (Vb), and gravitational settling (Vg). The magnitude of the vector in the direction of the pipe wall is given by:
Ve=Vd*TETAc/pi + Vd/2 + Vg*cos(TETAc)/pi;

if (Vd>Vg)
    Ve=Vd;
end


end
