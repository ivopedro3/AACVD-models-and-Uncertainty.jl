%particle penetration through tubing

function P = bendTubePenetrationA(bendAngle, x)

%Goal: P = penetration = C/C0 = ratio between concentration at distance x and initial concentration

%parameters = [T, Q, mu, ro_d, dd, d];

%% Constants
%Standard gravity (g) SI units: m s-2

if (bendAngle == 90)
    K=0.963;
end

if (bendAngle == 45)
    K=0.482;
end

%Boltzmann constant (k) SI units: m2 kg s-2 K-1
k = 1.38064852e-23;

%% Parameters
%Carrier fluid
%Carrier fluid temperature (T) SI units: K
T = x(1);

%Carrier fluid flow rate (Q) SI units: m3 s-1
Q = x(2);

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
mu = x(3);

%Droplets
%Droplet density (ro_d) SI units: kg m-3
ro_d = x(4);

%Droplet diameter (dd) SI units: m
dd = x(5);

%Tube
%Tube inner diameter (d) SI units: m
d = x(6);


%% Turbulent diffusion velocity (Vt)

%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m
U = 4*Q/(pi*d^2);

%Cunningham slip correction (C)
%Mean free path of the carrier fluid (lambda)
%For air at std T and P: lambda = .067e-6;
% ??? Pressure changes inside pipe... Check this!
P=101325;
MM=28.97/(1000*6.02214179e23); %average molar mass air
%Model for the Mean free path of the carrier fluid (lambda)
lambda = (mu/P)*sqrt((pi*k*T)/(2*MM));
%droplet diameter (dd) SI units: m
C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*dd/lambda));

%Droplet relaxation time (tau)
%Cunningham slip correction (C)
%droplet density (ro_d) SI units: kg m-3
%droplet diameter (dd) SI units: m
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
tau = (C*ro_d*dd^2)/(18*mu);

Stk = (2*tau*U)/(d);

%The model was tested for 100<Re<10000 and 0.03<Stk<1.46
P = 10^(-K*Stk);

end
