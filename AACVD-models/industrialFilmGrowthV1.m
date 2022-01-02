%Droplet size ultrasonic atomization (droplets are produced by the flow of
%the liquid on a vibrating surface).

function dp = industrialFilmGrowthV1(x)


%% Parameters


%Glass speed (m/s)
glassSpeed = 0.24;
%Glass width (m)
w = 3.2;
%Reaction zone length (m)
reac_L = 1.2;

residenceTime = reac_L/glassSpeed;

%Kinetics
% frac = 0.025;
frac = 0.0019;
% k_min = [27 8/50*10 7/50]*frac;
k_min = [270*1.5 8/50*1.4 7/50]*frac;
k_max = k_min*1.0001;

%Mass transfer
% frac2 = 0.01;
frac2 = 0.001;
h_m_min = [33 20*30 50 0]*frac2/50;
h_m_max = h_m_min*1.0001;

%Ratio of glass residence time per reactants flow rate residence time. If the ratio is one, the glass and the gas are flowing at same speed and the resulting plot shows what is consumed equals what is produced (space-plot coincides with time-plot). If the ratio is more than one, for each section of the glass, more than one �batch� of reactants will cross the reaction zone (the gas is faster) and the resulting plot shows the amount of reactant in each discrete volume, but the production is more than what is �consumed� in the plot, since this is a space-plot, not time-plot. E.g. if the glass takes 5 seconds to cross the reaction zone and the gas takes 2.5 seconds, there will be two �batches� of gas for each section of the glass crossing the reaction zone
ratioGperF = x(1);

coeffs_min = [k_min h_m_min];
coeffs_max = [k_max h_m_max];

coeffs = rand() * (coeffs_max - coeffs_min) + coeffs_min;
% coeffs = coeffs * 0; %if there were nothing happening

fileID = fopen('coeffs.txt','w');
fprintf(fileID,'%f %f %f %f %f %f %f\n',coeffs);
fclose(fileID);




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


end
