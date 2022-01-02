clear
clc

%% Droplet median diameter 2D plots
%Parameters = [Q, ro, mu, sigma, d, I, f]
%Q is the volumetric flow rate of atomised fluid

frequencyRange = (1000:1000:2e6);
DomainSizeX = size(frequencyRange);

final_i=DomainSizeX(2);
dd = zeros(1,final_i);

%Parameters = [Q, ro, mu, sigma, d, I, f]
%Water at 25�C
%parameters = [1e-9,997,0.00089,0.0728,0,1.5e4,0];
%Methanol at 25�C
parameters = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 0];
% parameters = [1.4e-7, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 0];
% parameters = [1.4e-2, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 0];


for i=1:final_i
    parameters(7) = frequencyRange(i);
    dd(i) = dropletDiameterB(parameters);
end

%Converting diameter from metre to micrometre
dd = dd*1e6;
%Converting frequecy from Hz to kHz
frequencyRange = frequencyRange*1e-3;

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot
plot(frequencyRange,dd,'LineWidth',4);
%xlim([0 90])
% ylim([5 18])
% Create title
%title('Droplet median diameter as a function of transducer frequency')
% Create xlabel
xlabel('Transducer frequency (kHz)')
% Create ylabel
ylabel('Droplet median diameter ({\mu}m)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',20)
set(axes1,'FontSize',20,'XGrid','on','XTick',[0 200 400 600 800 1000 1200 1400 1600 1800 2000],'YGrid','on');
%drawnow; pause(1);
%set(gcf,'color','w');
%axes1.YAxis.Exponent = 3;
%axes1.XAxis.Color = 'r';
%Saving plot as a pdf
print('Atomiser_droplet_diameter_vs_frequency','-dpdf','-fillpage')
