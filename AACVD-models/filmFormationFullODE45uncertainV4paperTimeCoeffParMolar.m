function [parameters, IC] = filmFormationFullODE45uncertainV4paperTimeCoeffParMolar(t,y)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%k1, k2, k3, h_mA, h_mB, h_mC, h_mD

fileID = fopen('coeffs.txt','r');
formatSpec = '%f %f %f %f %f %f %f';
sizeA = [7 1];
transfer = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3, h_mA, h_mB, h_mC, h_mD]

% % Industry setting
% v = 0.24;
% w = 3.2;
% t_end = 5;
% h=1e-7*10000;
%
% V_interface = h*w*v*t_end;
% V = 3.2*1.2*0.02; %0.0768 m3
% A = 3.2*1.2; %=3.84m2
% %Total flow rate
% F_in = 0.010; %m3/s

%Lab setting
V = 0.045*0.1*0.03;
A = 0.045*0.1;
V_interface = 1E-05;

%Total flow rate
F_in = 0.001/60; % 0.001/60 m3/s = 1 L/min

% %Initialising reactor
% Vinside_reactor = F_in*t;
% if Vinside_reactor < V
%     F_out = 0;
% else
%     F_out = F_in;
% end

%If the reactor is already operating
F_out = F_in;

C_Ain = 0.152; %mol/m3
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
