function [parameters, IC] = filmFormationFullODE45uncertainCoeffParameters(t)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%k1, k2, k3, h_mA, h_mB, h_mC

fileID = fopen('coeffs.txt','r');
formatSpec = '%f %f %f %f %f %f';
sizeA = [6 1];
transfer = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC]

% V = 0.023;
% A = 0.083;
V = 3.2 * 0.023 * 0.28; %=0.021
A = 3.2 * 0.023; %=0.074
%F_in = 0.005;
%Total flow rate
F_in = 0.005;
%Flow rate per pipe
%F_in = 1.9e-4;

% %Initialising reactor
% Vinside_reactor = F_in*t;
% if Vinside_reactor < V
%     F_out = 0;
% else
%     F_out = F_in;
% end

%If the reactor is already operating
F_out = F_in;

%if C_A solution = 1 mol/L and the aerosol is 1% in volume, then C_Ain = 0.01 mol/L
C_Ain = 10;
C_Bin = 0;
C_Cin = 0;

parameters = zeros (13, 1);

parameters(1) = V;
parameters(2) = A;
parameters(3) = F_in;
parameters(4) = F_out;
parameters(5) = C_Ain;
parameters(6) = C_Bin;
parameters(7) = C_Cin;
parameters(8) = transfer(1);
parameters(9) = transfer(2);
parameters(10) = transfer(3);
parameters(11) = transfer(4);
parameters(12) = transfer(5);
parameters(13) = transfer(6);


IC(1) = C_Ain;
IC(2) = 0;
IC(3) = C_Bin;
IC(4) = 0;
IC(5) = C_Cin;
IC(6) = 0;
IC(7) = 0;

end
