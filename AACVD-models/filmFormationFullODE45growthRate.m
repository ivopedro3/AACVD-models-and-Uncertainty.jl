function dydt = filmFormationFullODE45growthRate(t, y)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)


%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3]

parameters = filmFormationFullODE45parameters(t);


V = parameters(1);
A = parameters(2);
F_in = parameters(3);
F_out = parameters(4);
C_Ain = parameters(5);
C_Bin = parameters(6);
C_Cin = parameters(7);
k1 = parameters(8);
k2 = parameters(9);
k3 = parameters(10);
h_mA = parameters(11);
h_mB = parameters(12);
h_mC = parameters(13);

dydt = zeros(7,1);

ftau


%Differential equations (using volumetric concentration definition for surface reactions)
%All concentrations are in (amount of substance / volume)
dydt(1) = (F_in/V)*C_Ain - (F_out/V)*y(1) - h_mA*(A/V)*(y(1)-y(2)) - k1*y(1);
dydt(2) = h_mA*(A/V)*(y(1)-y(2)) - k3*y(2)*(A/V);
dydt(3) = (F_in/V)*C_Bin - (F_out/V)*y(3) - h_mB*(A/V)*(y(3)-y(4)) + k1*y(1);
dydt(4) = h_mB*(A/V)*(y(3)-y(4)) - k2*y(4)*(A/V);
dydt(5) =  (F_in/V)*C_Cin - (F_out/V)*y(5) - h_mC*(A/V)*(y(5)-y(6)) + k1*y(1);
dydt(6) =  h_mC*(A/V)*(y(5)-y(6)) + k2*y(4)*(A/V) + 2*k3*y(2)*(A/V);
dydt(7) = k2*y(4)*(A/V) + k3*y(2)*(A/V);


%Differential equations (using surface area definition for surface reaction)
%Concentrations in the vapour phase are in (amount of substance / volume)
%Concentrations in the surface are in (amount of substance / surface area)



end
