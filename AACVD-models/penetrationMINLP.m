function P = penetrationMINLP(variables)

%variables = [Q_T, N_p, dd, d]

%Total flow rate arriving at the deposition site
Q_T = variables(1);
%Number of parallel pipes (of the same length and diameter)
N_p = round(variables(2));
%Droplet diameter
dd = variables(3);
%inner pipe diameter
d = variables(4);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
%parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

%Flow rate per pipe
Q_p = Q_T / N_p;

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
parameters = [298.15, 1.17, Q_p, 1.85e-5, 786.6, 5.47e-4, dd, d, 0*pi/2, 100];

P = straightTubePenetrationA(parameters);

end
