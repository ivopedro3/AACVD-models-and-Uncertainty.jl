clear
clc

%% Droplet diameter vs frequency and surface tension

frequencyMedian = 25000;
surfaceTensionMedian = 0.07;

frequencyRange = (frequencyMedian*.2:1000:frequencyMedian*8);
surfaceTensionRange = (surfaceTensionMedian*.5:0.001:surfaceTensionMedian*1.8);

[X,Y] = meshgrid(frequencyRange,surfaceTensionRange);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

dd = zeros(final_i,final_j);
x=0;

parameters = [1e-9,997,0.00089,0.0728,0,1.5e4,0];

for i=1:final_i
    for j=1:final_j

        parameters(7) = X(i,j);
        parameters(4) = Y(i,j);

        dd(i,j) = dropletDiameterB(parameters);

    end
end

%Converting diameter from metre to micrometre
dd = dd*1e6;

%Converting frequecy from Hz to kHz
X = X*1e-3;

figure
surface(X,Y,dd)
view(3) %sets the default three-dimensional view
%xlim([0 90])
title('Droplet diameter as a function of transducer frequency and fluid surface tension')
xlabel('Transducer frequency (kHz)')
ylabel('Fluid surface tension (N/m)')
zlabel('Droplet diameter ({\mu}m)')
set(gca,'FontSize',16)
set(gcf,'color','w');


%% Droplet diameter vs frequency and fluid flow rate


frequencyRange = (1.52e6:.01e6:1.68e6);
flowRateRange = (.95e-12:.0001e-12:1.05e-12);

[X,Y] = meshgrid(frequencyRange,flowRateRange);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

dd = zeros(final_i,final_j);

%Parameters = [Q, ro, mu, sigma, d, I, f]
%Methanol at 25�C
parameters = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 0];

for i=1:final_i
    for j=1:final_j

        parameters(7) = X(i,j);
        parameters(1) = Y(i,j);

        dd(i,j) = dropletDiameterB(parameters);

    end
end

%Converting diameter from metre to micrometre
dd = dd*1e6;

%Converting frequecy from Hz to kHz
X = X*1e-3;

figure
surface(X,Y,dd)
view(3) %sets the default three-dimensional view
%xlim([0 90])
title('Droplet diameter as a function of transducer frequency and fluid surface tension')
xlabel('Transducer frequency (kHz)')
ylabel('Fluid surface tension (N/m)')
zlabel('Droplet diameter ({\mu}m)')
set(gca,'FontSize',16)
set(gcf,'color','w');


%% Showing how the fluid flow rate has a greater impact than the surface tension on the droplet diameter


flowRateRange = (.5e-12:.01e-12:1.5e-12);
surfaceTensionRange = (1.2e-2:0.01e-2:3.3e-2);

[X,Y] = meshgrid(flowRateRange,surfaceTensionRange);

DomainSizeX = size(X);

final_i=DomainSizeX(1);
final_j=DomainSizeX(2);

dd = zeros(final_i,final_j);

%Parameters = [Q, ro, mu, sigma, d, I, f]
%Methanol at 25�C
parameters = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 1.6e6];

for i=1:final_i
    for j=1:final_j

        parameters(1) = X(i,j);
        parameters(4) = Y(i,j);

        dd(i,j) = dropletDiameterB(parameters);

    end
end

%Converting diameter from metre to micrometre
dd = dd*1e6;


% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create surface
surface('Parent',axes1,'ZData',dd,'YData',Y,'XData',X,'LineStyle','none','CData',dd);
    view(axes1,[160 29.84]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%xlim([0 90])
%title('Droplet diameter as a function of fluid flow rate and surface tension')
xlabel('Fluid flow rate (m�/s)','Rotation',7)
ylabel('Fluid surface tension (N/m)','Rotation',-37)
zlabel('Droplet median diameter ({\mu}m)')
