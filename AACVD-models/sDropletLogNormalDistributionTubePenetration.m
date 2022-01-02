clear
clc

%Parameters
%[T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X]
parameters = [298, 1.2, 3.33e-4, 1.821e-5, 1011.9, 8.68e-4, 1e-5, .0254, 0, 1];

%Mean droplet diameter
meanDiameter = 2e-5;
%Standard deviation
stdDeviation = .5e-5;

%Lower bound, step size and upper bound for plotting (x axis)
LB = meanDiameter/10;
step = meanDiameter/100;
UB = meanDiameter + (meanDiameter - LB);
%dd = LB:step:UB;
dd = LB/100:step/100:UB*2;


%Lognormal distribution for the inlet droplet diameter (y axis)
%Lognormal parameters: mu and sigma
%Distribution mean = exp(mu+(sigma^2)/2)?
%Distribution variance = (exp(2*mu + sigma^2))*(exp(sigma^2)?1)?
sigma = 0.4;
mu = log(meanDiameter)-(sigma^2)/2;
logNorm = lognpdf(dd,mu,sigma);

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

%Plotting the inlet distribution
figure
%subplot(2,1,1)
plot(dd,logNorm)
title('Droplet size distribution')
% xlabel('Droplet diameter (m)')
% ylabel('Fraction')
%ylim([0 4e5])
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,logNorm);

%Using the penetration for each droplet diameter, the distribution is
%updated
ddDistr = logNorm.*P;
% subplot(2,1,2)
% plot(dd,ddDistr)
% %xlim([0 90])
% title('Pipe output')
% xlabel('Droplet diameter (m)')
% ylabel('Fraction')
% ylim([0 4e5])

%Plotting the outlet distribution
%subplot(2,1,1)
plot(dd,ddDistr)
title('Droplet Distribution')
xlabel('Droplet diameter (m)')
ylabel('Probability density')
xlim([0 4e-5])
ylim([0 8e4])
legend('Inlet','Outlet')
hold off
%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);
