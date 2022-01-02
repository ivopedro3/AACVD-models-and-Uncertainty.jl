clear
clc

%% Running the optimisation

%Point to find gradient
%Parameters = [sigma, ro, f]
%Methanol at 25�C
x =  [2.2e-2, 786.6, 1.6e6];

fraction = 1e-5;
xLB = x - fraction*x;
xUB = x + fraction*x;


%Choose the algorithm: 1 for active-set, 2 for interior-point, 3 for sqp
algorithm = 3;

if algorithm == 1
    options = optimoptions('fmincon','Algorithm','active-set');
end

if algorithm == 2
    options = optimoptions('fmincon','Algorithm','interior-point');
end

if algorithm == 3
    options = optimoptions('fmincon','Algorithm','sqp');
end

[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@dropletDiameterA,x,[],[],[],[],xLB,xUB,[],options);

%ASSUMING LINEARITY
%Assuming that the initial vector can have its values changed by a fraction of 'frac', the absolute variation in the droplet median diameter is:
frac = .05;
impact = (transpose(frac*x)).*(GRAD);
%The relative impact percentage is:
relativeImpact = impact/FVAL*100;


% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
%Ticks in the x axis
name = {'{\sigma}';'{\rho}'; 'f'};
bar(relativeImpact([1:3],1),'FaceColor','k');
set(gca,'xticklabel',name)
% axis([0 7 -1 1])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the droplet median diameter (%)')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
% print('Atomiser_Sensitivity_Analysis','-dpdf','-fillpage')

%% Sensitivity without assuming linearity (+5% change)
clc
clear

relativeImpact = zeros(1,3);

x =  [2.2e-2, 786.6, 1.6e6];

dropletDiameterA(x);
diameterBefore = dropletDiameterA(x);

for i = 1:3
    temp =  x(i);
    x(i) = x(i)*1.05;
    diameterAfter = dropletDiameterA(x);
    relativeImpact(i) = (diameterAfter - diameterBefore) / diameterBefore*100;
     x(i) = temp;
end

relativeImpact = relativeImpact';

% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
%Ticks in the x axis
name = {'{\sigma_d}';'{\rho_d}'; 'f'};
bar(relativeImpact([1:3],1),'FaceColor','k');
set(gca,'xticklabel',name)
% axis([0 7 -1 1])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the droplet median diameter [%]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
