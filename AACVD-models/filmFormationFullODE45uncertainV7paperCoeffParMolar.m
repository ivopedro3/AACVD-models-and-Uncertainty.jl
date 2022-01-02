function [parameters, IC] = filmFormationFullODE45uncertainV7paperCoeffParMolar(t,y)

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

V_interface = 1e-5;
V = 3.2*1.2*0.02; %one direction flow
% V = 3.2*1.2*0.02/2; %mixed flow
A = 3.2*1.2; %=3.84m2

%Total flow rate
F_in = 0.0096; %m3/s

%Steady state
F_out = F_in;

C_Ain = 0; %mol/m3
C_Bin = 0;
C_Cin = 0;
C_Din = 0;

ro_f = 70000; %mol/m3

parameters = zeros (14, 1);

parameters(1) = V;
parameters(2) = V_interface;
parameters(3) = A;
parameters(4) = ro_f;
parameters(5) = F_in;
parameters(6) = F_out;
parameters(7) = C_Ain;
parameters(8) = C_Bin;
parameters(9) = C_Cin;
parameters(10) = C_Din;
parameters(11) = transfer(1);
parameters(12) = transfer(2);
parameters(13) = transfer(3);
parameters(14) = transfer(4);
parameters(15) = transfer(5);
parameters(16) = transfer(6);
parameters(17) = transfer(7);


IC(1) = C_Ain;
IC(2) = 0;
IC(3) = C_Bin;
IC(4) = 0;
IC(5) = C_Cin;
IC(6) = 0;
IC(7) = 0;

end
