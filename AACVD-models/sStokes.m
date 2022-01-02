
%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
parameters = [298, 1.2, 3.33e-4, 1.821e-5, 1011.9, 8.68e-4, 10e-6, .0254, 0, 1];
straightTubePenetrationA(parameters)

%Used
%T, Q, ro_d, dd, d, phi, L, pressure

%Not used
%ro, mu, mu_d

%Additional
%Free stream velocity

%Assumptions
% 0.001 < dd < 30 um for Beal's model, but Deposition only shows warning if
% dd > 60 um.
