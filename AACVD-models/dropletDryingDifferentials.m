function differentials = dropletDryingDifferentials(I, D)


R_d = D(1);
T_gas = D(2);


if R_d < 0
    R_d  = 0;
end

%% Parameters

L1 = 3.2;
L2 = 0.03;
Ac = L1*L2;
P = 2*L1;
Q = 0.03;
ro = 1.17;
mdot_gas = Q * ro;
c_pgas = 1008;
%Velocity carrier gas (v_gas) SI units: m s-1
v_gas =Q/(L1*L2);

%Specific heat vapour (c_pv) SI units: J kg-1 K-1 METHANOL
c_pv = 55/.032; %55 J/(mol K)

%Temperature of delivery site wall (T_w) SI units: K
T_w = 750;

%Specific heat of evaporation (h_fg)SI units: J kg-1 METHANOL
h_fg = 38.278*1000/.032; %38.278 kJ/mol

%Dynamic viscosity drying agent (mu_g) SI units: kg m-1 s-1 AIR
mu_g = 2.9475e-5; %at 300 �C

%Thermal conductivity drying agent ?? (k_g) SI units: W m-1 K-1 AIR
k_g = 0.0454; %at 300 �C

%Velocity drying agent (u_g) SI units: m s-1
% u_g = 0.21;

%Density drying agent (ro_g) SI units: kg m-3 AIR
ro_g = 0.616; %at 300 �C

%Density droplet (ro_dw) SI units: kg m-3 METHANOL
ro_dw = 792; %at 25 �C

%Initial radius of the droplet (R_d0) SI units: m
%R_d0 = 2.5e-6;
% R_d0 = evalin('base', 'R_d0');

%Initial mass of the droplet (m_d0) SI units: kg METHANOL
% m_d0 = 4/3*pi*R_d0^3*ro_dw;

%Partial vapour density over the droplet surface (ro_vs) SI units: kg m-3
P_sat_methanol = 10^( 5.20409 - 1581.34 / (T_gas - 33.5) ) * 10^5;
ro_vs = P_sat_methanol * 0.03204 / (8.31446 * T_gas);

%Partial vapour density over the ambient (ro_vinf) SI units: kg m-3
ro_vinf = .0; %20;% .5

%Specific heat droplet (c_pd) SI units: J kg-1 K-1
% c_pd = 79.5/.032; %79.5 J/(mol K)

B = c_pv * (T_w - T_gas) / h_fg;

%Prandtl number (Pr) SI units: dimensionless
% Pr = c_pv * mu_g / k_g; %???? c_pd vs c_pv??

Re_d = v_gas * (2*R_d) * ro_g / mu_g;

D_h = 4 * Ac / P;
Re_gas = ro_g * v_gas * D_h / mu_g;

% Nu_d = (2 + 0.6 * Re_d^0.5 * Pr^(1/3)) * (1+B)^(-0.7);

D_v = 3.564e-10 * (T_gas + T_w)^1.75;

%Schmidt number (Sc)
Sc = mu_g / (ro_g * D_v); % ???

Sh_d = (2 + 0.6 * Re_d^0.5 * Sc^(1/3)) * (1+B)^(-0.7);


% Mass transfer coefficient hD
h_D = (Sh_d * D_v) / (2*R_d);


%m_d = m_d0 - 8/6 * pi() * ro_dw * (R_d0^3 - R_d^3);
% m_d = 8/6 * pi() * ro_dw * (R_d^3);

% h = Nu_d * k_g / (2 * R_d);

Nu_d = 7.54;
h = Nu_d * k_g / (2 * D_h);
% h = 0.9*15;

mdot_v = h_D * (ro_vs - ro_vinf) * 4 * pi() * R_d^2;

diffR_d = -mdot_v / (ro_dw * 4 * pi() * R_d^2);

% diffT_gas = (h * (T_g - T_d) * 4 * pi() * R_d^2 - h_fg * mdot_v)/(c_pd * m_d);
diffT_gas = v_gas*P*h*(T_w - T_gas)/(c_pgas * mdot_gas);

differentials = [diffR_d; diffT_gas];


end
