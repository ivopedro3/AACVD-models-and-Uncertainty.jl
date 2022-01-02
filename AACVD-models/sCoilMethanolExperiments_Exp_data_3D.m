clc
clear
%clf

%% Experimental data

x0m_t1 = [1.16592 1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865];
y0m_t1 = [0 0.00162465	0.00630999	0.0139505	0.0246324	0.0378605	0.05268	0.0679156	0.0820712	0.093267	0.0998946	0.10089	0.0960041	0.0858303	0.0718629	0.0559761	0.0402178	0.0263162	0.0153551	0.00769492	0.00306199	0.000767871];

x0m_t2 = [1	1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108];
y0m_t2 = [0.00144209	0.00160115	0.00245789	0.00430279	0.00739085	0.011877	0.0177849	0.0250457	0.0335413	0.0430455	0.0531292	0.0631884	0.072502	0.080175	0.0852727	0.0869224	0.0845278	0.0779368	0.0675966	0.0545624	0.040329	0.0265492	0.0146923	0.00573451	1.93E-05];

x0m_t3 = [0.857698	1	1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416	54.1171	63.0959	73.5644	85.7698	100	116.592	135.936	158.49	184.785	215.444];
y0m_t3 = [0	0.00121504	0.00476908	0.00953218	0.015674	0.0232222	0.0319788	0.0415085	0.0512456	0.0605958	0.0688734	0.0752645	0.0790573	0.0797384	0.0770953	0.0712927	0.0629403	0.0529373	0.0424212	0.0325249	0.0241352	0.0177465	0.0134106	0.0107969	0.00935605	0.0085102	0.00779558	0.00693953	0.0058679	0.00466532	0.00347222	0.00241174	0.00155048	0.000898218	0.000433323	0.000123743	0];

x0m_t4 = [1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416];
y0m_t4 = [0.00153574	0.00188518	0.00349491	0.00666539	0.011514	0.0179446	0.0257375	0.0346377	0.0442759	0.0540886	0.0634356	0.0716302	0.0779284	0.0816001	0.0820273	0.0788344	0.0720217	0.0620668	0.0499244	0.0368897	0.0243722	0.0136194	0.00546275	0.000200072	0];

x0m_all = [x0m_t1 x0m_t2 x0m_t3 x0m_t4];
y0m_all = [y0m_t1 y0m_t2 y0m_t3 y0m_t4];



%% 2D curves

%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 7;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot

for i = 1:i_max
    plot(dd,LB_inlet_logNorm(i,:),'LineWidth',2);
end

xlim([0.0007 40])
%ylim([5 18])
% Create title
title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Probability density')
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
%set(gca,'XScale','log')
%Saving plot as a pdf
%print('Penetration_vs_Droplet_Size','-dpdf','-fillpage')

%Integral in the outlet distribution (less than one, given the loss)
%fracOUT = trapz(dd_um,ddDistr);

%plot(x2m_t1, y2m_t1,'*')
%plot(x2m_t1, y2m_t1,'.')



%% 3D plot model


%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 5.4;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end

% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

z = zeros (1,size_dd(2));
z(1,:) = 1;
%colour = [.95 .95 .95];
colour = [.4 .4 .9];

for i = 1:i_max
    %plot(dd,LB_inlet_logNorm(i,:),'LineWidth',5);

    plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',7, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.95;
    else
        colour = colour*1.05;
    end
        hold on
end

xlim([0 25])
ylim([0 .2])
zlim([0 7])
% Create title
view(axes1,[35.76 67.6]);
%view(axes1,[0 90]);
%view(axes1,[144 29.84]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)','Rotation',-18)
%xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Probability density','Rotation',35)
%ylabel('Probability density')
% Create zlabel
%zlabel('')
set(gca,'FontSize',16)
set(gca,'YTick',[.04 .08 .12 .16 .20],'ZTick',[]);

%Saving plot as a pdf
%print('Penetration_vs_Droplet_Size','-dpdf','-fillpage')

%Integral in the outlet distribution (less than one, given the loss)
%fracOUT = trapz(dd_um,ddDistr);

%plot(x2m_t1, y2m_t1,'*')
%plot(x2m_t1, y2m_t1,'.')



