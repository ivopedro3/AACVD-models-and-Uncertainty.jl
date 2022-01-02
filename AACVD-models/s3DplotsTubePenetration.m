clear
clc

inclinationAngleRange = (0:1:90);
pipeLengthRange = (0:0.01:15);

[X,Y] = meshgrid(inclinationAngleRange,pipeLengthRange);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

P = zeros(final_i,final_j);
x=0;

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, pi/2, 0];

for i=1:final_i
    for j=1:final_j

        parameters(9) = X(i,j)*(pi/180); %Conversion from degrees to rad
        parameters(10) = Y(i,j);

        P(i,j) = -straightTubePenetrationA(parameters);
    end
end


% Create figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
set(axes1,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
hold(axes1,'on');
% Create surface
surface('Parent',axes1,'ZData',P,'YData',Y,'XData',X,'LineStyle','none','CData',P,'EdgeColor','none');
xlim([0 90])
view(axes1,[144 29.84]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%xlim([0 90])
%title('Aerosol penetration fraction as a function of pipe length and pipe inclination')
% xlabel('Inclination angle [degrees]','Rotation',20)
xlabel('Inclination angle [degrees]')
ylabel('Pipe length [m]')
zlabel('Penetration [fraction]')
colorbar(axes1);
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on', 'ZGrid','on')
