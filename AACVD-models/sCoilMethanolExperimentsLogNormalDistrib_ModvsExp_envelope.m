clf
clc
clear

%% Parameters

%The pipe diameter is 1 cm diameter of the bulk of the coil is approx. 20 cm
d = 0.01;
coilDiameter = 0.2;
phi = atan(d/coilDiameter);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%Methanol at 25�C
parametersInclined = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 0, d, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%Methanol at 25�C
parametersBend = [298.15, 3.3333e-5, 1.85e-5, 786.6, 0, coilDiameter/2, pi/2, d];

%Experimental lengths were 2, 8 and 50 meters
length = 2;
numberOfTurns = length/(pi*coilDiameter);
parametersInclined(10) = length;

%Lower bound, step size and upper bound for plotting (x axis)
LB = .01e-6;
step = LB;
UB = 80e-6;
dd = LB:step:UB;


%% Model output


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


x0m_t1 = [1.16592 1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416	54.1171	63.0959];
y0m_t1 = [0 0.00162465	0.00630999	0.0139505	0.0246324	0.0378605	0.05268	0.0679156	0.0820712	0.093267	0.0998946	0.10089	0.0960041	0.0858303	0.0718629	0.0559761	0.0402178	0.0263162	0.0153551	0.00769492	0.00306199	0.000767871	0	0	0	0.015816	8.65E-17];

dd = x0m_t1*1e-6;
dd_um = dd*1e6;

fracIN = trapz(dd_um,y0m_t1);

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
ddDistr = y0m_t1.*P;
ddDistr_um = ddDistr;

ddDistr_um=ddDistr_um*2;

%Plotting the outlet distribution
plot(dd_um,ddDistr_um)
hold on
plot(dd_um, y0m_t1)
title('Droplet distribution before and after 2 m coil piping system')
xlabel('Droplet diameter ({\mu}m)')
ylabel('Probability density')
xlim([0 30])


%Integral in the outlet distribution (less than one, given the loss)
fracOUT = trapz(dd_um,ddDistr);


x2m_t1 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444];
y2m_t1 = [0	0.00118501	0.00633839	0.016766	0.0329483	0.0540143	0.0779664	0.101528	0.120074	0.129435	0.127099	0.113193	0.0904932	0.0639763	0.0387762	0.018999	0.00647729	0.000730408	0];
plot(x2m_t1, y2m_t1,'*')
%y2m_t1 = y2m_t1*.5;
%plot(x2m_t1, y2m_t1,'.')


%OUTquartile10 = trapz(dd(1:51),ddDistr(1:51))/fracOUT;
%OUTquartile50 = trapz(dd(1:450),ddDistr(1:450))/fracOUT;
%OUTquartile90 = trapz(dd(1:163),ddDistr(1:163))/fracOUT;

% x = 4.50;
% y = .0719;
% err = .0;
% errorbar(x,y,err, 'horizontal', '.')
%
%
% xx = [1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
% yy = [0.00118501	0.00633839	0.016766	0.0329483	0.0540143	0.0779664	0.101528	0.120074	0.129435	0.127099	0.113193	0.0904932	0.0639763	0.0387762	0.018999	0.00647729	0.000730408];
% plot(xx,yy)
% fracOUT2 = trapz(xx,yy);
%
% xxx=[1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416	54.1171	63.0959];
% yyy=[0.00162465	0.00630999	0.0139505	0.0246324	0.0378605	0.05268	0.0679156	0.0820712	0.093267	0.0998946	0.10089	0.0960041	0.0858303	0.0718629	0.0559761	0.0402178	0.0263162	0.0153551	0.00769492	0.00306199	0.000767871	0	0	0	0.015816	8.65E-17];
% plot(xxx,yyy)
% fracOUT3 = trapz(xxx,yyy);
