function [parameters, IC] = filmFormationFullODE45parameters(t)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC]

T = 700;

V = 0.023;
A = 0.083;

F_in = 0.1;

Vinside_reactor = F_in*t;
if Vinside_reactor < V
    F_out = 0;
else
    F_out = F_in;
end

C_Ain = 1e3;
C_Bin = 0;
C_Cin = 0;

% %k1 = 2.7e14*exp(-57000/8.314/T);
% k1 = 2.7e1;
% k2 = 1.9e2;
% k3 = 5.4e-2;

parameters_k1 = [7.1e3 1.4e4 T];
parameters_k2 = [5.3e3 2.7e4 T];
parameters_k3 = [1.2e4 0.8e4 T];

k1 = kineticsArrhenius(parameters_k1);
k2 = kineticsArrhenius(parameters_k2);
k3 = kineticsArrhenius(parameters_k3);

k1 = 2.7e1;
k2 = 1.9e2;
k3 = 5.4e-2;

Q = 1;

parameters_h_mA = [0.7 .5 0.01 Q 15e-6 0.3];
parameters_h_mB = [0.7 .5 0.01 Q 15e-6 0.38];
parameters_h_mC = [0.7 .5 0.01 Q 15e-6 0.9];

h_mA = massTransferCoeff(parameters_h_mA);
h_mB = massTransferCoeff(parameters_h_mB);
h_mC = massTransferCoeff(parameters_h_mC);

% h_mA = h_mA*1e7;
% h_mB = h_mB*1e7;
% h_mC = h_mC*1e7;

% h_mA = 1.7e2;
% h_mB = 0.9e1;
% h_mC = 3.9e1;

h_mA = 1.7e2;
h_mB = 0.9e1;
h_mC = 3.9e1;

parameters = zeros (13, 1);

parameters(1) = V;
parameters(2) = A;
parameters(3) = F_in;
parameters(4) = F_out;
parameters(5) = C_Ain;
parameters(6) = C_Bin;
parameters(7) = C_Cin;
parameters(8) = k1;
parameters(9) = k2;
parameters(10) = k3;
parameters(11) = h_mA;
parameters(12) = h_mB;
parameters(13) = h_mC;


IC(1) = C_Ain;
IC(2) = 0;
IC(3) = C_Bin;
IC(4) = 0;
IC(5) = C_Cin;
IC(6) = 0;
IC(7) = 0;

end
