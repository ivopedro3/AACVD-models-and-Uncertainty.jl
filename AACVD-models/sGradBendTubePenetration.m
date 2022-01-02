clear
clc

%% Running the optimisation


%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parametersBend = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.5,pi/2, d];

%Find inclination
%Penetration = bendTubePenetrationB(parametersBend,1)^numberOfTurns*(-straightTubePenetrationA(parametersInclined));



%Point to find gradient
%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%x = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, pi/2, .01];
%x = [298, 3e-4, 1.8e-5, 997, 40e-6, 0.1, pi/3, 0.0254];
%x = [298, 1.667e-5, 1.8e-5, 786.6, 4e-6, .1, pi/3, .01];
%Methanol at 25�C
x = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, .9999*pi/2, .01];
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


func = @(x) bendTubePenetrationB(x,1);
%func(x,1)

[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(func,x,[],[],[],[],x,x,[],options);

%Assuming that the initial vector can have its values changed by a fraction of 'frac', the absolute variation in the penetration P is:
frac = .05;
impact = (transpose(frac*x)).*(GRAD);
%The relative impact % is:
relativeImpact = impact/FVAL*100;

%% Plotting results

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Ticks in the x axis
%[T, Q, mu, ro_d, dd, Rb, theta, d]
name = {'T';'Q';'{\mu}';'{\rho_d}';'{d_d}';'{r_b}';'{\alpha}';'d'};
bar(relativeImpact(1:8,1))
set(gca,'xticklabel',name)
axis([0 9 -.2 .2])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the penetration (%)')
set(gca,'FontSize',16)
set(gcf,'color','w');
set(gca,'FontSize',16,'XGrid','on','YGrid','on')
% print('Penetration_Bend_Sensitivity_Analysis','-dpdf','-fillpage')


%% Sensitivity without assuming linearity (+percent% change)
clc
clear

%percent change
percent = 5;

relativeImpact = zeros(1,8);

x = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, .9999*pi/2, .01];

valueBefore = bendTubePenetrationB(x,1);

for i = 1:8
    temp =  x(i);
    x(i) = x(i)*(1 + percent/100);
    valueAfter = bendTubePenetrationB(x,1);
    relativeImpact(i) = (valueAfter - valueBefore) / valueBefore*100;
     x(i) = temp;
end

relativeImpact = relativeImpact';

% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
%Ticks in the x axis
name = {'T';'Q';'{\mu}';'{\rho_d}';'{d_d}';'{r_b}';'{\alpha}';'d'};
bar(relativeImpact(1:8,1),'FaceColor','k')
set(gca,'xticklabel',name)
axis([0 9 -.2 .2])
% axis([0 7 -1 1])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the penetration [%]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
