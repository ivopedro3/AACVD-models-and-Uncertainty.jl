clear
clc

%% Finding the gradient

%Point to find gradient
%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%x = [296, 1.159, 1.9e-2, 1.773e-5, 1000, 8.68e-4, 1e-5, 0.07, .5*pi(), 20.5];
%x = [298, 1.2, 3.3333e-4, 1.821e-5, 1011.9, 8.68e-4, 1e-5, .0254, pi/3, 1];
%x = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0254, pi/2, 1];

%Methanol experiment: tubing lengths were 2 m, 4 m, 8 m, and 0 m (i.e. directly from the bubbler with no tubing). Methanol atomised, carrier gas was air at a flow rate of 2 L min-1
x = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 1/3*pi/2, 2];

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

[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@straightTubePenetrationA,x,[],[],[],[],xLB,xUB,[],options);

%Assuming that the initial vector can have its values changed by a fraction of 'frac', the absolute variation in the penetration P is:
frac = .05;
impact = (transpose(frac*x)).*(GRAD);
%The relative impact % is:
relativeImpact = impact/FVAL*100;


%% Plotting results

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%[T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%name = {'T';'{\rho}';'Q';'{\mu}';'{\rho_d}';'{d_d}';'{d}';'{\phi}';'L'};
%Ticks in the x axis
name = {'{\rho}';'Q';'{\mu}';'{\rho_d}';'{d_d}';'{d}';'{\phi}';'L'};
bar(relativeImpact([2:5,7,8,9,10],1))
set(gca,'xticklabel',name)
axis([0 9 -6.5 3.5])
%titleSize = title('Sensitivity analysis');
%set(titleSize,'FontSize',28)
xlabel('Parameter changed by +5%')
ylabel('Variation in the penetration (%)')
set(gca,'FontSize',16,'XGrid','on','YGrid','on')

% print('Penetration_Sensitivity_Analysis','-dpdf','-fillpage')



%% Sensitivity without assuming linearity (+percent% change)
clc
clear

%percent change
percent = 5;

relativeImpact = zeros(1,10);

%Methanol
x = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 1/3*pi/2, 2];

valueBefore = straightTubePenetrationA(x);

for i = 1:10
    temp =  x(i);
    x(i) = x(i)*(1 + percent/100);
    valueAfter = straightTubePenetrationA(x);
    relativeImpact(i) = (valueAfter - valueBefore) / valueBefore*100;
     x(i) = temp;
end

relativeImpact = relativeImpact';

% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
%Ticks in the x axis
name = {'{\rho}';'Q';'{\mu}';'{\rho_d}';'{d_d}';'{d}';'{\phi}';'L'};
bar(relativeImpact([2:5,7,8,9,10],1),'FaceColor','k')
set(gca,'xticklabel',name)
% axis([0 7 -1 1])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the penetration [%]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
