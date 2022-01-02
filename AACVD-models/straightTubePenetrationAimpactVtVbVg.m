%particle penetration through tubing

function [P, Vt_impact_fraction, Vb_impact_fraction, Vg_impact_fraction] = straightTubePenetrationAimpactVtVbVg(x)

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

%This is a flag to test how many boundaries were crossed (if any)
extrapolation = 0;

%% Brownian diffusion velocity (Vb)

%Droplet mass (md) SI units: kg
%Droplet density (ro_d) SI units: kg m-3
%Droplet diameter (dd) SI units: m
md = ro_d*(4/3)*(pi*(dd/2)^3);

%Brownian diffusion velocity (Vb) SI units: m s-1
%Boltzmann constant (k) SI units: m2 kg s-2 K-1
%Carrier fluid temperature (T) SI units: K
%Droplet mass (md) SI units: kg
Vb = sqrt ((k*T)/(2*pi*md));

%Correction suggested by us (according to experimental data from papers described in our report)
%The correction below was commented because it makes more sense to have a factor multiplying Vb in the calculation of Vd (therefore, the correction was moved to the end of the function and it applies to all dd)
%  if (dd < 5e-5)
%      Vb = Vb/5e5;
%  end



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
f = 0.3164/(4*Re^.25);

%Blasius equation is not applicable for the following range of Reynolds
%numbrer:
if (Re < 3000 || Re > 100000)
    extrapolation=extrapolation+1;
end

%Friction velocity (Vf) SI units: m s-1
%Fluid flow mean velocity (U) SI units: m s-1
%Fanning friction factor (f) dimensionless
Vf = U*sqrt(f/2);

%Cunningham slip correction (C)
%Mean free path of the carrier fluid (lambda)
%For air at std T and P: lambda = .067e-6;
p=101325; %air at atmospheric pressure
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

%Dimensionless depositional velocity (Vs)
if (ParamSplus >= 0 && ParamSplus <= 10)
    Vs = 0.05*ParamSplus;
%elseif (ParamSplus > 10 && ParamSplus <= 30)
else %This will extrapolate the model for ParamSplus>30
    Vs = 0.5 + 0.0125*(ParamSplus - 10);
    extrapolation=extrapolation+1;
end

%Dimensionless depositional velocity (Vr)
if (ParamRplus >= 0 && ParamRplus <= 10)
    Vr = 0.05*ParamRplus;
%elseif (ParamRplus > 10 && ParamRplus <= 30) %strictly greater than? It does not matter, since the function is continuous
else %This will extrapolate the model for ParamRplus>30
    Vr = 0.5 + 0.0125*(ParamSplus - 10);
    extrapolation=extrapolation+1;
end

%Turbulent diffusional velocity (Vt)
%Friction velocity (Vf)
%Dimensionless depositional velocity (Vs)
%Dimensionless depositional velocity (Vr)
Vt = (Vf*(Vs+Vr))/(4);


%% Gravitational settling velocity (Vg)

%Component of the gravitational settling velocity in the direction of Vd (Vg)
%Module of the gravitational settling velocity vector (modVg)
%Inclination angle in radians (phi) SI units: rad
%Vg = modVg*sin(phi);

Vg = tau*g*cos(phi);

%% Penetration

    function P = PofVtVbVg(Velocities)

    Vt = Velocities(1);
    Vb = Velocities(2);
    Vg = Velocities(3);

    %The factor 5e-5 is a correction suggested by us (according to experimental data from papers described in our report)
    %Sum of Vt and Vb is defined as Vd (Vd)
    %Turbulent diffusion velocity (Vt)
    %Brownian diffusion velocity (Vb)
    Vd = Vt + 5e-5*Vb;

    %Critical angle (TETAc)
    %Sum of Vt and Vb is defined as Vd (Vd)
    %Component of the gravitational settling velocity in the direction of Vd (Vg)
    TETAc = asin(Vd/Vg);


    %Ve is the effective depositional velocity, given by the vector sum of velocities due to turbulent diffusion (Vt),
    %Brownian diffusion (Vb), and gravitational settling (Vg). The magnitude of the vector in the direction of the pipe wall is given by:
    Ve=Vd*TETAc/pi + Vd/2 + Vg*cos(TETAc)/pi;

    %If Vd>Vg, there is no need to use TETAc, since the integral that originated the Ve equation can be evaluated from 0 to 2pi. Also, arcsine(x) for x>1 is not defined in the real domain, therefore, TETAc would be imaginary.
    if (Vd>Vg)
        Ve=Vd;
    end

    %P = penetration = C/C0 = ratio between concentration at distance x and initial concentration
    %Distance from the tube inlet (X) SI units: m
    %Tube inner diameter (d) SI units: m
    %Effective depositional velocity (Ve) SI units: m s-1
    %Distance from the tube inlet (L) SI units: m
    %Carrier fluid flow rate (Q) SI units: m3 s-1
    P = exp(-(pi*d*Ve*L)/(Q));

    end

x=[Vt, Vb, Vg];
fraction = 1e-5;
xLB = x - fraction*x;
xUB = x + fraction*x;


options = optimoptions('fmincon','Algorithm','sqp');
[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@PofVtVbVg,x,[],[],[],[],xLB,xUB,[],options);

GRAD = abs(GRAD);

Vt_impact = GRAD(1)*Vt;
Vb_impact = GRAD(2)*Vb;
Vg_impact = GRAD(3)*Vg;

total = Vt_impact + Vb_impact + Vg_impact;

Vt_impact_fraction = Vt_impact/total;
Vb_impact_fraction = Vb_impact/total;
Vg_impact_fraction = Vg_impact/total;
P = FVAL;


end
