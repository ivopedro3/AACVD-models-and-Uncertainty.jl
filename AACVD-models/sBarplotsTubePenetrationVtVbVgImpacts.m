%% Studying variation of droplet size

clear
clc

dropletSize = [.01,.1,1,10];

DomainSizeX = size(dropletSize);
final_i=DomainSizeX(2);
x = zeros(final_i,4);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
%horizontal
% parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];
%vertical
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 1*pi/2, 2];

for i=1:final_i
    %[P, Vt, Vb, Vg]
    parameters(7) = dropletSize(i)*1e-6;
    [x(i,1), x(i,2), x(i,3), x(i,4)] = straightTubePenetrationAimpactVtVbVg(parameters);
end

%Percentage contribution (%) instead of fraction
x = x*100;

% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);

%Ticks in the x axis
name = {'0.01';'0.1';'1';'10'};
bar([x(1,2:4); x(2,2:4); x(3,2:4); x(4,2:4)],'stacked')
set(gca,'xticklabel',name)
axis([0 5 0 130])
set(gca, 'YTick', [0 20 40 60 80 100])

%axis([0 9 -1 2.5])
%titleSize = title('Impact of different mechanisms on aerosol deposition for different droplet sizes');
xlabel('Droplet diameter [{\mu}m]')
ylabel('Percentage contribution [%]')
legend('Turbulent diffusion','Brownian diffusion','Gravitational settling');
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

% print('Penetration_Mechanisms_Contribution_Horiz_vs_dd','-dpdf','-fillpage')
% print('Penetration_Mechanisms_Contribution_Vert_vs_dd','-dpdf','-fillpage')



%% Studying variation of pipe diameter

clear
clc

pipeDiameter = [.005,.007,.010,.012];

DomainSizeX = size(pipeDiameter);
final_i=DomainSizeX(2);
x = zeros(final_i,4);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];
% parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, pi/2, 2];
% For the given droplet diameter, vertical pipe would have only turbulent contribution
for i=1:final_i
    %[P, Vt, Vb, Vg]
    parameters(8) = pipeDiameter(i);
    [x(i,1), x(i,2), x(i,3), x(i,4)] = straightTubePenetrationAimpactVtVbVg(parameters);
end


%Percentage contribution (%) instead of fraction
x = x*100;

% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);

%Ticks in the x axis
name = {'5';'7';'10';'12'};
bar([x(1,2:4); x(2,2:4); x(3,2:4); x(4,2:4)],'stacked')
set(gca,'xticklabel',name)
axis([0 5 0 130])
set(gca, 'YTick', [0 20 40 60 80 100])
%titleSize = title('Impact of different mechanisms on aerosol deposition for different horizontal pipe diameters');
xlabel('Pipe diameter [mm]')
ylabel('Percentage contribution [%]')
legend('Turbulent diffusion','Brownian diffusion','Gravitational settling');
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

% print('Penetration_Mechanisms_Contribution_Horiz_vs_d','-dpdf','-fillpage')