%% 3D plot experiment


%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 5.9;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end

% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

z = zeros (1,size_dd(2));
z(1,:) = 1;
%colour = [.95 .95 .95];
colour = [.4 .4 .9];

for i = 1:i_max
    %plot(dd,LB_inlet_logNorm(i,:),'LineWidth',5);

    plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',8, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.97;
    else
        colour = colour*1.03;
    end
        hold on
end

xlim([0 25])
ylim([0 .2])
% Create title
%view(axes1,[35.76 67.6]);
view(axes1,[0 90]);
%view(axes1,[144 29.84]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
%xlabel('Droplet diameter ({\mu}m)','Rotation',-18)
% Create ylabel
ylabel('Probability density')
%ylabel('Probability density','Rotation',35)
%zlabel('')
set(gca,'FontSize',16)
set(gca,'YTick',[.04 .08 .12 .16 .20],'ZTick',[]);


%% 3D plot two clouds


%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 7;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end

% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

z = zeros (1,size_dd(2));
z(1,:) = 1;
colour = [.95 .95 .95];

for i = 1:i_max
    %plot(dd,LB_inlet_logNorm(i,:),'LineWidth',5);

    plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',8, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.95;
    else
        colour = colour*1.05;
    end
        hold on
end



xlim([0 30])
%ylim([5 18])
% Create title
%view(axes1,[144 29.84]);
view(axes1,[0 90]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Probability density')
% Create zlabel
%zlabel('?????')
set(gca,'FontSize',16)
set(gca,'ZTick',[]);






%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 9;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end


z = zeros (1,size_dd(2));
z(1,:) = 1;
colour = [.4 .7 .5];

for i = 1:i_max
    %plot(dd,LB_inlet_logNorm(i,:),'LineWidth',5);

    plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',8, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.95;
    else
        colour = colour*1.05;
    end
        hold on
end


%% 2D plot two clouds transparency


%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 7;


i_max = 50;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end

% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

z = zeros (1,size_dd(2));
z(1,:) = 1;
%colour = [.95 .95 .95];
colour = [.3 .3 .8];


LB_inlet_logNorm=LB_inlet_logNorm*.9;
alpha = .05;
ScatterSize = 50;
for i = 1:i_max
    %scatter(dd,LB_inlet_logNorm(i,:),'LineWidth',5, ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    scatter(dd,LB_inlet_logNorm(i,:),ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);

    %plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',8, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.95;
    else
        colour = colour*1.05;
    end
        hold on
end



xlim([0 30])
%ylim([5 18])
% Create title
%view(axes1,[144 29.84]);
view(axes1,[0 90]);
%view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter ({\mu}m)')
% Create ylabel
ylabel('Probability density')
% Create zlabel
%zlabel('?????')
set(gca,'FontSize',16)
set(gca,'ZTick',[]);






%Lower bound, step size and upper bound for plotting (x axis)
LB = .01;
step = LB;
UB = 80;
dd = LB:step:UB;

size_dd = size(dd);

%Median droplet diameter
LB_inlet_medianDiameter = 9;


%i_max = 20;
LB_inlet_logNorm = zeros(i_max,size_dd(2));
LB_inlet_sigma = .4;
for i = 1:i_max
    %Log-normal distribution for the inlet droplet diameter (y axis)
    %std dev
    LB_inlet_sigma = LB_inlet_sigma + .01;

    %The median of the log-normal distribution is given by:
    LB_inlet_meadian = log(LB_inlet_medianDiameter);

    %Log-normal distribution
    LB_inlet_logNorm(i,:) = lognpdf(dd,LB_inlet_meadian,LB_inlet_sigma);
end


z = zeros (1,size_dd(2));
z(1,:) = 1;
%colour = [.4 .7 .5];
colour = [.95 .95 .95];

alpha=.01;

for i = 1:i_max
    scatter(dd,LB_inlet_logNorm(i,:),ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);

    %plot3(dd,LB_inlet_logNorm(i,:),z(1,:),'LineWidth',8, 'color', colour)
    z(1,:) = z(1,:) + .1;
    if i < i_max/2
        colour = colour*.95;
    else
        colour = colour*1.05;
    end
        hold on
end
