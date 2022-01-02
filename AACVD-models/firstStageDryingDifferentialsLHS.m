function differentials = firstStageDryingDifferentialsLHS(I, D)

% IT DOES NOT WORK, SINCE I CAN'T USE EVALIN() IF NOT STRAIGHT FROM A
% SCRIPT...


R_d = D(1);
T_d = D(2);

% %Limiting by boiling point
% if T_d > 64.7 + 273.15 %Methanol boiling point
%     T_d = 64.7 + 273.15;
% end

%% Parameters

%Specific heat vapour (c_pv) SI units: J kg-1 K-1
c_pv = evalin('base', 'c_pv');

%Temperature drying agent (T_g) SI units: K
T_g = evalin('base', 'T_g');

%Specific heat of evaporation (h_fg)SI units: J kg-1
h_fg = evalin('base', 'h_fg');

%Dynamic viscosity drying agent (mu_g) SI units: kg m-1 s-1
mu_g = evalin('base', 'mu_g');

%Thermal conductivity drying agent ?? (k_g) SI units: W m-1 K-1
k_g = evalin('base', 'k_g');

%Velocity drying agent (u_g) SI units: m s-1
u_g = evalin('base', 'u_g');

%Density drying agent (ro_g) SI units: kg m-3
ro_g = evalin('base', 'ro_g');

%Density droplet (ro_dw) SI units: kg m-3
ro_dw = evalin('base', 'ro_dw');

%Initial radius of the droplet (R_d0) SI units: m
R_d0 = evalin('base', 'R_d0');

%Initial mass of the droplet (m_d0) SI units: kg
m_d0 = 4/3*pi*R_d0^3*ro_dw;

%Partial vapour density over the droplet surface (ro_vs) SI units: kg m-3
P_sat_methanol = 10^(5.20409-1581.34/(T_d-33.5))*10^5;
ro_vs = P_sat_methanol*0.03204/(8.31446*T_d);

%Partial vapour density over the ambient (ro_vinf) SI units: kg m-3
ro_vinf = .0;

%Specific heat droplet (c_pd) SI units: J kg-1 K-1
c_pd = evalin('base', 'c_pd');

B = c_pv * (T_g - T_d) / h_fg;

%Prandtl number (Pr) SI units: dimensionless
Pr = c_pv * mu_g / k_g; %???? c_pd vs c_pv??

Re_d = 2 * u_g * R_d * ro_g / mu_g;

Nu_d = (2 + 0.6 * Re_d^0.5 * Pr^(1/3)) * (1+B)^(-0.7);

D_v = 3.564e-10 * (T_d + T_g)^1.75;

%Schmidt number (Sc)
Sc = mu_g / (ro_g * D_v);

Sh_d = (2 + 0.6 * Re_d^0.5 * Sc^(1/3)) * (1+B)^(-0.7);


% Mass transfer coefficient hD
h_D = (Sh_d * D_v) / (2*R_d);




%m_d = m_d0 - 8/6 * pi() * ro_dw * (R_d0^3 - R_d^3);
m_d = 8/6 * pi() * ro_dw * (R_d^3);

h = Nu_d * k_g / (2 * R_d);

mdot_v = h_D * (ro_vs - ro_vinf) * 4 * pi() * R_d^2;

diffR_d = -mdot_v / (ro_dw * 4 * pi() * R_d^2);

diffT_d = (h * (T_g - T_d) * 4 * pi() * R_d^2 - h_fg * mdot_v)/(c_pd * m_d);

differentials = [diffR_d; diffT_d];


end
