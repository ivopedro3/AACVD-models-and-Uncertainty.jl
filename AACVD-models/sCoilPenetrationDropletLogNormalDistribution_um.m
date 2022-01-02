clear
clc


%% Parameters

pipeLength = 2;
coilDiameter = .2;
d = .01;

numberOfTurns = round(pipeLength/(pi*coilDiameter));
height = numberOfTurns*d;
%Find inclination
phi = atan(d/coilDiameter);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%parametersInclined = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 10e-6, d, phi, pipeLength];
%Methanol at 25�C
parametersInclined = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, d, phi, pipeLength];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parametersBend = [298, 3e-4, 1.8e-5, 997, 10e-6, coilDiameter/2, pi/2, d];
%Methanol at 25�C
parametersBend = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, coilDiameter/2, pi/2, d];

%% Parameters

%The droplet size is controlled by the frequency at which the nozzle vibrates. The higher the frequency, the smaller the median diameter. The atomiser produce droplets with diameters following a log-normal distribution. The median of the distribution can be calculated given the frequency chosen. (median divides the probability in two halves).
%Median droplet diameter
%Test 0.2um, 1um, 10um, 20um
meanDiameter = 7e-6;

%Lower bound, step size and upper bound for plotting (x axis)
LB = meanDiameter/10;
step = meanDiameter/100;
UB = 5*meanDiameter + (meanDiameter - LB);
dd = LB/100:step:UB*2;

%Log-normal distribution for the inlet droplet diameter (y axis)
%std dev
sigma = .6;

%The median of the log-normal distribution is given by:
meadian=log(meanDiameter);

logNorm = lognpdf(dd,meadian,sigma);

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Convert meters to micrometers
dd_um = dd*1e6;
%Keeping coherence (area below curve must be unity)
logNorm_um = logNorm*1e-6;

%Plotting the inlet distribution
% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(dd_um,logNorm_um,'LineWidth',2)
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = logNorm.*P;
ddDistr_um = ddDistr*1e-6;

%Plotting the outlet distribution
% Create plot
plot(dd_um,ddDistr_um,'LineWidth',2);
% Create title
%title('Droplet size distribution: 8 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Frequency')
xlim([0 30])
%ylim([0 12e-2])
legend('Pipe inlet','Pipe outlet')
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
hold off
print('DropletDistribution_2m_Coil','-dpdf','-fillpage')

%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);


%% Thesis format


% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create plot
plot(dd_um,logNorm_um,'LineWidth',5)
hold on
plot(dd_um,ddDistr_um,'LineWidth',5);
xlim([0 30])
% ylim([5 18])
% Create title
%title('Droplet median diameter as a function of transducer frequency')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
legend('Pipe inlet','Pipe outlet')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
