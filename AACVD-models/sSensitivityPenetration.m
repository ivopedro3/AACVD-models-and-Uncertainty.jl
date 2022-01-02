clear
clc

%Things to study:
%relationship between d, Q and Ve
%what I can change to maximise P
%pipe length may be fixed, but I can play with d, Q and Ve (which are related to each other)


%% Studying P 2D

x = (0:0.1:5);
%DomainSizeX = size(x);
y = exp(-x);

figure
plot(x,y)
%xlim([0 90])
title('Penetration')
xlabel('Pipe lenght (m)')
ylabel('Penetration (fraction)')

%% Studying P 3D

%P = exp(-(pi*d*Ve)/(Q));

VeRange = (1e-4:1e-4:5e-3);
QRange = (1e-5:1e-5:5e-4);
[Ve,Q] = meshgrid(VeRange,QRange);

d = 0.05;
x = 2;

k = pi*d*x;

P = exp(-k*Ve./Q);

figure
surface(Ve,Q,P)
view(3)
%xlim([0 90])
title('Penetration')
xlabel('Ve')
ylabel('Q')
zlabel('Penetration (fraction)')



%% Studying Ve 3D

clear
clc


%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];

% QRange = (1e-5:0.5e-5:4e-4);
% dRange = (1e-3:1e-3:1e-1);

QRange = (1e-5:0.5e-5:4e-4);
dRange = (1e-3:1e-3:5e-2);

[Q,d] = meshgrid(QRange,dRange);

DomainSizeX = size(Q);
DomainSizeXX = size(d);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

Ve = zeros(final_i,final_j);

parameters = [298, 1.2, 0000, 1.821e-5, 1011.9, 8.68e-4, 1e-5, 0000, 0, 5];


for i=1:final_i
    for j=1:final_j

        parameters(3) = Q(i,j);
        parameters(8) = d(i,j);

        Ve(i,j) = effectiveDepositionalVelocity(parameters);
    end
end

% figure
% surface(Q,d,Ve)
% view(3)
% %xlim([0 90])
% title('Penetration')
% xlabel('Q (m3s-1)')
% ylabel('d (m)')
% zlabel('Ve (ms-1)')

L = 1;

P = exp(-pi*L*d.*Ve./Q);

figure
surface(Q,d,P)
view(3)
%xlim([0 90])
title('Penetration')
xlabel('Q (m3s-1)')
ylabel('d (m)')
zlabel('P (fraction)')


%% Testing

clc
clear

parameters = [298, 1.2, 0000, 1.821e-5, 1011.9, 8.68e-4, 1e-5, 0000, 0, 5];

parameters(3) = 4e-4;%Q(i,j);
parameters(8) = 5e-3;%d(i,j);


Ve = effectiveDepositionalVelocity(parameters);
