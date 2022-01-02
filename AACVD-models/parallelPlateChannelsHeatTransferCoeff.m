function heatTransferCoeff = parallelPlateChannelsHeatTransferCoeff(Re,d_h)

%% Parameters

%Air 350 K:
% nu = 20.92e-6, k= 30e-3

%Reactor inlet pipe/nozzle diameter (d) SI units: m
% d = x(1);

%Carrier fluid flow rate (Q) SI units: m3 s-1
% Q = x(2);

%Carrier fluid density (ro) SI units: kg m-3
%ro = x();

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
%mu = x();

%Carrier fluid kinematic viscosity (nu) SI units: m2 s-1
% nu = x(3);




%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m


%Reynolds number (Re)
%Fluid flow mean velocity (U) SI units: m s-1
%Tube inner diameter (d) SI units: m
%Carrier fluid density (ro) SI units: kg m-3
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
%Re = (U*d*ro)/(mu);

%Air 350 K:
% Pr = 0.7;
% k = .03;


%Air 600 K (approximately (298+908)/2):
Pr = 0.685;
k = .0469;

%Dittus�Boelter equations
Nu_bar = 0.023 * Re^(4/5) * Pr^0.4;


h = Nu_bar * k / d_h;


heatTransferCoeff = h;

end
