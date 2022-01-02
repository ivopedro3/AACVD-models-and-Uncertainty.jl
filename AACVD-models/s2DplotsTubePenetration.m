
%% Penetration as a function of droplet diameter

clc
clear

dropletDiameterRange = (0.0001:.0001:100);

DomainSizeX = size(dropletDiameterRange);

final_i=DomainSizeX(2);
P = zeros(1,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

for i=1:final_i
    parameters(7) = dropletDiameterRange(i)*1e-6;
    P(i) = -straightTubePenetrationA(parameters);
end


% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% % Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');
% Create plot
plot(dropletDiameterRange,P,'LineWidth',5,'Color','k');
xlim([0.0007 20])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of droplet size')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Penetration [fraction]')
set(gca,'XScale','log','FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
%Saving plot as a pdf
% print('Penetration_vs_Droplet_Size','-dpdf','-fillpage')


%% Penetration as a function of pipe length

clc
clear

pipeLengthRange = (0:0.1:50);

DomainSizeX = size(pipeLengthRange);

final_i=DomainSizeX(2);
P = zeros(1,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 0];

angles = [0 60 85 90];
for h=1:4
    parameters(9) = (pi/2)/90*angles(h);
    for i=1:final_i
        parameters(10) = pipeLengthRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end


% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
hold('on');
% Create plot
plot(pipeLengthRange,P(1,:),'LineWidth',5);
plot(pipeLengthRange,P(2,:),'LineWidth',5);
plot(pipeLengthRange,P(3,:),'LineWidth',5);
plot(pipeLengthRange,P(4,:),'LineWidth',5);
legend('Horizontal','60� inclination','85� inclination','Vertical');
%xlim([0 90])
%ylim([5 18])
% Create title
% title('Aerosol penetration as a function of pipe length for different pipe inclinations')
% Create xlabel
xlabel('Pipe length [m]')
% Create ylabel
ylabel('Penetration [fraction]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
%drawnow; pause(1);
%set(gcf,'color','w');
%axes1.YAxis.Exponent = 3;
%axes1.XAxis.Color = 'r';
%Saving plot as a pdf
% print('Penetration_vs_Pipe_length_and_inclinations','-dpdf','-fillpage')




%% Penetration as a function of pipe diameter for different temperatures

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

temperatures = [180 230 280 330];
for h=1:4
    parameters(1) = temperatures(1);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Temperature = 180 K','Temperature = 230 K','Temperature = 280 K','Temperature = 330 K');

%xlim([0 90])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_temperature','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different Carrier fluid densities

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

carrierFluidDensities = [1 1.5 2 4];
for h=1:4
    parameters(2) = carrierFluidDensities(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Carrier fluid density = 1.0 kg\cdotm^{-3}','Carrier fluid density = 1.5 kg\cdotm^{-3}','Carrier fluid density = 2.0 kg\cdotm^{-3}','Carrier fluid density = 4.0 kg\cdotm^{-3}');

%xlim([0 90])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_carrier_fluid_density','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different Carrier fluid flow rates

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Carrier_fluid_flow_rates = [2.5 3 3.5 4]*1e-5;
for h=1:4
    parameters(3) = Carrier_fluid_flow_rates(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Carrier fluid flow rate = 2.5{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 3.0{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 3.5{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 4.0{\cdot10^{-5} m^{3}\cdot s^{-1}}');

%xlim([0 90])
%ylim([0 .9])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_carrier_fluid_flow_rate','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different Carrier fluid dynamic viscosities

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Carrier_fluid_dynamic_viscosities = [1.5 1.8 2.1 2.4]*1e-5;
for h=1:4
    parameters(4) = Carrier_fluid_dynamic_viscosities(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Carrier fluid dynamic viscosity = 1.5{\cdot10^{-5} N\cdots\cdotm^{-2}}','Carrier fluid dynamic viscosity = 1.8{\cdot10^{-5} N\cdots\cdotm^{-2}}','Carrier fluid dynamic viscosity = 2.1{\cdot10^{-5} N\cdots\cdotm^{-2}}','Carrier fluid dynamic viscosity = 2.4{\cdot10^{-5} N\cdots\cdotm^{-2}}');

%xlim([0 90])
ylim([0 .8])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_carrier_fluid_dynamic_viscosities','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different droplet densities

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Droplet_densities = [700 850 1000 1150];
for h=1:4
    parameters(5) = Droplet_densities(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Droplet density =   700 {kg\cdotm^{-3}}','Droplet density =   850 {kg\cdotm^{-3}}','Droplet density = 1000 {kg\cdotm^{-3}}','Droplet density = 1050 {kg\cdotm^{-3}}');

%xlim([0 90])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_droplet_density','-dpdf','-fillpage')


%% Penetration as a function of pipe diameter for different droplet diameters

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

droplet_diameters = [1 2 5 10]*1e-6;
for h=1:4
    parameters(7) = droplet_diameters(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Droplet diameter =   1{\cdot10^{-6} m}','Droplet diameter =   2{\cdot10^{-6} m}','Droplet diameter =   5{\cdot10^{-6} m}','Droplet diameter = 10{\cdot10^{-6} m}');

%xlim([0 90])
%ylim([0 1.3])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_droplet_diameter','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different inclination angles

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Inclination_angles = [0 30 45 60]*pi/2/90;
for h=1:4
    parameters(9) = Inclination_angles(h);
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Inclination angle =   0{^{o}}','Inclination angle = 30{^{o}}','Inclination angle = 45{^{o}}','Inclination angle = 60{^{o}}');

%xlim([0 90])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_inclination_angle','-dpdf','-fillpage')

%% Penetration as a function of pipe diameter for different pipe lengths

clear
clc

tubeDiameterRange = (0.001:0.0001:0.020);

DomainSizeX = size(tubeDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Pipe_lengths = [1 3 5 10];
for h=1:4
    parameters(10) = parameters(10)+1;
    for i=1:final_i
        parameters(8) = tubeDiameterRange(i);
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

%converting diameter from m to mm
tubeDiameterRange = tubeDiameterRange*1000;
% Create plot
plot(tubeDiameterRange,P(1,:),'LineWidth',2);
plot(tubeDiameterRange,P(2,:),'LineWidth',2);
plot(tubeDiameterRange,P(3,:),'LineWidth',2);
plot(tubeDiameterRange,P(4,:),'LineWidth',2);
legend('Pipe length =   1 m','Pipe length =   3 m','Pipe length =   5 m','Pipe length = 10 m');

%xlim([0 90])
%ylim([5 18])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of pipe diameter')
% Create xlabel
xlabel('Pipe diameter (mm)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

print('Penetration_vs_Pipe_diameter_and_pipe_length','-dpdf','-fillpage')



%% Penetration as a function of droplet size for different carrier fluid flow rates

clear
clc

dropletDiameterRange = (.01:0.01:10);

DomainSizeX = size(dropletDiameterRange);

final_i=DomainSizeX(2);
P = zeros(4,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

Carrier_fluid_flow_rates = [2.5 3 3.5 4]*1e-5;
for h=1:4
    parameters(3) = Carrier_fluid_flow_rates(h);
    for i=1:final_i
        parameters(7) = dropletDiameterRange(i)*1e-6;
        P(h,i) = -straightTubePenetrationA(parameters);
    end
end

% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create plot
plot(dropletDiameterRange,P(1,:),'LineWidth',2);
plot(dropletDiameterRange,P(2,:),'LineWidth',2);
plot(dropletDiameterRange,P(3,:),'LineWidth',2);
plot(dropletDiameterRange,P(4,:),'LineWidth',2);
legend('Carrier fluid flow rate = 2.5{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 3.0{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 3.5{\cdot10^{-5} m^{3}\cdot s^{-1}}','Carrier fluid flow rate = 4.0{\cdot10^{-5} m^{3}\cdot s^{-1}}');

%xlim([0 90])
%ylim([0 .9])
% Create title
%title('Aerosol penetration as a function of horizontal pipe length')
%title('Aerosol penetration as a function of 45� inclined pipe length')
% title('Aerosol penetration as a function of droplet size')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

%print('Penetration_vs_Pipe_diameter_and_carrier_fluid_flow_rate','-dpdf','-fillpage')


%% Penetration as a function of droplet diameter
%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%parameters = [298, 1.2, 3.3333e-4, 1.821e-5, 1011.9, 8.68e-4, x, .0254, 0, 1];


%parameters = [293, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0127, 0, 2];

%Droplet diameter in micrometers
%dropletDiameterRange = (0.001:.001:20);
dropletDiameterRange = (0.0001:.0001:100);
%dropletDiameterRange = [.0001 .001 .01 .1 1 10];
%dropletDiameterRange = [0.0001 .001 .01 .1 1 10 30 50 100];

DomainSizeX = size(dropletDiameterRange);

final_i=DomainSizeX(2);
P2 = zeros(1,final_i);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%parameters = [298, 1.15, 1e-3, 1.8e-5, 997, 0, 0, .0254, 0*pi/2, 1];
parameters = [298, 1.15, 1e-4, 1.8e-5, 997, 0, 0, .0127, 0*pi/2, 2];

%Lee and Gieseke (1992) PIPE A
%parameters = [298, 1.2, 11.667e-4, 1.8e-5, 789, 0, 0, 0.00767, pi/2, 11.674];

%Lee and Gieseke (1992) PIPE B
%parameters = [298, 1.2, 1.667e-4, 1.8e-5, 789, 0, 0, 0.00622, pi/2, 9.936];

%Brockmann et al. (1981)
%parameters = [298, 1.2, 8.833e-4, 1.8e-5, 1769, 0, 0, 0.0254, pi/2, 31.4];



for i=1:final_i
    parameters(7) = dropletDiameterRange(i)*1e-6; %converting micrometers to m
    P2(i) = -straightTubePenetrationA(parameters);
end


figure
plot(dropletDiameterRange,P2)
%xlim([0 90])
% title('Penetration')
xlabel('Droplet diameter (um)')
ylabel('Penetration (fraction)')

set(gca,'XScale','log')
%set(gcf,'color','w');
