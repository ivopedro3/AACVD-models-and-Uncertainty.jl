function dcdt = filmFormationODE45(t, C)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)


%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3]

parameters = filmFormationODE45parameters();


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

dcdt = zeros(7,1);

%Differential equations
dcdt(1) = (F_in/V)*C_Ain - (F_out/V)*C(1) - k1*C(1);
dcdt(2) = - k3*C(2)*(A/V);
dcdt(3) = (F_in/V)*C_Bin - (F_out/V)*C(3) + k1*C(1);
dcdt(4) = - k2*C(4)*(A/V);
dcdt(5) =  (F_in/V)*C_Cin - (F_out/V)*C(5) + k1*C(1);
dcdt(6) =  k2*C(4)*(A/V) + 2*k3*C(2)*(A/V);
dcdt(7) = k2*C(4)*(A/V) + k3*C(2)*(A/V);


end
