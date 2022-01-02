% using firstStageDryingDifferentials.m

clc
clear


T_d0 = 25+273;

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

%R_d0 = [10 15 20 30]
for R_d0 = 1:10:50
    R_d0 = R_d0*1e-6;

    TimeDomain = [0 5];
    IC1 = R_d0;
    IC2 = T_d0;
    IC = [IC1 IC2];
    [IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);


    % Create plot
    DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
    %DVsol(:,1)=DVsol(:,1).*DVsol(:,1) %square of the radius drops linearly with time
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
    hold on

end

%% Diameter and Mass
% using firstStageDryingDifferentials.m

clc
clear

T_d0 = 25+273;

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

R_d0 = 800;
R_d0 = R_d0*1e-6;

TimeDomain = [0 100];
IC1 = R_d0;
IC2 = T_d0;
IC = [IC1 IC2];
[IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);

% Create plot
DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
%DVsol(:,1)=DVsol(:,1).*DVsol(:,1) %square of the radius drops linearly with time
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
hold on

figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');
% Create plot
DVsol(:,1) = DVsol(:,1)*1e-6; %Micrometers back to meters
ro_dw = 792;
m_d = 8/6 * pi() * ro_dw * (DVsol(:,1).^3);
m_d = m_d * 1e6; %kg to mg
plot(IVsol, m_d,'LineWidth',2)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Time (s)') %({\mu}m)
% Create ylabel
ylabel('Droplet mass (mg)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
hold on

figure3 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes3 = axes('Parent',figure3);
hold(axes3,'on');
% Create plot
plot(IVsol, DVsol(:,2),'LineWidth',2)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Time (s)') %({\mu}m)
% Create ylabel
ylabel('Temperature (K)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes3,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
hold on



%% Converting time to distance travelled before hitting the glass
% using firstStageDryingDifferentials.m

clc
clear

T_d0 = 25+273;

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

%R_d0 = [10 15 20 30][0.1 1 5 10] [2 10 15 20] [5.5 10.5 15.5 20.5]
for R_d0 = [1.3 4.6 6.6 10.5]
    R_d0 = R_d0*1e-6;

    TimeDomain = [0 5];
    IC1 = R_d0;
    IC2 = T_d0;
    IC = [IC1 IC2];
    [IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);

    IVsol = (IVsol*0.5)*100; %time to distance (v = 0.5 m/s). 100 converts from m to cm

    % Create plot
    DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
    %DVsol(:,1)=DVsol(:,1).*DVsol(:,1) %square of the radius drops linearly with time
    plot(IVsol, DVsol(:,1),'LineWidth',4)
    % Create title
    %title('Droplet size distribution: atomiser output')
    % Create xlabel
    xlabel('Distance travelled [cm]')
    % Create ylabel
    ylabel('Droplet radius [{\mu}m]')
    %axis([0 7 -.01 .01])
    set(gca,'FontSize',21)
    set(axes1,'FontSize',21,'XGrid','on','YGrid','on');
    xlim([0.3 30])
    hold on

end


%% Uncertainty plot v1
% using firstStageDryingDifferentials.m

clc
clear

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

R_d0 = 10*1e-6;
TimeDomain = [0 0.1655];
IC1 = R_d0;
IC2 = 25+273;
IC = [IC1 IC2];
[IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);
DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
IVsol = (IVsol*0.5)*100; %time to distance (v = 0.5 m/s). 100 converts from m to cm

vectorSize = size(DVsol);

colour = [.95 .95 .95];

ScatterSize = 1e-5;
begin = 1;

for i = 1:(vectorSize(1)-begin*1)
    ScatterSize = ScatterSize+(i+2)^(1);
    scatter(IVsol(i+begin), DVsol(i+begin,1),ScatterSize,colour,'o', 'filled')
    hold on
end

ending = vectorSize(1)-begin*5;
plot(IVsol(begin:ending), DVsol(begin:ending,1),'LineWidth',2)
xlabel('Distance [cm]')
ylabel('Droplet radius [({\mu}m]')
xlim([0 30])
% ylim([0 10])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');

%% Uncertainty plot v2
% using firstStageDryingDifferentials.m

clc
clear

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

R_d0 = 5.2*1e-6;
TimeDomain = [0 1];
IC1 = R_d0;
IC2 = 25+273;
IC = [IC1 IC2];
[IVsol, DVsol] = ode23('firstStageDryingDifferentials', TimeDomain, IC);
DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
IVsol = (IVsol*0.5)*100; %time to distance (v = 0.5 m/s). 100 converts from m to cm

vectorSize = size(DVsol);

colour = [.95 .95 .95];

ScatterSize = 1e-5;
begin = 1;
LineWidth = 5;

i = 10;
jump = 3;
while i < vectorSize(1)-jump
    LineWidth = LineWidth + 1.5;
    plot(IVsol(i:i+jump), DVsol(i:i+jump,1),'color', [.95 .95 .95],'LineWidth',LineWidth)
    hold on
    i = i+jump;
end

plot(IVsol(10:vectorSize(1)), DVsol(10:vectorSize(1),1),'k','LineWidth',2)

xlabel('Distance [cm]')
ylabel('Droplet radius [{\mu}m]')
xlim([0 30])
% ylim([0 10])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');

%% Diameter and Mass
% using dropletDryingDifferentials.m

clc
clear

T_d0 = 25+273;

R_d0 = 50;
R_d0 = R_d0*1e-6;

TimeDomain = [0 0.96];
IC1 = R_d0;
IC2 = T_d0;
IC = [IC1 IC2];
options = odeset('NonNegative',1);
[IVsol, DVsol] = ode23('dropletDryingDifferentials', TimeDomain, IC, options);

%Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot
DVsol(:,1) = DVsol(:,1)*1e6; %meters to micrometers
plot(IVsol, DVsol(:,1),'LineWidth',2)
% Create xlabel
xlabel('Time [s]')
% Create ylabel
ylabel('Droplet radius [{\mu}m]')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
hold on

figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');
% Create plot
DVsol(:,1) = DVsol(:,1)*1e-6; %Micrometers back to meters
ro_dw = 792;
m_d = 8/6 * pi() * ro_dw * (DVsol(:,1).^3);
m_d = m_d * 1e6; %kg to mg
plot(IVsol, m_d,'LineWidth',2)
% Create xlabel
xlabel('Time [s]') %({\mu}m)
% Create ylabel
ylabel('Droplet mass [mg]')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes2,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])

figure3 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%Create axes
axes3 = axes('Parent',figure3);
hold(axes3,'on');
% Create plot
plot(IVsol, DVsol(:,2),'LineWidth',2)
% Create xlabel
xlabel('Time [s]')
% Create ylabel
ylabel('Temperature [K]')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes3,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
