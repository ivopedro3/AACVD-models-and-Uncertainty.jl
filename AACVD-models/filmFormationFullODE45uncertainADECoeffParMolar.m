function [parameters, IC] = filmFormationFullODE45uncertainADECoeffParMolar(t)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%k1, k2, k3, h_mA, h_mB, h_mC

fileID = fopen('coeffs.txt','r');
formatSpec = '%f %f %f %f %f %f %f';
sizeA = [7 1];
transfer = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC]


V = 3.2 * 0.023 * 0.28; %0.021m3
A = 3.2 * 0.023; %=0.074 m2
% V = 3.2 * 0.023 * 0.28 *(1e6); %cm3
% A = 3.2 * 0.023 *(1e4); %cm2
%Total flow rate
%F_in = 0.005*(1e6); %cm3/s
F_in = 0.005; %m3/s

% %Initialising reactor
% Vinside_reactor = F_in*t;
% if Vinside_reactor < V
%     F_out = 0;
% else
%     F_out = F_in;
% end

%If the reactor is already operating
F_out = F_in;

%if C_A solution = 1 mol/L and the aerosol is 1% in volume, then C_Ain = 0.01 mol/L = 1e-5 mol/cm3
C_Ain = 10; %mol/m3
C_Bin = 0;
C_Cin = 0;
C_Din = 0;
ro_f = 70000; %mol/m3

parameters = zeros (14, 1);

parameters(1) = V;
parameters(2) = A;
parameters(3) = ro_f;
parameters(4) = F_in;
parameters(5) = F_out;
parameters(6) = C_Ain;
parameters(7) = C_Bin;
parameters(8) = C_Cin;
parameters(9) = C_Din;
parameters(10) = transfer(1);
parameters(11) = transfer(2);
parameters(12) = transfer(3);
parameters(13) = transfer(4);
parameters(14) = transfer(5);
parameters(15) = transfer(6);
parameters(16) = transfer(7);


IC(1) = C_Ain;
IC(2) = 0;
IC(3) = C_Bin;
IC(4) = 0;
IC(5) = C_Cin;
IC(6) = 0;
IC(7) = 0;

end
