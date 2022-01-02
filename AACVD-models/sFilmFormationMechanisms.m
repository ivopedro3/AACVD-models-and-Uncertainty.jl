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
