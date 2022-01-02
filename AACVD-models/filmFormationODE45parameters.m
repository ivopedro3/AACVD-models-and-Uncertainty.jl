function [parameters, IC] = filmFormationODE45parameters()

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3]

V = 480e-6;
A = 120e-4;
F_in = 1000e-6; %assumption
F_out = 1000e-6; %assumption
% C_Ain = 3.175e4;
% C_Bin = 5.37e3;
% C_Cin = 30.76e6;
C_Ain = 3.175e6;
C_Bin = 5.37e3;
C_Cin = 3.76e6;
% k1 = 2.7e14*exp(-57000/8.314/700);
% k2 = 1.9e2;
% k3 = 5.4e-2;
k1 = 2.7e2;
k2 = 1.9e2;
k3 = 5.4e-2;

parameters = zeros (10, 1);

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

% IC(1) = C_Ain;
% IC(2) = 5.686e2;
% IC(3) = C_Bin;
% IC(4) = 4.759e-2;
% IC(5) = C_Cin;
% IC(6) = 2.023e6;
% IC(7) = 5.081e2;

IC(1) = C_Ain;
IC(2) = 5.686e2;
IC(3) = C_Bin;
IC(4) = 4.759e2;
IC(5) = C_Cin;
IC(6) = 2.023e6;
IC(7) = 5.081e2;

end
