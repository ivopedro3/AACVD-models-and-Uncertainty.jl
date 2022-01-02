clc
clear

%The diameter of the bulk of the coil is approx. 20 cm, and its height is
%approx. 4-5 cm. I've attached the picture of the setup. Let me know if you need anything else.

%2, 8, 50 m

d = 0.01;
coilDiameter = 0.2;
phi = atan(d/coilDiameter);

%Droplet median diameter
dd = 5e-6;

P = zeros(1,3);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
parametersInclined = [298, 1.15, 1.667e-5, 1.8e-5, 786.6, 5.44e-4, dd, d, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
parametersBend = [298, 1.667e-5, 1.8e-5, 786.6, dd, coilDiameter/2, pi/2, d];

i=1;
for length = [2, 8, 50]
    numberOfTurns = length/(pi*coilDiameter);
    parametersInclined(10) = length;
    P(i) = bendTubePenetrationB(parametersBend,1)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
    i = i+1;
end
