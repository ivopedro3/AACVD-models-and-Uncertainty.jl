clear
clc


%% Aerosol generation
%


%% Aerosol transport

%parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

%variables = [Q_T, N_p, dd, d]
%xLB = [2e-5, 1, 0.001e-6,  0.01];
%xLB = [2e-5, 1, 4e-6,  0.01];
%xLB = [2e-5, 1, 0.01e-6,  0.01];
xLB = [2e-5, 1, 0.1e-6, 0.01];
xUB = [5e-3, 10, 0.3e-6, 0.05];
%xUB = [5e-3, 10, 10e-6, 0.05];
%xUB = [200e-3, 10, 10e-6, 0.05];


tic
sampleSize = 50;
numberOfVariables = 4;
sample = lhsdesign(sampleSize,numberOfVariables);

P_record = zeros(1,sampleSize);
x_record = zeros(sampleSize, numberOfVariables+2);

nonlcon = @penetrationMINLPuncertaintyConstraint;

options = optimoptions('fmincon','StepTolerance',1e-12);

for i = 1:sampleSize
    x0 = (xUB-xLB).*sample(i,:) + xLB;
    %Not constrained by tau
    %[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLPuncertainty,x0,[],[],[],[],xLB,xUB,[],options);
    %Constrained by tau
    [X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLPuncertainty,x0,[],[],[],[],xLB,xUB,nonlcon,options);
    X(2) = round(X(2));
    P_record(i) = FVAL;
    x_record(i,1) = EXITFLAG;
    x_record(i,3:6) = X;
end
P_record = P_record';
x_record(:,2) = -P_record(:);
toc


%% Aerosol transport (constant total cross-sectional area)

%parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

%variables = [Q_T, N_p, dd, A_T]
%xLB = [2e-5, 1, 3e-6  1e-5];
xLB = [2e-5, 1, 0.001e-6  1e-5];
%xUB = [10e-3, 10,15e-6 1e-1];
xUB = [200e-3, 10,10e-6 3e-3];


tic
sampleSize = 500;
numberOfVariables = 4;
sample = lhsdesign(sampleSize,numberOfVariables);

P_record = zeros(1,sampleSize);
x_record = zeros(sampleSize, numberOfVariables);

for i = 1:sampleSize
    x0 = (xUB-xLB).*sample(i,:) + xLB;
    [X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLPuncertaintyCrossArea,x0,[],[],[],[],xLB,xUB,[]);
    X(2) = round(X(2));
    P_record(i) = FVAL;
    x_record(i,:) = X;
end
P_record = P_record';
%x0 = [3e-5, 4, 4e-6 0.03];
%[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLP,x0,[],[],[],[],xLB,xUB,[]);
%X(2) = round(X(2));

x_record(:,7) = -P_record(:);
toc


%% Studying the impact of increasing the number of parallel pipes (keeping the same total cross-sectional area)

%variables = [Q_T, N_p, dd, A_T]
% Variables = [0.005121547	1	1.55E-07	0.002993954];
%Very large flow rate:
% Variables = [1	1	1.55E-07	0.002993954];
%Very large cross-sectional area
 Variables = [0.005121547	1	1.55E-07	0.1];
%Bigger droplet diameter
%Variables = [0.005121547	1	5E-06	0.002993954];

%Max number of parallel pipes
Np_max = 50;

P = zeros(1,Np_max);
Np = 1:1:Np_max;

for i = 1:Np_max
    Variables(2) = i;
    P(i) = -penetrationMINLPuncertaintyCrossArea(Variables);
end

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter(Np, P, 'filled');
%legend('','')
xlabel('Number of parallel pipes')
ylabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
hold off
