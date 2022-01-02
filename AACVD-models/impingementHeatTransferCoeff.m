function heatTransferCoeff = impingementHeatTransferCoeff(x)

%% Parameters

%Air 350 K:
% nu = 20.92e-6, k= 30e-3

%Reactor inlet pipe/nozzle diameter (d) SI units: m
d = x(1);

%Carrier fluid flow rate (Q) SI units: m3 s-1
Q = x(2);

%Carrier fluid density (ro) SI units: kg m-3
%ro = x();

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
%mu = x();

%Carrier fluid kinematic viscosity (nu) SI units: m2 s-1
nu = x(3);

H = x(4);

r = x(5);

k = x(6);



%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m
U = 4*Q/(pi*d^2);

%Reynolds number (Re)
%Fluid flow mean velocity (U) SI units: m s-1
%Tube inner diameter (d) SI units: m
%Carrier fluid density (ro) SI units: kg m-3
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
%Re = (U*d*ro)/(mu);
Re = (U*d)/(nu);


Pr = 0.6833;

Ar = d^2/(4*r^2);
G = 2*Ar^.5*(1-2.2*Ar^.5)/(1+.2*(H/d-6)*Ar^.5);
Nu_bar = Pr^0.42*G*(2*Re^.5*(1+0.005*Re^0.55)^.5);

h = Nu_bar * k / d;


heatTransferCoeff = h;

end
