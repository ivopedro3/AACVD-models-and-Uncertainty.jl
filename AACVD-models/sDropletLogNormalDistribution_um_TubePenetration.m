clear
clc

%Parameters
%[T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X]
%parameters = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0254, 0, 5];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 50];
%Median droplet diameter
%Test 0.2um, 1um, 10um, 20um
meanDiameter = 0.5e-6;
%Standard deviation
sigma = .6;

%Lower bound, step size and upper bound for plotting (x axis)
LB = 0.01e-6;
%LB = meanDiameter/10;
step = .001e-6;
%step = meanDiameter/100;
UB = 70e-6;
%UB = meanDiameter + (meanDiameter - LB);
%UB = 5*meanDiameter + (meanDiameter - LB);
dd = LB:step:UB;
%dd = LB/100:step/100:UB*2;
%dd = LB/100:step:UB*2;

%Lognormal distribution for the inlet droplet diameter (y axis)
%The median of the log-normal distribution is given by:
meadian=log(meanDiameter);
logNorm = lognpdf(dd,meadian,sigma);

%Checking the number of entries in the vector holding droplet diameter
%values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parameters(7) = dd(i);
    P(i) = -straightTubePenetrationA(parameters);
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
% Create plot
plot(dd_um,logNorm_um,'LineWidth',2);
xlim([0 2.5])
%ylim([5 18])
% Create title
%title('Droplet size distribution before and after 5 m horizontal pipe')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);


%If I use dd = LB/100:step/100:UB*2
%Then the meadian will be at dd(9991)
%And I can integrate from 0 to dd(9991) and confirm that the area is 0.5.
%Here is what I need:
%dd2 = dd(1:9991);
%logNorm2 = logNorm(1:9991);
%fracIN2 = trapz(dd2,logNorm2);

%Using the penetration for each droplet diameter, the distribution is
%updated
ddDistr = logNorm.*P;

ddDistr_um = ddDistr*1e-6;
%ddDistr_um=ddDistr_um*11.415;

%Plotting the outlet distribution
plot(dd_um,ddDistr_um,'LineWidth',2)
%xlim([0 70])
%ylim([0 12e-2])
% legend('Pipe inlet','Pipe outlet')
legend('Transport system inlet','Transport system outlet')
%Saving plot as a pdf
print('DropletDistribution_1m_horizontalPipe','-dpdf','-fillpage')
hold off
%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);



%% Thesis format

clear
clc

%Parameters
%[T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X]
%parameters = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0254, 0, 5];
%Methanol at 25�C
%Test pipe lengths of 1 and 5 m
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 5];
%Median droplet diameter
meanDiameter = 7e-6;
%Standard deviation
sigma = .6;

%Lower bound, step size and upper bound for plotting (x axis)
LB = 0.01e-6;
%LB = meanDiameter/10;
step = .001e-6;
%step = meanDiameter/100;
UB = 70e-6;
%UB = meanDiameter + (meanDiameter - LB);
%UB = 5*meanDiameter + (meanDiameter - LB);
dd = LB:step:UB;
%dd = LB/100:step/100:UB*2;
%dd = LB/100:step:UB*2;

%Lognormal distribution for the inlet droplet diameter (y axis)
%The median of the log-normal distribution is given by:
meadian=log(meanDiameter);
logNorm = lognpdf(dd,meadian,sigma);

%Checking the number of entries in the vector holding droplet diameter
%values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parameters(7) = dd(i);
    P(i) = -straightTubePenetrationA(parameters);
end

%Convert meters to micrometers
dd_um = dd*1e6;
%Keeping coherence (area below curve must be unity)
logNorm_um = logNorm*1e-6;

%Plotting the inlet distribution
% Create plot figure
% figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');

% Create plot
plot(dd_um,logNorm_um,'LineWidth',5);
xlim([0 30])
%ylim([5 18])
% Create title
%title('Droplet size distribution before and after 5 m horizontal pipe')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
% set(gca,'FontSize',16)
% set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);


%If I use dd = LB/100:step/100:UB*2
%Then the meadian will be at dd(9991)
%And I can integrate from 0 to dd(9991) and confirm that the area is 0.5.
%Here is what I need:
%dd2 = dd(1:9991);
%logNorm2 = logNorm(1:9991);
%fracIN2 = trapz(dd2,logNorm2);

%Using the penetration for each droplet diameter, the distribution is
%updated
ddDistr = logNorm.*P;

ddDistr_um = ddDistr*1e-6;
%ddDistr_um=ddDistr_um*11.415;

%Plotting the outlet distribution
plot(dd_um,ddDistr_um,'LineWidth',5)
%xlim([0 70])
%ylim([0 12e-2])
% legend('Pipe inlet','Pipe outlet')
legend('Transport system inlet','Transport system outlet')
%Saving plot as a pdf
% print('DropletDistribution_1m_horizontalPipe','-dpdf','-fillpage')
hold off
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);
