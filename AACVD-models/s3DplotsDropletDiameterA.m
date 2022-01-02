clear
clc

%% Droplet diameter vs frequency and density

%Parameters = [sigma, ro, f]
%Methanol at 25�C
x =  [2.2e-2, 786.6, 1.6e6];

frequencyMedian = 1.6e6;
densityMedian = 750;

frequencyRange = (frequencyMedian*.2:10e3:frequencyMedian*2);
densityRange = (densityMedian*.9:5:densityMedian*4);

[X,Y] = meshgrid(frequencyRange,densityRange);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

dd = zeros(final_i,final_j);
x=0;

parameters =  [2.2e-2, 786.6, 1.6e6];

for i=1:final_i
    for j=1:final_j

        parameters(3) = X(i,j);
        parameters(2) = Y(i,j);

        dd(i,j) = dropletDiameterA(parameters);

    end
end

%Converting diameter from metre to micrometre
dd = dd*1e6;

%Converting frequecy from Hz to kHz
X = X*1e-3;


% Create plot figure
figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
surface(X,Y,dd,'EdgeColor','none')
view(3) %sets the default three-dimensional view
%xlim([0 90])
ylim([600 2800])
zlim([0 7])
% title('Droplet diameter as a function of transducer frequency and fluid surface tension')
xlabel('Ultrasonic atomiser frequency [kHz]')
ylabel('Fluid density [kg m^{-3}]')
zlabel('Droplet median diameter [{\mu}m]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on', 'ZGrid','on')
colorbar();
