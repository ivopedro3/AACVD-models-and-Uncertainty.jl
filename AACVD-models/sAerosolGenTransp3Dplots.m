clear
clc


%% Aerosol generation
%



%% Aerosol transport plots (Q_T, N_p)

Q_T_Range = (1e-5:0.1e-5:500e-5);
N_p_Range = (1:1:7);

[X,Y] = meshgrid(Q_T_Range,N_p_Range);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

P = zeros(final_i,final_j);

%variables = [Q_T, N_p, dd, d]
%variables(1) = Q_T;
%round(variables(2)) = N_p;
variables(3) = 1e-6;
variables(4) = 0.01;

for i=1:final_i
    for j=1:final_j

        variables(1) = X(i,j);
        variables(2) = Y(i,j);

        P(i,j) = -penetrationMINLP(variables);

    end
end


figure
%surface(X,Y,P)
%plot3(X,Y,P)
sizeNp = size(N_p_Range);
for i=1:sizeNp(2)
    scatter3(X(i,:),Y(i,:),P(i,:), 'filled')
    hold on
end
view(3) %sets the default three-dimensional view
%xlim([0 90])
title('Aerosol penetration as a function of Total flow rate and number of parallel pipes')
xlabel('Total flow rate (m�/s)')
ylabel('Number of parallel pipes')
zlabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(gcf,'color','w');


%% Aerosol transport plots (dd, d)

dd_Range = (0.01e-6:0.01e-6:5e-6);
d_Range = (0.001:0.001:.03);

[X,Y] = meshgrid(dd_Range,d_Range);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

P = zeros(final_i,final_j);

%variables = [Q_T, N_p, dd, d]
%variables(1) = 3.3333e-5;
variables(1) = 1e-3;
variables(2) = 1;
%variables(3) = 1e-6;
%variables(4) = 0.01;

for i=1:final_i
    for j=1:final_j

        variables(3) = X(i,j);
        variables(4) = Y(i,j);

        P(i,j) = -penetrationMINLP(variables);

    end
end


figure
surface(X,Y,P)
view(3) %sets the default three-dimensional view
%xlim([0 90])
title('Aerosol penetration as a function of droplet diameter and pipe diameter')
xlabel('Droplet diameter (m)') %{\mu}
ylabel('Pipe diameter (m)')
zlabel('Penetration (fraction)')
set(gca,'FontSize',16)
set(gca, 'XScale', 'log')
set(gcf,'color','w');
