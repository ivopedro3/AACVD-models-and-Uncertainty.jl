function Pdistribution = penetrationMINLPuncertaintyCrossArea(variables)

%variables = [Q_T, N_p, dd, A_T]

%Total flow rate arriving at the deposition site
Q_T = variables(1);
%Number of parallel pipes (of the same length and diameter)
N_p = round(variables(2));
%Median droplet diameter (median divides the PDF in two halves, which have the same area under the curve).
meanDiameter = variables(3);
%Given the total cross-sectional area A_T and the number of parallel pipes N_p, the inner pipe diameter is:
d = sqrt((4*variables(4))/(pi()*N_p));

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
%parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

%Flow rate per pipe
Q_p = Q_T / N_p;

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
parameters = [298.15, 1.17, Q_p, 1.85e-5, 786.6, 5.47e-4, meanDiameter, d, 0*pi/2, 100];


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
    parameters(7) = dd(i);
    P(i) = straightTubePenetrationA(parameters);
end


%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = logNorm.*P;

%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);

Pdistribution = fracOUT;



%% Plots

% %Convert meters to micrometers
% dd_um = dd*1e6;
% %Keeping coherence (area below curve must be unity)
% logNorm_um = logNorm*1e-6;
%
% %Plotting the inlet distribution
% % Create plot figure
% figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% % Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');
% plot(dd_um,logNorm_um,'LineWidth',2)
% hold on
%
%
% %Convert meters to micrometers
% ddDistr_um = -ddDistr*1e-6;
%
% %Plotting the outlet distribution
% % Create plot
% plot(dd_um,ddDistr_um,'LineWidth',2);
% % Create title
% %title('Droplet size distribution: 8 m coiled tubing outlet')
% % Create xlabel
% xlabel('Droplet diameter ({\mu}m)')
% % Create ylabel
% ylabel('Frequency')
% xlim([0 30])
% %ylim([0 12e-2])
% legend('Pipe inlet','Pipe outlet')
% set(gca,'FontSize',16)
% set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
% hold off
% %print('DropletDistribution_2m_Coil','-dpdf','-fillpage')

end
