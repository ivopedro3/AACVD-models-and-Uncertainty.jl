clear
clc

%Parameters
%[T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X]
%Methanol at 25�C
Q = 0.006;
d = .0627;

Length = 50;
parameters = [298.15, 1.17, Q, 1.85e-5, 786.6, 5.47e-4, 7e-6, d, 0*pi/2, Length];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%Methanol at 25�C
parametersBend = [298.15, Q, 1.85e-5, 786.6, 0, .1, pi/2, d];
numberOfbends = 5;

meanDiameter = 10e-6;
% meanDiameter = 2e-6;
%Standard deviation
sigma = .6;


%Lower bound, step size and upper bound for plotting (x axis)
LB = 0.01e-6;
step = .001e-6;
UB = 70e-6;
dd = LB:step:UB;

%Lognormal distribution for the inlet droplet diameter (y axis)
%The median of the log-normal distribution is given by:
median=log(meanDiameter);
logNorm = lognpdf(dd,median,sigma);

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation


%For each droplet diameter, the penetration is calculated
% for i=1:final_i
%     parameters(7) = dd(i);
%     P(i) = -straightTubePenetrationA(parameters);
% end

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parameters(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(numberOfbends)*(-straightTubePenetrationA(parameters));
end




%Convert meters to micrometers
dd_um = dd*1e6;
%Keeping coherence (area below curve must be unity)
logNorm_um = logNorm*1e-6;

%Plotting the inlet distribution
% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
%hold(axes,'on');
% Create plot
plot(dd_um,logNorm_um,'LineWidth',5,'Color',[.19 .32 .22]);

% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')

hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);

%Using the penetration for each droplet diameter, the distribution is
%updated
ddDistr = logNorm.*P;

ddDistr_um = ddDistr*1e-6;
%ddDistr_um=ddDistr_um*11.415;

%Plotting the outlet distribution
plot(dd_um,ddDistr_um,'LineWidth',5,'Color','green','LineStyle','--')
xlim([0 40])
ylim([0 0.4])
yticks([0 0.1 0.2 0.3 0.4])
legend('Transport system inlet','Transport system outlet')
% %Saving plot as a pdf
% print('DropletDistribution_1m_horizontalPipe','-dpdf','-fillpage')
hold off
%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);

set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')



%% droplet generation

frequencyRange = (20000:1000:2e6);
DomainSizeX = size(frequencyRange);

final_i=DomainSizeX(2);
dd = zeros(1,final_i);
%Parameters = [sigma, ro, f]
parameters = [2.2e-2, 786.6, 0];

for i=1:final_i
    parameters(3) = frequencyRange(i);
    dd(i) = dropletDiameterA(parameters);
end


%Converting diameter from metre to micrometre
dd = dd*1e6;
%Converting frequecy from Hz to kHz
frequencyRange = frequencyRange*1e-3;

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot
plot(frequencyRange,dd,'LineWidth',4);
%xlim([0 90])
% ylim([5 18])
% Create title
%title('Droplet median diameter as a function of transducer frequency')
% Create xlabel
xlabel('Transducer frequency (kHz)')
% Create ylabel
ylabel('Droplet median diameter ({\mu}m)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',20)
%set(axes1,'FontSize',20,'XGrid','on','XTick',[0 200 400 600 800 1000 1200 1400 1600 1800 2000],'YGrid','on');
%drawnow; pause(1);
