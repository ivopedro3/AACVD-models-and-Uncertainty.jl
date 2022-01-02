clc
clear

%% Parameters

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

%Lower bound, step size and upper bound for plotting (x axi s)
LB = .01e-6;
step = LB;
UB = 80e-6;
dd = LB:step:UB;

figure


%% Nominal values input (experimental data)

%Median droplet diameter
%LB_inlet_medianDiameter = 5.58e-6;
%LB_inlet_medianDiameter = 7.97e-6;
LB_inlet_medianDiameter = 5.16e-6;

%Log-normal distribution for the inlet droplet diameter (y axis)
%std dev
%LB_inlet_sigma = .59;
%LB_inlet_sigma = .82;
LB_inlet_sigma = .48;

%The median of the log-normal distribution is given by:
LB_inlet_meadian=log(LB_inlet_medianDiameter);

%Log-normal distribution
LB_inlet_logNorm = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);

%Convert meters to micrometers
dd_um = dd*1e6;
%Keeping coherence (area below curve must be unity)
LB_inlet_logNorm_um = LB_inlet_logNorm*1e-6;

%Plotting the inlet distribution
plot(dd_um,LB_inlet_logNorm_um)
title('Droplet size distribution')
ax = gca;
ax.FontSize = 16;
set(gcf,'color','w');
%set(gca,'XScale','log');
hold on
xlim([0 30])

%Integral in the inlet distribution (must be unity)
LB_inlet_fracIN = trapz(dd,LB_inlet_logNorm);

% LB_inlet_INquartile10 = trapz(dd(1:264),LB_inlet_logNorm(1:264));
% LB_inlet_INquartile50 = trapz(dd(1:558),LB_inlet_logNorm(1:558));
% LB_inlet_INquartile90 = trapz(dd(1:1203),LB_inlet_logNorm(1:1203));

% LB_inlet_INquartile10 = trapz(dd(1:277),LB_inlet_logNorm(1:277));
% LB_inlet_INquartile50 = trapz(dd(1:797),LB_inlet_logNorm(1:797));
% LB_inlet_INquartile90 = trapz(dd(1:1777),LB_inlet_logNorm(1:1777));

LB_inlet_INquartile10 = trapz(dd(1:285),LB_inlet_logNorm(1:285));
LB_inlet_INquartile50 = trapz(dd(1:516),LB_inlet_logNorm(1:516));
LB_inlet_INquartile90 = trapz(dd(1:913),LB_inlet_logNorm(1:913));

%Error bars for the three experimental quartiles (.1, .5 and .9)
% x = [2.64 5.58 12.03];
% y = [.1146 .1212 .0241];
% err = [.09 .34 1.78];

% x = [2.77 7.97 17.77];
% y = [.1146 .1212 .0241];
% err = [.7 1.08 2.35];

x = [2.85 5.16 9.13];
y = [.1357 .1611 .0449];
err = [.06 .14 .41];
errorbar(x,y,err, 'horizontal', '.')



% %% Upper bound input (experimental data)
%
% %Median droplet diameter
% UB_inlet_medianDiameter = 5.92e-6;
%
% %Log-normal distribution for the inlet droplet diameter (y axis)
% %std dev
% UB_inlet_sigma = .62;
%
% %The median of the log-normal distribution is given by:
% UB_inlet_meadian=log(UB_inlet_medianDiameter);
%
% %Log-normal distribution
% UB_inlet_logNorm = lognpdf(dd,UB_inlet_meadian,UB_inlet_sigma);
%
% %Convert meters to micrometers
% dd_um = dd*1e6;
% %Keeping coherence (area below curve must be unity)
% UB_inlet_logNorm_um = UB_inlet_logNorm*1e-6;
%
% %Plotting the inlet distribution
% plot(dd_um,UB_inlet_logNorm_um)
% title('Droplet size distribution')
% ax = gca;
% ax.FontSize = 16;
% set(gcf,'color','w');
% hold on
%
% %Integral in the inlet distribution (must be unity)
% UB_inlet_fracIN = trapz(dd,UB_inlet_logNorm);
%
% UB_inlet_INquartile10 = trapz(dd(1:274),UB_inlet_logNorm(1:274));
% UB_inlet_INquartile50 = trapz(dd(1:592),UB_inlet_logNorm(1:592));
% UB_inlet_INquartile90 = trapz(dd(1:1381),UB_inlet_logNorm(1:1381));
%
%
%

%% Nominal values output (experimental data)

%Log-normal distribution for the inlet droplet diameter (y axis)
%std dev
medianDiameter = 5.09e-6;
ExperimentFracOut=.34;
sigma = .37;
%The median of the log-normal distribution is given by:
meadian=log(medianDiameter);
logNormExperimentOutput = ExperimentFracOut*lognpdf(dd,meadian,sigma);
logNormExperimentOutput_um = 1e-6*logNormExperimentOutput;

plot(dd_um,logNormExperimentOutput_um)
%legend('Pipe inlet Exp','Pipe outlet Mod', 'Pipe outlet Exp')
%hold off

x = [3.16 5.09 7.98];
y = [.061 .0869 .0265];
err = [.06 .09 .18];
errorbar(x,y,err, 'horizontal', '.')


% expOUTquartile10 = trapz(dd(1:265),logNormExperimentOutput(1:265))/ExperimentFracOut;
% expOUTquartile50 = trapz(dd(1:489),logNormExperimentOutput(1:489))/ExperimentFracOut;
% expOUTquartile90 = trapz(dd(1:876),logNormExperimentOutput(1:876))/ExperimentFracOut;

expOUTquartile10 = trapz(dd(1:316),logNormExperimentOutput(1:316))/ExperimentFracOut;
expOUTquartile50 = trapz(dd(1:509),logNormExperimentOutput(1:509))/ExperimentFracOut;
expOUTquartile90 = trapz(dd(1:798),logNormExperimentOutput(1:798))/ExperimentFracOut;



%% Model output

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

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = LB_inlet_logNorm.*P;
ddDistr_um = ddDistr*1e-6;


%Plotting the outlet distribution
plot(dd_um,ddDistr_um)
title('Droplet distribution before and after 2 m coil piping system')
xlabel('Droplet diameter ({\mu}m)')
ylabel('Probability density')
xlim([0 30])


%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd,ddDistr);


%OUTquartile10 = trapz(dd(1:51),ddDistr(1:51))/fracOUT;
OUTquartile50 = trapz(dd(1:450),ddDistr(1:450))/fracOUT;
%OUTquartile90 = trapz(dd(1:163),ddDistr(1:163))/fracOUT;

x = 4.50;
y = .0719;
err = .0;
errorbar(x,y,err, 'horizontal', '.')


xx = [1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
yy = [0.00118501	0.00633839	0.016766	0.0329483	0.0540143	0.0779664	0.101528	0.120074	0.129435	0.127099	0.113193	0.0904932	0.0639763	0.0387762	0.018999	0.00647729	0.000730408];
plot(xx,yy)
fracOUT2 = trapz(xx,yy);

xxx=[1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416	54.1171	63.0959];
yyy=[0.00162465	0.00630999	0.0139505	0.0246324	0.0378605	0.05268	0.0679156	0.0820712	0.093267	0.0998946	0.10089	0.0960041	0.0858303	0.0718629	0.0559761	0.0402178	0.0263162	0.0153551	0.00769492	0.00306199	0.000767871	0	0	0	0.015816	8.65E-17];
plot(xxx,yyy)
fracOUT3 = trapz(xxx,yyy);
