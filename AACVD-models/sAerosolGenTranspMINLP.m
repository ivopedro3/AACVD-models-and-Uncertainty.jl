clear
clc

global test;
test = 777;

%% Aerosol generation
%


%% Aerosol transport

%parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

%variables = [Q_T, N_p, dd, d]
xLB = [2e-5, 1, 0.01e-6  0.01];
xUB = [5e-3, 10,10e-6 0.10];




sampleSize = 100;
numberOfVariables = 4;
sample = lhsdesign(sampleSize,numberOfVariables);

P_record = zeros(1,sampleSize);
x_record = zeros(sampleSize, numberOfVariables);

for i = 1:sampleSize
    x0 = (xUB-xLB).*sample(i,:) + xLB;
    [X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLP,x0,[],[],[],[],xLB,xUB,[]);
    X(2) = round(X(2));
    P_record(i) = FVAL;
    x_record(i,:) = X;
end

%x0 = [3e-5, 4, 4e-6 0.03];
%[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@penetrationMINLP,x0,[],[],[],[],xLB,xUB,[]);
%X(2) = round(X(2));
