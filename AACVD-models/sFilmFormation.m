%% Exact

V = 480e-6;
A = 120e-4;
F_in = 1;
F_out = 1;
C_Ain = 0.1;
C_Bin = 0;
C_Cin = 0;
k1 = 2.7e14*exp(-57000/8.314/700);
k2 = 1.9e2;
k3 = 5.4e-2;

parameters = [V, A, F_in, F_out, C_Ain, C_Bin, C_Cin, k1, k2, k3];

filmFormation(parameters)

%% ODE45

clc
clear

%Initial conditions
[parameters, IC] = filmFormationODE45parameters();
C0 = [IC(1) IC(2) IC(3) IC(4) IC(5) IC(6) IC(7)];
tspan = [0 .1];
%Solving
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
options = odeset('RelTol',1e-2,'Stats','on','OutputFcn',@odeplot);
[t,C] = ode45(@filmFormationODE45, tspan, C0, options );
legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')
%set(figure2,'LineWidth',3);

%legend('C_A_vap','C_A_sol', 'C_B_vap','C_B_sol', 'C_C_vap','C_C_sol', 'C_D_sol', 'Location','best')
%Future work: return steady state concentrations
%concentrations = [];



%% ODE23

clc
clear

[parameters, IC] = filmFormationODE45parameters();
C0 = [IC(1) IC(2) IC(3) IC(4) IC(5) IC(6) IC(7)];
tspan = [0 0.001];
[IVsol, DVsol] = ode23('filmFormationODE45', tspan , C0);


%% ODE45 Full model

clc
clear

%Initial conditions
[parameters, IC] = filmFormationFullODE45parameters(0);
%C0 = [IC(1) IC(2) IC(3) IC(4) IC(5) IC(6) IC(7)];
tspan = [0 5];
%Solving
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
options = odeset('RelTol',1e-2,'Stats','on','OutputFcn',@odeplot);

% options = odeset('RelTol',1e-2,'Stats','on');
[t,C] = ode45(@filmFormationFullODE45, tspan, IC, options );

figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
plot(t,C, 'LineWidth',5)
legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')





%% Uncertain film thickness
%solve ODEs for varying mass transfer and reaction constants!

% v = 0.16;
% w = 3.2;
% x_beam = 0.2;
% volumeReactor = 3.2*0.03*.3;
% filmDensity = 5e3;
% filmThickness(t, C, v, w, x_beam, volumeReactor, filmDensity)


sampleSize = 100;
numberOfVariables = 3;
sample = lhsdesign(sampleSize,numberOfVariables);

v = [0.15 0.25];
w = 3.2;
x_beam = [0.25 0.8];
volumeReactor = 0.021;
filmDensity = [50e6 200e6]; %filmDensity [=] mol/m3


parameters = sample.*[v(2) x_beam(2) filmDensity(2)] - (sample-1).*[v(1) x_beam(1) filmDensity(1)];

tau = zeros(1,sampleSize);

for i = 1:sampleSize
    tau(i) = filmThickness(t, C, parameters(i,1), w, parameters(i,2),volumeReactor, parameters(i,3));
end

% Create plot figure
%figure1 = figure('PaperOrientation','portrait','Color',[1 1 1]);
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
%ylim([5e-6 10e-6])

