function temperature = fluidFlow(x)

%For turbulent flow, which still occurs if Re_D > 2300, it is reasonable to use the
%correlations of Section 8.5 for Pr > 0.7.

%Use Table 8.1 for laminar.

%% Parameters

%Parameters = [Q, mu, ro, Cp, Pr, k]
% same as: [Q nu*ro ro Cp Pr k]
%Example: [1e-3 2.5e-5 .8 1050 .7 .04]

%Air 350 K:
% nu = 20.92e-6, k= 30e-3
%USING mu NOW!!! Not nu!!

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
%
% H = x(4);
%
% r = x(5);
%
% k = x(6);

Q = x(1);

mu = x(2);
ro = x(3);
Cp = x(4);
Pr = x(5);
k = x(6);

% d = x();
% L1 = x();
% L2 = x();
% L3 = x();
% L4 = x();
% L5 = x();





%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m

% %Air 350 K:
% nu = 20.92e-6;
% ro = 0.995;
% Cp = 1009;
% Pr = 0.7;
% k = .03;

% %Air 600 K (approximately (298+908)/2):
% nu = 52.69e-6;
% ro = 0.5804;
% Cp = 1051;
% Pr = 0.685;
% k = .0469;


% Q = 2.5e-6;
% %Q max
% Q = 2.5e-6/.001869;
% %Q min
% Q = 2.5e-6/.0865;

%Q+
%Q = 2.5e-6/0.01685;

%Q 0.5 v% aerosol
%Q = 2.5e-6/0.005;

% %Q-
% Q = 2.5e-6/0.06125;

% %Q avarege
% Q = 2.5e-6/0.039;

% Design parameters
d = .01;
L1 = 3.2;
L2 = 0.026;
L3 = 0.01;
L4 = 0.2;
L5 = 0.276;

%Ts = 635;
Ts = 350;
% Ts = 475;
T_bar_in = 298;
P = 2*L1;


%Number of reciprocating nozzles
%N = 300;
N = 1;

A1 = (pi * d^2) / 4;
A2 = L1 * L2;
A3 = L1 * L3;

Q_total = Q*N;
m_dot = Q_total * ro;

%A2 = .15*.075;

V1 = Q/A1;
V2 = Q_total/A2;
V3 = Q_total/A3;

Re1 = (ro*V1*d)/(mu);

%Hydraulic diameters flat plate = two times separation between plates
d_h2 = (4*L2*L1)/(2*(L2+L1));
d_h3 = (4*L3*L1)/(2*(L1+L3));

Re2 = (ro*V2*d_h2)/(mu);
Re3 = (ro*V3*d_h3)/(mu);


t2 = L5/V2;
t3 = L4/V3;



%Turbulent flow
%h_bar = parallelPlateChannelsHeatTransferCoeff(Re2,d_h2);

xmax=.3;

%Laminar flow
Nu_bar = 7.5;
h_bar = Nu_bar * k / d_h2;
T_bar_out = Ts - (Ts - T_bar_in)*exp(-(P*L5*h_bar)/(m_dot*Cp));

temperature = T_bar_out;

%% Plots and comparing with lower Nu_bar

% x = linspace(0,xmax,1000);
% y = Ts - (Ts - T_bar_in)*exp(-(x.*(P*h_bar))/(m_dot*Cp));
%
%
%
% % Create plot figure
% figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% % Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');
% % Create plot
% plot(x, y,'LineWidth',2)
% % Create title
% %title('Droplet size distribution: atomiser output')
% % Create xlabel
% xlabel('Distance (m)') %({\mu}m)
% % Create ylabel
% ylabel('Temperature (K)')
% %axis([0 7 -.01 .01])
% set(gca,'FontSize',16)
% set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
% %xlim([0 .7e-3])
%
%
% Nu_bar = 3;
% h_bar = Nu_bar * k / d_h2;
% T_bar_out = Ts - (Ts - T_bar_in)*exp(-(P*L5*h_bar)/(m_dot*Cp));
% x = linspace(0,xmax,1000);
% y = Ts - (Ts - T_bar_in)*exp(-(x.*(P*h_bar))/(m_dot*Cp));
% plot(x, y,'LineWidth',2)



end
