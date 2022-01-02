clear
clc

%Lower bound
lb = [270, 0.1, 0, 1e-6, 0.1, 1e-8, 1e-8, 1e-3, 0, 2];
%Upper bound
ub = [400, 100, 0.1, 1e-4, 10000, 1e-2, 1e-2, 1e-1, 90, 2];
%Initial guess
x0 = [298, 1.205, 3.3333e-4, 1.82076e-5, 1011.84, 8.68e-4, 1.00692e-5, .0254, 0, 2];

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

[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] = fmincon(@straightTubePenetrationA,x0,[],[],[],[],lb,ub,[],options);
