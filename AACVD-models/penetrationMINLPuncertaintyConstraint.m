function [c,ceq] = penetrationMINLPuncertaintyConstraint(x)
global fracOUT;

%tau is the film thickness (film deposited on glass). These are the boundaries
% tau_LB = 50e-9;
% tau_UB = 500e-9;

tau_LB = 400e-9;
tau_UB = 500e-9;

%aerosol concentration (volume fraction of the total flow rate)
phi_aer = 0.01;
%C is the precursor molar concentration in mol/L of the aerosol (precursor solution)
%200 to 2000 mol/m3
C = 1000;
%Glass velocity 10 to 15 m/min
v = 12/60;
%Glass width
w = 3.2;

% %This is one option instead of using fracOUT as a global variable.
% fileID = fopen('fracOUT.txt', 'r');
% fracOUT = -fscanf(fileID, '%f');
% fclose(fileID);

m_rate = -fracOUT * (x(1)*phi_aer*C);

%This factor converts the mass flow rate into film growth rate
factor = 1e-4*sqrt(m_rate);

%tau is the film thickness
tau = m_rate*factor / (w*v);


%the inequality constraint (tau <= tau_UB AND tau >= tau_LB)
c = [tau - tau_UB; -tau + tau_LB];

%Just to avoid fmincon stopping because maximum constraint violation was less than options.ConstraintTolerance.
c = c*1e8;
ceq = [];

end
