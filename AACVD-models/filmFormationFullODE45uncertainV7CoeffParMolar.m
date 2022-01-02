function [parameters, IC] = filmFormationFullODE45uncertainV7CoeffParMolar(t,y)

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
v = 0.24;
w = 3.2;
t_end = 5;
h=1e-7*10000;

V_interface = h*w*v*t_end;
V = 3.2*1.2*0.02; %0.0768 m3
A = 3.2*1.2; %=3.84m2

% V = 3.2 * 0.023 * 0.28; %0.021m3
% A = 3.2 * 0.023; %=0.074 m2
% v = 0.15;

%Total flow rate
% F_in = 0.01; %m3/s
F_in = 0.008; %m3/s

% %Initialising reactor
% Vinside_reactor = F_in*t;
% if Vinside_reactor < V
%     F_out = 0;
% else
%     F_out = F_in;
% end

%If the reactor is already operating
F_out = F_in;

C_Ain = 0; %mol/m3
C_Bin = 0;
C_Cin = 0;
C_Din = 0;

ro_f = 68796.07; %mol/m3

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
