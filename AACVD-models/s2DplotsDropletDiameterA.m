clear
clc

%% Droplet median diameter 2D plots
%Parameters = [sigma, ro, f]

frequencyRange = (5e4:1000:2e6);
DomainSizeX = size(frequencyRange);

final_i=DomainSizeX(2);
dd = zeros(1,final_i);

%Methanol at 25�C
%Parameters = [sigma, ro, f]
parameters = [2.2e-2, 786.6, 0];


for i=1:final_i
    parameters(3) = frequencyRange(i);
    dd(i) = dropletDiameterA(parameters);
end

%Converting diameter from metre to micrometre
dd = dd*1e6;
%Converting frequecy from Hz to kHz
frequencyRange = frequencyRange*1e-3;




% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create plot
plot(frequencyRange,dd,'LineWidth',5,'Color','k');
%xlim([0 90])
% ylim([5 18])
% Create title
%title('Droplet median diameter as a function of transducer frequency')
% Create xlabel
xlabel('Ultrasonic atomiser frequency [kHz]')
xticks([0 200 400 600 800 1000 1200 1400 1600 1800 2000])
% Create ylabel
ylabel('Droplet median diameter [{\mu}m]')
%axis([0 7 -.01 .01])
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

%drawnow; pause(1);
%set(gcf,'color','w');
%axes1.YAxis.Exponent = 3;
%axes1.XAxis.Color = 'r';
%Saving plot as a pdf
% print('Atomiser_droplet_diameter_vs_frequency','-dpdf','-fillpage')
