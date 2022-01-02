clear
clc

%% Running the optimisation

%Point to find gradient
%Parameters = [Q, ro, mu, sigma, d, I, f]
%Water at 25�C
%x = [1e-9,997,0.00089,0.0728,0,1.5e4,200e3];
%Methanol at 25�C
x = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 1.6e6];
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

[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@dropletDiameterB,x,[],[],[],[],xLB,xUB,[],options);

%Assuming that the initial vector can have its values changed by a fraction of 'frac', the absolute variation in the droplet median diameter is:
frac = .05;
impact = (transpose(frac*x)).*(GRAD);
%The relative impact percentage is:
relativeImpact = impact/FVAL*100;

%% Plotting results

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Ticks in the x axis
name = {'Q';'{\rho}';'{\mu}';'{\sigma}';'I'; 'f'};
bar(relativeImpact([1:4,6:7],1))
set(gca,'xticklabel',name)
axis([0 7 -1 1])
%title('Sensitivity analysis')
xlabel('Parameter changed by +5%')
ylabel('Variation in the droplet median diameter (%)')
set(gca,'FontSize',20,'XGrid','on','YGrid','on')
set(gcf,'color','w');
print('Atomiser_Sensitivity_Analysis','-dpdf','-fillpage')
