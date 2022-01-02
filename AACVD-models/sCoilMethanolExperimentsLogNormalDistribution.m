clc
clear

%The pipe diameter is 1 cm diameter of the bulk of the coil is approx. 20 cm
d = 0.01;
coilDiameter = 0.2;
phi = atan(d/coilDiameter);


%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
parametersInclined = [298, 1.15, 1.667e-5, 1.8e-5, 786.6, 5.44e-4, 0, d, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
parametersBend = [298, 1.667e-5, 1.8e-5, 786.6, 0, coilDiameter/2, pi/2, d];

%Experimental lengths were 2, 8 and 50 meters
length = 2;
numberOfTurns = length/(pi*coilDiameter);
parametersInclined(10) = length;


%% Parameters

%The droplet size is controlled by the frequency at which the nozzle vibrates. The higher the frequency, the smaller the median diameter. The atomiser produce droplets with diameters following a log-normal distribution. The median of the distribution can be calculated given the frequency chosen. (median divides the probability in two halves).
%Median droplet diameter
%Test 0.2um, 1um, 10um, 20um
medianDiameter = 6.7e-6;

%Lower bound, step size and upper bound for plotting (x axis)
LB = .01e-6;
step = LB;
UB = 50e-6;
dd = LB:step:UB;

%Log-normal distribution for the inlet droplet diameter (y axis)
%std dev
sigma = .8;

%The median of the log-normal distribution is given by:
meadian=log(medianDiameter);

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
figure
%subplot(2,1,1)
plot(dd_um,logNorm_um)
title('Droplet size distribution')
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);

INquartile10 = trapz(dd(1:244),logNorm(1:244));
INquartile50 = trapz(dd(1:670),logNorm(1:670));
INquartile90 = trapz(dd(1:1620),logNorm(1:1620));

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = logNorm.*P;
ddDistr_um = ddDistr*1e-6;


%Plotting the outlet distribution
plot(dd_um,ddDistr_um)
title('Droplet distribution before and after coil piping system')
xlabel('Droplet diameter ({\mu}m)')
ylabel('Probability density')
xlim([0 30])
%ylim([0 12e-2])
%legend('Pipe inlet','Pipe outlet')

ax = gca;
ax.FontSize = 16;
set(gcf,'color','w');
%hold off

%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);


OUTquartile10 = trapz(dd(1:51),ddDistr(1:51))/fracOUT;
OUTquartile50 = trapz(dd(1:92),ddDistr(1:92))/fracOUT;
OUTquartile90 = trapz(dd(1:163),ddDistr(1:163))/fracOUT;


%% Experimental output

%Log-normal distribution for the inlet droplet diameter (y axis)
%std dev
medianDiameter = 5e-6;
ExperimentFracOut=.4;
sigma = .48;
%The median of the log-normal distribution is given by:
meadian=log(medianDiameter);
logNormExperimentOutput = ExperimentFracOut*lognpdf(dd,meadian,sigma);
logNormExperimentOutput_um = 1e-6*logNormExperimentOutput;

plot(dd_um,logNormExperimentOutput_um)
legend('Pipe inlet Exp','Pipe outlet Mod', 'Pipe outlet Exp')
hold off


expOUTquartile10 = trapz(dd(1:276),logNormExperimentOutput(1:276))/ExperimentFracOut;
expOUTquartile50 = trapz(dd(1:503),logNormExperimentOutput(1:503))/ExperimentFracOut;
expOUTquartile90 = trapz(dd(1:892),logNormExperimentOutput(1:892))/ExperimentFracOut;
