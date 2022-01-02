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
dd = LB:step:UB;

%Some plots from literature suggest that the peak is more to the left (it may not be a symmetrical Gaussian)
%Normal distribution for the inlet droplet diameter (y axis)
norm = normpdf(dd,meanDiameter,stdDeviation);

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
plot(dd,norm)
title('Droplet size distribution')
xlabel('Droplet diameter (m)')
ylabel('Fraction')
%ylim([0 4e5])
hold on

%Integral in the inlet distribution (must be unity)
fracIN = trapz(dd,norm);

%Using the penetration for each droplet diameter, the distribution is
%updated
ddDistr = norm.*P;
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
title('Pipe output')
xlabel('Droplet diameter (m)')
ylabel('Probability Density')
%ylim([0 4e5])
legend('Inlet','Outlet')
hold off
%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);
