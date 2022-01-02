function [P_case_1, P_case_2] = inclined_or_not_TubePenetration(l,h)

%%Parameters
%Travelling a length l
%Travelling height h

%%Calculating P for fist case (inclined pipe):
x=sqrt(l^2+h^2);
phi=atan(h./l);

%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, phi, x];

P_case_1 = -straightTubePenetrationA(parameters);

%%Calculating P for fist case (horizontal pipe, 90o bend and vertical pipe):

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, phi, x];
%parameters = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0254, 0, l];
P1 = -straightTubePenetrationA(parameters);

%parameters = [T, Q, mu, ro_d, dd, d];
%bendAngle=90;
%parameters = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .01];
%P2 = bendTubePenetrationA(bendAngle, parameters);
%Methanol at 25�C
parameters = [298.15, 3.3333e-5, 1.85e-5, 786.6, 7e-6, .1, pi/2, .01];
P2 = bendTubePenetrationB(parameters,1);
%P2 = bendTubePenetrationB(parameters,2);


%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, phi, x];
%parameters = [298, 1.15, 3e-4, 1.8e-5, 997, 8.9e-4, 40e-6, .0254, pi/2, h];
P3 = -straightTubePenetrationA(parameters);

P_case_2=P1*P2*P3;


end