FontSize = 11.5;
% %Conver film thickness to micrometers
% tau = tau*1e6;
subplot(1,3,1)
scatter(parameters(:,1),tau, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Glass flow speed (m/s)')
ylabel('Film thickness (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
% xlim([.1e-11 1e-11])
% ylim([5e-6 10e-6])

subplot(1,3,2)
scatter(parameters(:,2),tau, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Deposition length (m)')
ylabel('Film thickness (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
% ylim([5e-6 10e-6])

subplot(1,3,3)
scatter(parameters(:,3),tau, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Film density (kg/m�)')
ylabel('Film thickness (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
% xlim([3e-4 11e-4])
% ylim([5e-6 10e-6])


%% Case 1/4 - Kinetics limited and slow
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [10,0,0,0,0,0,0];
tspan = [0 10];


% %Fast kinetics
% k_min = [27 190 0.054]*1;
% k_max = k_min*1.01;
%
% h_m_min = [1 9 39]*1;
% h_m_max = h_m_min*1.01;

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.001;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.01;
h_m_min = [12 9 11]*frac2;
h_m_max = h_m_min*1.01;

% k_min = [27 190 0.054]*.001;
% k_max = k_min*10;
%
% h_m_min = [170 9 39];
% h_m_max = h_m_min*10;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeff, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    plot(t,C, 'LineWidth',5)
    legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')
    xlabel('Time (s)')
    ylabel('Molar concentration (mol/m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end


%% Case 2/4 - Kinetics limited and fast
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [0,0,0,0,0,0,0];
tspan = [0 10];


% %Fast kinetics
% k_min = [27 190 0.054]*1;
% k_max = k_min*1.01;
%
% h_m_min = [1 9 39]*1;
% h_m_max = h_m_min*1.01;

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.01;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.01;
h_m_min = [12 9 11]*frac2;
h_m_max = h_m_min*1.01;

% k_min = [27 190 0.054]*.001;
% k_max = k_min*10;
%
% h_m_min = [170 9 39];
% h_m_max = h_m_min*10;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeff, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    plot(t,C, 'LineWidth',5)
    legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')
    xlabel('Time (s)')
    ylabel('Molar concentration (mol/m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end

%% Case 3/4 - Mass transfer limited and slow
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [10,0,0,0,0,0,0];
tspan = [0 10];


% %Fast kinetics
% k_min = [27 190 0.054]*1;
% k_max = k_min*1.01;
%
% h_m_min = [1 9 39]*1;
% h_m_max = h_m_min*1.01;

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.1;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.0001;
h_m_min = [12 9 11]*frac2;
h_m_max = h_m_min*1.01;

% k_min = [27 190 0.054]*.001;
% k_max = k_min*10;
%
% h_m_min = [170 9 39];
% h_m_max = h_m_min*10;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeff, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    plot(t,C, 'LineWidth',5)
    legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')
    xlabel('Time (s)')
    ylabel('Molar concentration (mol/m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end

%% Case 4/4 - Mass transfer limited and fast
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [10,0,0,0,0,0,0];
tspan = [0 10];


% %Fast kinetics
% k_min = [27 190 0.054]*1;
% k_max = k_min*1.01;
%
% h_m_min = [1 9 39]*1;
% h_m_max = h_m_min*1.01;

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.1;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.001;
h_m_min = [12 9 11]*frac2;
h_m_max = h_m_min*1.01;

% k_min = [27 190 0.054]*.001;
% k_max = k_min*10;
%
% h_m_min = [170 9 39];
% h_m_max = h_m_min*10;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeff, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    plot(t,C, 'LineWidth',5)
    legend('C_A_v','C_A_s', 'C_B_v','C_B_s', 'C_C_v','C_C_s', 'C_D_s')
    xlabel('Time (s)')
    ylabel('Molar concentration (mol/m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end


%% Film thickness and molar concentration relation

V = 0.021;
ro = 68796;
w = 3.2;
v = 0.25;

%tau = zeros(length(C(:,7),1));
tau = (C(:,7) * V / (ro * w * v))./t * 1e6;
%tau = (C(:,7) * V / (ro * w * v)) * 1e6;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
plot(C(:,7), tau, 'LineWidth',5)
xlabel('Molar concentration (mol/m�)')
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')



%% Film thickness with time

%v = 0.25;
v = 0.025;
w = 3.2;
x_beam = 0.8;
volumeReactor = 0.021;
filmDensity = 68796; %filmDensity [=] mol/m3

filmThicknessGrowthWithTime(t, C, v, w, x_beam,volumeReactor, filmDensity);

%% Case 1/4 - Mass transfer limited and fast - n_A ADE!!! - two-axes plot
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [0,0,0,0,0,0,0,0];
tspan = [0 1];

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.001;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.0001;
h_m_min = [12 9 30 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainADECoeffMolar, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    yyaxis left
    p = plot(t,C(:,1:8), 'LineWidth',5);
    %hold on
    p(1).Marker = '*';
    p(1).Color = 'cyan';
    p(5).Marker = '+';
    p(5).Color = 'b';
    p(8).Marker = 'd';
    p(8).Color = 'green';
    ylabel('Amount of substance (mol)')


%     tau = zeros(length(C),1);
%     tau = C(:,9)*0.15*10*3.2;
%     yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
% %     p = plot(t,tau, 'LineWidth',5);
%     p(1).Marker = 'v';
    legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
    xlabel('Time (s)')
    ylabel('Film volume (m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end

%% Case 1/4 - Mass transfer limited and fast - n_A ODEs - one-axis plot
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [10,0,0,0,0,0,0,0,1e-6];
tspan = [0 0.10];

% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.1;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.001;
h_m_min = [12 9 11 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeffMolar, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    p = plot(t,C, 'LineWidth',5);
    p(1).Marker = '*';
    p(5).Marker = '+';
    p(8).Marker = 'd';
    p(9).Marker = 'v';
    legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
    xlabel('Time (s)')
    ylabel('Molar concentration (mol/m�)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')
end

%% Case 1/4 - Mass transfer limited and fast - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [0,0,0,0,0,0,0,0,1e-6];
tspan = [0 1];
%frac = 0.01 and frac2 = 0.001 work!!
% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.01;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.001;
h_m_min = [12 9 30 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainCoeffMolar, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    yyaxis left
    p = plot(t,C(:,1:8), 'LineWidth',5);
    %hold on
    p(1).Marker = '*';
    p(1).Color = 'cyan';
    p(5).Marker = '+';
    p(5).Color = 'b';
    p(8).Marker = 'd';
    p(8).Color = 'green';
    ylabel('Amount of substance (mol)')

%     C(:,9) = C(:,9) - IC(9);
    tau = zeros(length(C),1);
    tau = (C(:,9)*0.15*10*3.2)*1e6;
    ylim([0 0.15])
    yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
    p = plot(t,tau, 'LineWidth',5);
    p(1).Marker = 'v';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
    legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', '{\tau}')
    xlabel('Time (s)')
%     ylabel('Film volume (m�)')
    ylim([0 3])
    ylabel('Film thickness ({\mu}m)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

end

%% Case 1/4 - Mass transfer limited and fast - V2 - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
%If the reactor is starting
%IC = [0,0,0,0,0,0,0];
% %If the reactor is already operating (reactants already inside and ready). This implies that there is already IC(1)*V mol of A inside the reactor.
IC = [0,0,0,0,0,0,0,0,0];
tspan = [0 1];
%frac = 0.01 and frac2 = 0.001 work!!
% A/V = 3.5 (k2 and k3 should be about A/V times less than k1, since definition and units are different)
frac = 0.01;
%Slow kinetics
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

frac2 = 0.001;
h_m_min = [12 9 30 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

for i=1:1

    coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

    fileID = fopen('coeffs.txt','w');
    fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
    fclose(fileID);


    %Solving
    options = odeset('RelTol',1e-2,'Stats','on');
    % options = odeset('RelTol',1e-2,'Stats','on');
    [t,C] = ode45(@filmFormationFullODE45uncertainV2CoeffMolar, tspan, IC, options);

    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    yyaxis left
    p = plot(t,C(:,1:8), 'LineWidth',5);
    %hold on
    p(1).Marker = '*';
    p(1).Color = 'cyan';
    p(5).Marker = '+';
    p(5).Color = 'b';
    p(8).Marker = 'd';
    p(8).Color = 'green';
    ylabel('Amount of substance (mol)')

%     C(:,9) = C(:,9) - IC(9);
    tau = zeros(length(C),1);
    tau = (C(:,9)*0.15*10*3.2)*1e6;
%     ylim([0 0.15])
    yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
    p = plot(t,tau, 'LineWidth',5);
    p(1).Marker = 'v';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
    legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', '{\tau}')
    xlabel('Time (s)')
%     ylabel('Film volume (m�)')
%     ylim([0 3])
    ylabel('Film thickness ({\mu}m)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

end


%% Case 1/4 - Kinetics limited and slow - V3 - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
IC = [0,0,0,0,0,0,0,0,0];
t_end = 5;
tspan = [0 t_end];

%Kinetics
frac = 0.001;
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20 50 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
% options1 = odeset('RelTol',1e-3,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
[t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);


%% Case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
% IC = [0,0,0,0,0,0,0,0,0];
IC = [1.03,0,0,0,0,0,0,0,0];
t_end = 5;
% t_end = 10;
tspan = [0 t_end];

%Kinetics
frac = 0.01;
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20 50 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
% options1 = odeset('RelTol',1e-3,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
[t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);

%% Case 3/4 - Mass transfer limited and slow - V3 - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
IC = [0,0,0,0,0,0,0,0,0];
t_end = 5;
tspan = [0 t_end];

%Kinetics
frac = 0.1;
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.0001;
h_m_min = [33 20 50 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
% options1 = odeset('RelTol',1e-3,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
[t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);

%% Case 4/4 - Mass transfer limited and fast - V3 - n_A ODEs - two-axes plot
clc
clear

%Initial conditions
IC = [0,0,0,0,0,0,0,0,0];
t_end = 5;
tspan = [0 t_end];

%Kinetics
frac = 0.1;
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.001;
h_m_min = [33 20 50 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
% options1 = odeset('RelTol',1e-3,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
[t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);

%% Case 1/2 - Less rigorous - Glass and gas flowing in the same direction (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a first approximation, since it uses the V3 ODE system (not updating the concentrations for each control volume after discretising the whole volume)
clc
clear

%Kinetics
frac = 0.01;
k_min = [27 8 7]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20 50 0]*frac2;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);


%Initial conditions
% IC = [0,0,0,0,0,0,0,0,0];
IC = [1.03,0,0,0,0,0,0,0,0];
%IC = [1.03,5.03544259542916e-06,0,1.74019501901418e-06,0,1.13320976000295e-05,0,0.832966706854815,1.21077658484681e-05];
% distJump = 0.2;
distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;
end

%% Case 2/2 - Less rigorous - Glass and gas flowing in opposite directions (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a first approximation, since it uses the V3 ODE system (not updating the concentrations for each control volume after discretising the whole volume)

IC = [C_x(numberPoints,1:7),0, 0];
C_x2 = zeros(numberPoints,2);
x2 = zeros(numberPoints,1);
x2(1)=0;
C_x2(1,1)=IC(1);
C_x2(1,2)=IC(8);
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV3CoeffMolar, tspan, IC, options2);
    C_x2(i,1) = C(length(t),1);
    C_x2(i,2) = C(length(t),8);
    x2(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

%% Plotting results

%Glass speed (m/s)
v = 0.15;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(t,C(:,1:8), 'LineWidth',5);
%hold on
%VAPOUR PHASE
%p(1).Marker = '*';
p(1).Color = 'green';
p(1).LineStyle = '--';
p(3).Marker = '.';
p(3).Color = 'cyan';
p(3).LineStyle = ':';
p(5).Marker = '.';
p(5).Color = 'y';
p(5).LineStyle = '-.';
p(7).Marker = '.';
p(7).Color = 'red';
p(7).LineStyle = 'none';

%solid PHASE
p(2).Marker = '.';
p(2).Color = 'red';
p(2).LineStyle = 'none';
p(4).Marker = '.';
p(4).Color = 'red';
p(4).LineStyle = 'none';
p(6).Marker = '.';
p(6).Color = 'red';
p(6).LineStyle = 'none';
%p(8).Marker = 'd';
p(8).Color = 'k';
ylabel('Amount of substance (mol)')

%     C(:,9) = C(:,9) - IC(9);
%     tau = zeros(length(C),1);
tau = (C(:,9)/(w*v*t_end))*1e6;
ylim([0 .9])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(t,tau, 'LineWidth',5);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', '{\tau}')
xlabel('Time (s)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

%% Plotting vapour results + film

%Glass speed (m/s)
v = 0.15;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(t,C(:,1), t,C(:,3), t,C(:,5), t,C(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

tau = (C(:,9)/(w*v*t_end))*1e6;
xlim([0 5])
ylim([0 2])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(t,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('n_A_v', 'n_B_v','n_C_v','n_D_s', '{\tau}')
xlabel('Time (s)')
%     ylabel('Film volume (m�)')
ylim([0 8])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

%% Plotting n_A and n_D results only. Huge simplification For different distributor beam layouts and as a function of distance from the beam centre
%Huge simplification: the time and space will have similar plots (the code below shows me how it looks like, but the numerical values are imprecise)
x = t*1.2/5 - 0.6;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
p = plot(x,C(:,1), x,C(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
p(2).Marker = '.';
p(2).Color = 'black';
%p(2).LineStyle = '-';
xlabel('Distance (m)')
ylabel('Amount of substance (mol)')
xlim([-0.6 0.6])
ylim([0 1.1])
legend('n_A_v', 'n_D_s')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Plotting solid results

    figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
%     p2 = plot(t,C(:,2),t,C(:,4),t,C(:,6),t,C(:,8), 'LineWidth',5);
    p2 = plot(t,C(:,2),t,C(:,4),t,C(:,6), 'LineWidth',5);
    xlabel('Time (s)')
    ylabel('Amount of substance (mol)')
%     legend('n_A_s', 'n_B_s', 'n_C_s', 'n_D_s')
    legend('n_A_s', 'n_B_s', 'n_C_s')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 1/3 - More rigorous - Glass and gas flowing in the same direction (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)

clc
clear

%Kinetics
%frac = 0.1; %really fast!
% frac = 0.05;
% frac = 0.025;
frac = 0.015;
%frac = 0.9; %really really fast!
% frac = 0.01; %same sating for the case 2/4 - Kinetics limited and fast - V3 - n_A ODEs
% k_min = [27*3.7 8*0.63 7*0.63]*frac;
% k_min = [27 8 7]*frac;
% k_min = [27 8/50*3 7/50]*frac;
% k_min = [27 8/50 7/50]*frac;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
% h_m_min = [33 20*30 50 0]*frac2/50;
% h_m_min = [33 20 50 0]*frac2;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);


%Initial conditions
% IC = [0,0,0,0,0,0,0,0,0];
% IC = [1.03,0,0,0,0,0,0,0,0];
%IC = [1.152,0,0,0,0,0,0,0,0]; %C_A_in = 15 mol/m3
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3
% IC = [3.304,0,0,0,0,0,0,0,0]; %C_A_in = 30 mol/m3
%IC = [1.03,5.03544259542916e-06,0,1.74019501901418e-06,0,1.13320976000295e-05,0,0.832966706854815,1.21077658484681e-05];
% distJump = 0.2;
distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;


fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

%% Plotting all gases and n_D results - Case 1/3
%Discretised volumes!

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x(:,1:8) = C_x(:,1:8)/numberPoints;

x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x(:,1), x_centre,C_x(:,3), x_centre,C_x(:,5), x_centre,C_x(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

%% Case 2/3 - More rigorous - Glass and gas flowing in opposite directions (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Run case 1/3 first!!! Then run this one, then plot results.

clc
clear

%Kinetics
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions

IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;


fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x(numberPoints,1:7),0, 0];
C_x2 = zeros(numberPoints,9);
x2 = zeros(numberPoints,1);
x2(1)=0;
C_x2(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x2(i,j) = C(length(t),j);
    end
    x2(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

%% Plotting all gases and n_D results - Case 2/3

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x2(:,1:8) = C_x2(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x2(:,1), x_centre,C_x2(:,3), x_centre,C_x2(:,5), x_centre,C_x2(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x2(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

%% Case 3/3a - More rigorous - Glass and gas flowing in mixed directions (input gas in the middle) (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case a - assumption same amount of material going both directions

clc
clear

%Kinetics
% frac = 0.025;
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5/2; %five seconds total (5/2 for each half)
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump)*2 + 1;
middleNumberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x3RHS = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3RHS(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;
for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3RHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end


IC = [C_x3RHS(numberPoints,1:7),0, 0];
C_x3LHS = zeros(numberPoints,9);

x(1)=0;
C_x3LHS(1,:)=IC;
i=2;

for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3LHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x3RHS(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x3RHS(:,8) = C_x3RHS(:,8) + C_x3LHS(middleNumberPoints,8);
C_x3RHS(:,9) = C_x3RHS(:,9) + C_x3LHS(middleNumberPoints,9);

C_x3 = C_x3RHS;
for i=2:middleNumberPoints
    C_x3(i-1,:) = C_x3LHS(i,:);
end


%C_x3(middleNumberPoints+1) =

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x2 = C_x2/numberPoints;



%% Plotting all gases and n_D results - Case 3/3a

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x3(:,1:8) = C_x3(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x3(:,1), x_centre,C_x3(:,3), x_centre,C_x3(:,5), x_centre,C_x3(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x3(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 3/3b - More rigorous - Glass and gas flowing in mixed directions (input gas in the middle) (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case b - more material will go in direction of the glass

clc
clear

%Kinetics
% frac = 0.025;
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
equalSplitIC = .5*[0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3 (half for each side)

asymmetryFrac = .05;
asymmIC = equalSplitIC*(1+asymmetryFrac);
IC = asymmIC;

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5/2; %five seconds total (5/2 for each half)
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump)*2 + 1;
middleNumberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x3RHS = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3RHS(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;
for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3RHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = 2*equalSplitIC - asymmIC;
fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x3temp = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3temp(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;

for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3temp(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x3temp(numberPoints,1:7),0, 0];
C_x3LHS = zeros(numberPoints,9);

x(1)=0;
C_x3LHS(1,:)=IC;
i=2;

for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV4CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3LHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x3temp(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x3RHS(:,8) = C_x3RHS(:,8) + C_x3LHS(middleNumberPoints,8);
C_x3RHS(:,9) = C_x3RHS(:,9) + C_x3LHS(middleNumberPoints,9);

C_x3 = C_x3RHS;
for i=2:middleNumberPoints
    C_x3(i-1,:) = C_x3LHS(i,:);
end


%C_x3(middleNumberPoints+1) =

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x2 = C_x2/numberPoints;



%% Plotting all gases and n_D results - Case 3/3b

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x3(:,1:8) = C_x3(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x3(:,1), x_centre,C_x3(:,3), x_centre,C_x3(:,5), x_centre,C_x3(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x3(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
% ylim([0 0.004])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
% ylim([0 2])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')



%% Case 3/3c - More rigorous - Glass and gas flowing in mixed directions (input gas in the middle) (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case c - more material will go in direction of the glass and the reaction volume is corrected (half the reaction volume)

clc
clear

%Kinetics
% frac = 0.025;
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
equalSplitIC = .5*[0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3 (half for each side)

asymmetryFrac = .05;
asymmIC = equalSplitIC*(1+asymmetryFrac);
IC = asymmIC;

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5/2; %five seconds total (5/2 for each half)
t_end = distJump/glassSpeed;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump)*2 + 1;
middleNumberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x3RHS = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3RHS(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;
for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV5CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3RHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = 2*equalSplitIC - asymmIC;
fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x3temp = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3temp(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;

for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV5CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3temp(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;


    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x3temp(numberPoints,1:7),0, 0];
C_x3LHS = zeros(numberPoints,9);

x(1)=0;
C_x3LHS(1,:)=IC;
i=2;

for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV5CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3LHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x3temp(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x3RHS(:,8) = C_x3RHS(:,8) + C_x3LHS(middleNumberPoints,8);
C_x3RHS(:,9) = C_x3RHS(:,9) + C_x3LHS(middleNumberPoints,9);

C_x3 = C_x3RHS;
for i=2:middleNumberPoints
    C_x3(i-1,:) = C_x3LHS(i,:);
end


%C_x3(middleNumberPoints+1) =

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x2 = C_x2/numberPoints;



%% Plotting all gases and n_D results - Case 3/3c

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x3(:,1:8) = C_x3(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x3(:,1), x_centre,C_x3(:,3), x_centre,C_x3(:,5), x_centre,C_x3(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x3(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
% ylim([0 0.004])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
% ylim([0 2])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')



%% Case 3/3d - More rigorous - Glass and gas flowing in mixed directions (input gas in the middle) (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case d -

clc
clear

%Kinetics
% frac = 0.025;
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
equalSplitIC = .5*[0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3 (half for each side)
% equalSplitIC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3 (half for each side)

asymmetryFrac = .05;
asymmIC = equalSplitIC*(1+asymmetryFrac);
IC = asymmIC;

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5/2; %five seconds total (5/2 for each half)
t_end = distJump/glassSpeed;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump)*2 + 1;
middleNumberPoints = round(totalLength/distJump) + 1;


C_x3RHS = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3RHS(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;
for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV6CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3RHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

end

IC = 2*equalSplitIC - asymmIC;


C_x3temp = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3temp(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;

for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV6CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3temp(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

end

IC = [C_x3temp(numberPoints,1:7),0, 0];
C_x3LHS = zeros(numberPoints,9);

x(1)=0;
C_x3LHS(1,:)=IC;
i=2;

for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV6CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3LHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x3temp(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x3RHS(:,8) = C_x3RHS(:,8) + C_x3LHS(middleNumberPoints,8);
C_x3RHS(:,9) = C_x3RHS(:,9) + C_x3LHS(middleNumberPoints,9);

C_x3 = C_x3RHS;
for i=2:middleNumberPoints
    C_x3(i-1,:) = C_x3LHS(i,:);
end


%C_x3(middleNumberPoints+1) =

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x2 = C_x2/numberPoints;



%% Plotting all gases and n_D results - Case 3/3d

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x3(:,1:8) = C_x3(:,1:8)/numberPoints;
C_x3(:,7:8) = C_x3(:,7:8)/numberPoints;
C_x3(:,1:6) = C_x3(:,1:6)/(numberPoints/2);

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x3(:,1), x_centre,C_x3(:,3), x_centre,C_x3(:,5), x_centre,C_x3(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x3(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
% ylim([0 0.004])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
% ylim([0 2])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 1/3b (using strategy of Case 3/3d) - More rigorous - Glass and gas flowing in the same direction (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
clc
clear

%Kinetics
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3
distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);
end

%% Plotting all gases and n_D results - Case 1/3b (using strategy of Case 3/3d)
%Discretised volumes!

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x(:,1:8) = C_x(:,1:8)/numberPoints;

x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x(:,1), x_centre,C_x(:,3), x_centre,C_x(:,5), x_centre,C_x(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 1/3c (using strategy of Case 3/3d) - More rigorous - Glass and gas flowing in the same direction (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case c: double the gas flow rate (all the other cases have the gas velocity = glass velocity)

clc
clear

%Kinetics
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3
distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds (time taken for a glass section completely cross the deposition site)
t_end = distJump/glassSpeed/2; %divided by two because: gas flow rate was doubled, therefore, residence time is halved
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);
end

%% Plotting all gases and n_D results - Case 1/3c (using strategy of Case 3/3d)
%Discretised volumes!
%Case c: double the gas flow rate (all the other cases have the gas velocity = glass velocity)

C_x(:,8:9) = C_x(:,8:9)*2; %(double amount of reactants circulated-gas flow was doubled-, therefore, the products are doubled)

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x(:,1:8) = C_x(:,1:8)/numberPoints;

x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x(:,1), x_centre,C_x(:,3), x_centre,C_x(:,5), x_centre,C_x(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %time taken for a glass section completely cross the deposition site
tau = (C_x(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 2/3b (using strategy of Case 3/3d) - More rigorous - Glass and gas flowing in opposite directions (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)

clc
clear

%Kinetics
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x(numberPoints,1:7),0, 0];
C_x2 = zeros(numberPoints,9);
x2 = zeros(numberPoints,1);
x2(1)=0;
C_x2(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x2(i,j) = C(length(t),j);
    end
    x2(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

%% Plotting all gases and n_D results - Case 2/3b (using strategy of Case 3/3d)

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x2(:,1:8) = C_x2(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x2(:,1), x_centre,C_x2(:,3), x_centre,C_x2(:,5), x_centre,C_x2(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x2(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Case 2/3c (using strategy of Case 3/3d) - More rigorous - Glass and gas flowing in opposite directions (Spatial solutions for case 2/4 - Kinetics limited and fast - V3 - n_A ODEs - two-axes plot)
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)
%Case 2/3c: using as a starting point the last point of the case 1/3 (parallel flow) instead of using all points. This may require trial and error to end up with the correct ractant concentration of the feed.
%Works beautifully! However, it needs constraints to ensure that only A will be present in the RHSide.

clc
clear

%Kinetics
frac = 0.015;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
frac2 = 0.01;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3

distJump = 0.04;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x(numberPoints,1:6),0,0,0];
C_x2 = zeros(numberPoints,9);
x2 = zeros(numberPoints,1);
x2(1)=0;
C_x2(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7CoeffMolar, tspan, IC, options2);
%     for j=1:9
%         C_x2(i,j) = C(length(t),j);
%     end
    x2(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    %IC = [C_x(numberPoints+1-i,1:7), C(length(t),8:9)];
    IC(1:6) = IC(1:6) + (IC(1:6) - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6)]);
%     for i2=1:6
%         if IC(i2)<0
%             IC(i2)=0;
%         end
%     end
    IC(7:9) = [C(length(t),7),C(length(t),8),C(length(t),9)];
    C_x2(i,:) = IC;
    i = i+1;
end

%% Plotting all gases and n_D results - Case 2/3c (using strategy of Case 3/3d)

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
% C_x2(:,1:8) = C_x2(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x2(:,1), x_centre,C_x2(:,3), x_centre,C_x2(:,5), x_centre,C_x2(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

t_end=5; %for now
tau = (C_x2(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
% ylim([0 0.012])
ylim([0 1.5])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')



%% Plotting all gases and n_D results CONCENTRATION
%Discretised volumes!

x_centre = x -.6;
V = 3.2 * 0.023 * 0.28 * 1000;%dm3 or L

%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x(:,1)/V, x_centre,C_x(:,3)/V, x_centre,C_x(:,5)/V,'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
% p(4).Marker = '.';
% p(4).Color = 'black';
% p(4).LineStyle = '-';

ylabel('Concentration (mol/L)')

t_end=5; %for now
tau = (C_x(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
ylim([0 .07])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}', '{\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 3.5])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

%% Plotting all SOLIDS and n_D results CONCENTRATION
%Discretised volumes!

x_centre = x -.6;
V = 3.2 * 0.023 * 0.28 * 1000;%dm3 or L

v = 0.24;
w = 3.2;
t_end = 5;
h=1e-7*10000;

V_interface = h*w*v*t_end;
%Glass speed (m/s)
v = 0.24;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(x_centre,C_x(:,2)/V_interface, x_centre,C_x(:,4)/V_interface, x_centre,C_x(:,6)/V_interface,'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
% p(4).Marker = '.';
% p(4).Color = 'black';
% p(4).LineStyle = '-';

ylabel('Concentration (mol/L)')

t_end=5; %for now
tau = (C_x(:,9)/(w*v*t_end))*1e6;
xlim([-0.6 0.6])
%ylim([0 .3])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
legend('n_A_s', 'n_B_s','n_C_s', '{\tau}')
xlabel('Distance (m)')
%     ylabel('Film volume (m�)')
ylim([0 10])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')


%% Running time simulation - Kinetics limited and fast - V4 - n_A ODEs - two-axes plot

clc
clear

%Kinetics
% frac = 0.025;
frac = 0.00025;
k_min = [27 8/50*10 7/50]*frac;
k_max = k_min*1.01;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.0001;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.01;

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;


fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);

%Initial conditions
IC = [0,0,0,0,0,0,0,0,0];
%t_end = 30*60;
t_end = 60*5;
tspan = [0 t_end];

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
% options1 = odeset('RelTol',1e-3,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
[t,C] = ode45(@filmFormationFullODE45uncertainV4timeCoeffMolar, tspan, IC, options2);

% %Industry
% %Glass speed (m/s)
% v = 0.24;
% %Glass width (m)
% w = 3.2;

figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
yyaxis left
p = plot(t,C(:,1), t,C(:,3), t,C(:,5), t,C(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance (mol)')

%Industry
%tau = (C(:,9)/(w*v*t_end))*1e6;
%Lab
tau = (C(:,9)/(0.1^2))*1e6;
% xlim([0 5])
% ylim([0 2])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(t,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('n_A_v', 'n_B_v','n_C_v','n_D_s', '{\tau}')
xlabel('Time (s)')
%     ylabel('Film volume (m�)')
% ylim([0 8])
ylabel('Film thickness ({\mu}m)')
set(gca,'FontSize', 20,'XGrid','on','YGrid','on')



%% test

x = 1:1:5;
y = [x;rand(1,5)];
fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%d %4.4f\n',y);
fclose(fileID);

fileID = fopen('coeffs.txt','r');
formatSpec = '%d %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);



%% PAPER1 %%
%                                 %
%                                 %
% Paper one simulations are below %
%                                 %
%                                 %


%% Parameters

clc
clear

%Glass speed (m/s)
glassSpeed = 0.24;
%Glass width (m)
w = 3.2;
%Reaction zone length (m)
reac_L = 1.2;

residenceTime = reac_L/glassSpeed;

%Kinetics
% frac = 0.025;
% frac = 0.0019;
 frac = 0.004;
% k_min = [27 8/50*10 7/50]*frac;
k_min = [270*1.5 8/50*1.4 7/50]*frac;
k_max = k_min*1.0001;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.001;
% h_m_min = [33 20*30 50 0]*frac2/50;
h_m_min = [37 20*30 70 0.5e-4]*frac2/50;
h_m_max = h_m_min*1.0001;

%Ratio of glass residence time per reactants flow rate residence time. If the ratio is one, the glass and the gas are flowing at same speed and the resulting plot shows what is consumed equals what is produced (space-plot coincides with time-plot). If the ratio is more than one, for each section of the glass, more than one �batch� of reactants will cross the reaction zone (the gas is faster) and the resulting plot shows the amount of reactant in each discrete volume, but the production is more than what is �consumed� in the plot, since this is a space-plot, not time-plot. E.g. if the glass takes 5 seconds to cross the reaction zone and the gas takes 2.5 seconds, there will be two �batches� of gas for each section of the glass crossing the reaction zone
ratioGperF = 1.953; %(gas flow rate F = 0.03 m3/s)


coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;
% coeffs = coeffs * 0; %if there were nothing happening

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);


%% Running time simulation - Kinetics limited and fast - V4 - n_A ODEs - two-axes plot


%Initial conditions
IC = [0,0,0,0,0,0,0,0,0];
t_end = 60*2;
% t_end = 500;
tspan = [0 t_end];

%Solving
options1 = odeset('RelTol',1e-2,'Stats','on');
options2 = odeset(options1,'NonNegative',1);
% [t,C] = ode45(@filmFormationFullODE45uncertainV4paperTimeCoeffMolar, tspan, IC, options2);
[t,C] = ode23s(@filmFormationFullODE45uncertainV4paperTimeCoeffMolar, tspan, IC, options2);


%t from sec to min
t = t/60;

% figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);

set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);

yyaxis left
p = plot(t,C(:,1), t,C(:,3), t,C(:,5), t,C(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance [mol]','FontName','Times New Roman')


%Lab
A = 0.045*0.1; %substrate area
tau = (C(:,9)/(A))*1e6;

%tau from um to nm
tau = tau*1000;


% xlim([0 5])
% ylim([0 2])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(t,tau, 'LineWidth',9);
p(1).Marker = '.';

legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', '{\tau}')
xlabel('Time [min]','FontName','Times New Roman')
%     ylabel('Film volume (m�)')
% ylim([0 8])
ylabel('Film thickness [nm]','FontName','Times New Roman')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')



%% Case 1/3 - Glass and gas flowing in the same direction
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)


%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3
distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * residenceTime;
t_end = distJump/glassSpeed/ratioGperF;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);
end

C_x(:,8:9) = C_x(:,8:9)*ratioGperF;


%% Plotting all gases and n_D results - Case 1/3b (using strategy of Case 3/3d)
%Discretised volumes!

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x(:,1:8) = C_x(:,1:8)/numberPoints;

x_centre = x -.6;
%Glass speed (m/s)
v = glassSpeed;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
yyaxis left
p = plot(x_centre,C_x(:,1), x_centre,C_x(:,3), x_centre,C_x(:,5), x_centre,C_x(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance [mol]')

t_end = residenceTime;
%film thickness (nanometres)
tau = (C_x(:,9)/(w*v*t_end))*1e9;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}', 'Position',[0.224826398268342 0.612266424947686 0.0686197925110655 0.278933098712839]);

xlabel('Distance [m]')
xticks([-0.6 -0.4 -0.2 0 0.2 0.4 0.6])
%     ylabel('Film volume (m�)')
ylim([0 500])
ylabel('Film thickness [nm]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

%% test

industrialFilmGrowthV1([.01 0])


%% Plotting all gases (Concentration) - Case 1/3b (using strategy of Case 3/3d)
%WARNING
%This section is run after running the one above.
%WARNING

%Scaling back to the overall volume
C_x(:,1:8) = C_x(:,1:8)*numberPoints;
%Calculating concentration (for reactor volume = 3.2*1.2*0.02)
C_x(:,1:8) = C_x(:,1:8)/(3.2*1.2*0.02*1e3); %1e3 converts from m3 to L

x_centre = x -.6;
%Glass speed (m/s)
v = glassSpeed;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
yyaxis left
p = plot(x_centre,C_x(:,1), x_centre,C_x(:,3), x_centre,C_x(:,5), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';



ylabel('Concentration [mol L^{-1}]')

t_end = residenceTime;
%film thickness (nanometres)
tau = (C_x(:,9)/(w*v*t_end))*1e9;
xlim([-0.6 0.6])
%ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}', ' {\tau}', 'Position',[0.224826398268342 0.612266424947686 0.0686197925110655 0.278933098712839]);

xlabel('Distance [m]')
xticks([-0.6 -0.4 -0.2 0 0.2 0.4 0.6])
%     ylabel('Film volume (m�)')
ylim([0 500])
ylabel('Film thickness [nm]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')


%% Case 2/3 - Glass and gas flowing in opposite directions
%This is a much better approximation, since it uses the V4 ODE system (updating the concentrations for each control volume after discretising the whole volume)

%Initial conditions
IC = [0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5; %five seconds
t_end = distJump/glassSpeed/ratioGperF;
% t_end = 10;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump) + 1;

fileID = fopen('previousC.txt','w');
fprintf(fileID,'%f %f %f %f\n',IC(1),IC(3),IC(5),IC(7));
fclose(fileID);

C_x = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(1)=0;
C_x(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

    fileID = fopen('previousC.txt','w');
    fprintf(fileID,'%f %f %f %f\n',C(length(t),1),C(length(t),3),C(length(t),5),C(length(t),7));
    fclose(fileID);

end

IC = [C_x(numberPoints,1:7),0, 0];
C_x2 = zeros(numberPoints,9);
x2 = zeros(numberPoints,1);
x2(1)=0;
C_x2(1,:)=IC;
i=2;
for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x2(i,j) = C(length(t),j);
    end
    x2(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x2(:,8:9) = C_x2(:,8:9)*ratioGperF;

%% Plotting all gases and n_D results - Case 2/3b (using strategy of Case 3/3d)

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
C_x2(:,1:8) = C_x2(:,1:8)/numberPoints;

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = glassSpeed;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
yyaxis left
p = plot(x_centre,C_x2(:,1), x_centre,C_x2(:,3), x_centre,C_x2(:,5), x_centre,C_x2(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance [mol]')

t_end=5;
%film thickness (nanometres)
tau = (C_x2(:,9)/(w*v*t_end))*1e9;
xlim([-0.6 0.6])
ylim([0 0.012])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
%     legend('n_A_v','n_A_s', 'n_B_v','n_B_s', 'n_C_v','n_C_s', 'n_D_g', 'n_D_s', 'V')
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}', 'Position',[0.224826398268342 0.612266424947686 0.0686197925110655 0.278933098712839]);
xlabel('Distance [m]')
xticks([-0.6 -0.4 -0.2 0 0.2 0.4 0.6])
%     ylabel('Film volume (m�)')
ylim([0 500])
ylabel('Film thickness [nm]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')


%% Case 3/3 - Glass and gas flowing in mixed directions (input gas in the middle)
% WARNING WARNING WARNING WARNING
% Before running this simulation: make sure the reactor volume is divided by two in the filmFormationFullODE45uncertainV7paperCoeffParMolar file!!
% WARNING WARNING WARNING WARNING

%Initial conditions
equalSplitIC = .5*[0.768,0,0,0,0,0,0,0,0]; %C_A_in = 10 mol/m3 (half for each side)

% asymmetryFrac = 0.05;
asymmetryFrac = 0.02;
asymmIC = equalSplitIC*(1+asymmetryFrac);
IC = asymmIC;

distJump = 0.01;
glassSpeed = 0.24;
totalLength = glassSpeed * 5/2; %five seconds total (5/2 for each half)
t_end = distJump/glassSpeed/ratioGperF;
tspan = [0 t_end];
numberPoints = round(totalLength/distJump)*2 + 1;
middleNumberPoints = round(totalLength/distJump) + 1;


C_x3RHS = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3RHS(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;
for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3RHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

end

IC = 2*equalSplitIC - asymmIC;


C_x3temp = zeros(numberPoints,9);
x = zeros(numberPoints,1);
x(middleNumberPoints)=totalLength;
C_x3temp(middleNumberPoints,:)=IC;
i=middleNumberPoints+1;

for dist = (totalLength+distJump):distJump:totalLength*2
    %Solving
    options1 = odeset('RelTol',1e-1,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3temp(i,j) = C(length(t),j);
    end
    x(i) = dist;
    IC = [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)];
    i = i+1;

end

IC = [C_x3temp(numberPoints,1:7),0, 0];
C_x3LHS = zeros(numberPoints,9);

x(1)=0;
C_x3LHS(1,:)=IC;
i=2;

for dist = distJump:distJump:totalLength
    %Solving
    options1 = odeset('RelTol',1e-2,'Stats','on');
    % options1 = odeset('RelTol',1e-3,'Stats','on');
    options2 = odeset(options1,'NonNegative',1);
    [t,C] = ode45(@filmFormationFullODE45uncertainV7paperCoeffMolar, tspan, IC, options2);
    for j=1:9
        C_x3LHS(i,j) = C(length(t),j);
    end
    x(i) = dist;
    %IC = IC + (IC - [C(length(t),1),C(length(t),2),C(length(t),3),C(length(t),4),C(length(t),5),C(length(t),6),C(length(t),7),C(length(t),8),C(length(t),9)]);
    IC = [C_x3temp(numberPoints+1-i,1:7), C(length(t),8:9)];
    i = i+1;
end

C_x3RHS(:,8) = C_x3RHS(:,8) + C_x3LHS(middleNumberPoints,8);
C_x3RHS(:,9) = C_x3RHS(:,9) + C_x3LHS(middleNumberPoints,9);

C_x3 = C_x3RHS;
for i=2:middleNumberPoints
    C_x3(i-1,:) = C_x3LHS(i,:);
end

C_x3(:,8:9) = C_x3(:,8:9)*ratioGperF;

%% Plotting all gases and n_D results - Case 3/3d

%The results above are valid for the whole volume. Below is the scaling down to each of the discrete volume units
%C_x3(:,1:8) = C_x3(:,1:8)/numberPoints;
C_x3(:,7:8) = C_x3(:,7:8)/numberPoints;
C_x3(:,1:6) = C_x3(:,1:6)/(numberPoints/2);

%Discretised volumes!
x_centre = x -.6;
%Glass speed (m/s)
v = glassSpeed;
%Glass width (m)
w = 3.2;

figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(figure1,'defaultAxesColorOrder',[[0 0 0]; [.5 .3 .2]]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
yyaxis left
p = plot(x_centre,C_x3(:,1), x_centre,C_x3(:,3), x_centre,C_x3(:,5), x_centre,C_x3(:,8), 'LineWidth',5);
% p(1).Marker = '.';
p(1).Color = 'green';
p(1).LineStyle = '--';
% p(2).Marker = '.';
p(2).Color = 'cyan';
p(2).LineStyle = ':';
% p(3).Marker = '.';
p(3).Color = 'yellow';
p(3).LineStyle = '-.';
p(4).Marker = '.';
p(4).Color = 'black';
p(4).LineStyle = '-';

ylabel('Amount of substance [mol]')

t_end=5;
%film thickness (nanometres)
tau = (C_x3(:,9)/(w*v*t_end))*1e9;
xlim([-0.6 0.6])
ylim([0 0.012])
% ylim([0 0.004])
yyaxis right
%     p = plot(t,C(:,9), 'LineWidth',5);
p = plot(x_centre,tau, 'LineWidth',9);
p(1).Marker = '.';
legend('A_{(g)}', 'B_{(g)}','C_{(g)}','D_{(s)}', ' {\tau}', 'Position',[0.224826398268342 0.612266424947686 0.0686197925110655 0.278933098712839]);
xlabel('Distance [m]')
xticks([-0.6 -0.4 -0.2 0 0.2 0.4 0.6])
%     ylabel('Film volume (m�)')
ylim([0 500])
% ylim([0 2])
ylabel('Film thickness [nm]')
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
