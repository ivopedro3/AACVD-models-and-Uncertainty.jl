clear
clc


%% Parameters

%pipeLength = 10;
%coilDiameter = .2;
%d = 0.0254;

%numberOfTurns = round(pipeLength/(pi*coilDiameter));
%height = numberOfTurns*coilDiameter;
%Find inclination
%phi = atan(d/coilDiameter);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%parametersInclined = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 10e-6, d, phi, pipeLength];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parametersBend = [298, 3e-4, 1.8e-5, 997, 10e-6, 0.1, pi/2, d];

%% Coil penetration as a function of pipe length
coilDiameter = .2;
numberOfTurnsRange = (1:1:10);

d = 0.01;
phi = atan(d/coilDiameter);
DomainSizeX = size(numberOfTurnsRange);

final_i=DomainSizeX(2);
P = zeros(1,final_i);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%parametersInclined = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 10e-6, 0.0254, phi, 0];
%Methanol at 25�C
parametersInclined = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parametersBend = [298, 3e-4, 1.8e-5, 997, 10e-6, 0.1, pi/2, 0.0254];
%Methanol at 25�C
parametersBend = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, pi/2, .01];

for i=1:final_i
    pipeLength = numberOfTurnsRange(i)*pi*coilDiameter;
    parametersInclined(10) = pipeLength;
    P(i) = bendTubePenetrationB(parametersBend,1)^(4*numberOfTurnsRange(i))*(-straightTubePenetrationA(parametersInclined));
end



% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
bar(P)
axis([0 11 0 .85])
%title('Aerosol penetration as a function of the number of coil turns')
xlabel('Number of turns in the coil, for fixed coil diameter and variable pipe length')
ylabel('Penetration (fraction)')
set(gca,'FontSize',16,'XGrid','on','YGrid','on')
set(gcf,'color','w');
print('Penetration_vs_CoilTurns_VariablePipeLength','-dpdf','-fillpage')


%% Coil penetration as a function of pipe length

d = 0.01;
pipeLength = 2;
%coilDiameterRange = ((pipeLength/(10*pi)):(pipeLength/(10*pi)):(pipeLength/(pi)));

coilDiameterRange = zeros(1,10);
for i=1:10
    coilDiameterRange(i) = pipeLength/(i*pi);
end

DomainSizeX = size(coilDiameterRange);

final_i=DomainSizeX(2);
P = zeros(1,final_i);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%parametersInclined = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 10e-6, 0.0254, phi, 0];
%Methanol at 25�C
parametersInclined = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parametersBend = [298, 3e-4, 1.8e-5, 997, 10e-6, 0.1, pi/2, 0.0254];
%Methanol at 25�C
parametersBend = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, pi/2, .01];

for i=1:final_i
    phi = atan(d/coilDiameterRange(i));
    numberOfTurns = pipeLength/(pi*coilDiameterRange(i));
    parametersInclined(9) = phi;
    P(i) = bendTubePenetrationB(parametersBend,1)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end


figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
bar(P)
axis([0 11 0.6 1])
%title('Aerosol penetration as a function of the number of coil turns')
xlabel('Number of turns in the coil, for variable coil diameter and fixed pipe length')
ylabel('Penetration (fraction)')
set(gca,'FontSize',16,'XGrid','on','YGrid','on')
set(gcf,'color','w');
print('Penetration_vs_CoilTurns_FixedPipeLength','-dpdf','-fillpage')
