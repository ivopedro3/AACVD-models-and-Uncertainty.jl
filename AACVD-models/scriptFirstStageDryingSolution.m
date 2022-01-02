clc
clear

R_d0 = 20e-6;

T_d0 = 25+273;

TimeDomain = [0 .5];
IC1 = R_d0;
IC2 = T_d0;


IC = [IC1 IC2];

[IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);



% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot
DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
plot(IVsol, DVsol(:,1),'LineWidth',2)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Time (s)') %({\mu}m)
% Create ylabel
ylabel('Droplet radius ({\mu}m)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])


% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes1,'on');
% Create plot

% %Limiting by boiling point
% size = size(DVsol);
DVsol(:,2) = DVsol(:,2) - 273.15; %K to �C
% for i=1:(size(1))
%
%     if DVsol(i,2) > 64.7
%         DVsol(i,2) = 64.7;
%     end
% end

plot(IVsol, DVsol(:,2),'LineWidth',2)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Time (s)')
% Create ylabel
ylabel('Droplet temperature (�C)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
