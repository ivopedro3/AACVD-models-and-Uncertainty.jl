function concentrations = filmFormation(parameters)

%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)

%parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3]

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

syms C_A_vap(t) C_A_sol(t) C_B_vap(t) C_B_sol(t) C_C_vap(t) C_C_sol(t) C_D_sol(t)

%Differential equations
ode1 = diff(C_A_vap) == (F_in/V)*C_Ain - k1*C_A_vap;
ode2 = diff(C_A_sol) == - k3*C_A_sol*(A/V);
ode3 = diff(C_B_vap) == (F_in/V)*C_Bin - (F_out/V)*C_B_vap + k1*C_A_vap;
ode4 = diff(C_B_sol) == - k2*C_B_sol*(A/V);
ode5 = diff(C_C_vap) == (F_in/V)*C_Cin - (F_out/V)*C_C_vap - k1*C_A_vap;
ode6 = diff(C_C_sol) == - k3*C_A_sol*(A/V) + 2*k3*C_A_sol*(A/V);
ode7 = diff(C_D_sol) == k2*C_B_sol*(A/V) + k3*C_A_sol*(A/V);

odes = [ode1; ode2; ode3; ode4; ode5; ode6; ode7];

%Initial conditions
cond1 = C_A_vap(0) == C_Ain;
cond2 = C_A_sol(0) == 0;
cond3 = C_B_vap(0) == C_Bin;
cond4 = C_B_sol(0) == 0;
cond5 = C_C_vap(0) == C_Cin;
cond6 = C_C_sol(0) == 0;
cond7 = C_D_sol(0) == 0;

conds = [cond1; cond2; cond3; cond4; cond5; cond6; cond7];

%Solving
[C_A_vap_Sol(t), C_A_sol_Sol(t), C_B_vap_Sol(t), C_B_sol_Sol(t), C_C_vap_Sol(t), C_C_sol_Sol(t), C_D_sol_Sol(t)] = dsolve(odes,conds);

%Visualising the solution
fplot(C_A_vap_Sol)
hold on
fplot(C_A_sol_Sol)
grid on
fplot(C_B_vap_Sol)
grid on
fplot(C_B_sol_Sol)
grid on
fplot(C_C_vap_Sol)
grid on
fplot(C_C_sol_Sol)
grid on
fplot(C_D_sol_Sol)
grid on
legend('C_A_vap','C_A_sol', 'C_B_vap','C_B_sol', 'C_C_vap','C_C_sol', 'C_D_sol', 'Location','best')

%Future work: return steady state concentrations
concentrations = [];

end
