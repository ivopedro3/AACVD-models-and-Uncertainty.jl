clc
clear
T_d0 = 25+273;
R_d0 = 7e-6;

sampleSize = 1000;
numberOfVariables = 9;

Q_total_range = [.1 1].*1e-2;
Cross_section_area = 3.2*0.026; %L1*L2

sample = lhsdesign(sampleSize,numberOfVariables);

c_pv_range = [1 1.1].*1e3;
%T_g_range = [4.5 7.5].*1e2; %initial range
T_g_range = [5 7].*1e2;
%h_fg_range = [.5 1.5].*1e6; %initial range
h_fg_range = [1 1.4].*1e6;
mu_g_range = [1.8 3.7].*1e-5;
%k_g_range = [2.5 5.8].*1e-2;
k_g_range = [3.5 4.8].*1e-2;
u_g_range = Q_total_range./Cross_section_area; %this is a function of the total flow rate
ro_g_range = [0.4 1.2].*1e0;
%ro_dw_range = [.7 1.2].*1e3; %initial range
ro_dw_range = [.7 1].*1e3;
c_pd_range = [2.0 4.0].*1e3;

parameters = sample.*[c_pv_range(2) T_g_range(2) h_fg_range(2) mu_g_range(2) k_g_range(2) u_g_range(2) ro_g_range(2) ro_dw_range(2) c_pd_range(2)] -...
(sample-1).*[c_pv_range(1) T_g_range(1) h_fg_range(1) mu_g_range(1) k_g_range(1) u_g_range(1) ro_g_range(1) ro_dw_range(1) c_pd_range(1)];

%parameters = [c_pv T_g h_fg mu_g k_g u_g ro_g ro_dw c_pd]
%parameters = [1.71875e+03 500.5 1.1961875e+06 2.9475e-5 0.0454 0.21 0.616 792 2.484375e+03];


TimeDomain = [0 .5];
IC1 = R_d0;
IC2 = T_d0;
IC = [IC1 IC2];

DryingTime = zeros(sampleSize,1);

for i=1:sampleSize
    c_pv = parameters(i,1);
    T_g = parameters(i,2);
    h_fg = parameters(i,3);
    mu_g = parameters(i,4);
    k_g = parameters(i,5);
    u_g = parameters(i,6);
    ro_g = parameters(i,7);
    ro_dw = parameters(i,8);
    c_pd = parameters(i,9);

    [IVsol, DVsol] = ode23('firstStageDryingDifferentialsLHS', TimeDomain, IC);
    sz = size(IVsol);
    DryingTime(i) = IVsol(sz(1));
end




% for R_d0 = 2:1:7
%     R_d0 = R_d0*1e-6;
%
%     TimeDomain = [0 .5];
%     IC1 = R_d0;
%     IC2 = T_d0;
%     IC = [IC1 IC2];
%     [IVsol, DVsol] = ode23('firstStageDryingDifferentialsLHS', TimeDomain, IC);
%     plot(IVsol, DVsol(:,1),'LineWidth',2)
%     hold on
% end


% Machine Learning MACHINE LEARNING

%Removing outliers
medianDryingTime = median(DryingTime);
for i=1:sampleSize
    if DryingTime(i)/medianDryingTime > 5 || DryingTime(i)/medianDryingTime < .02
        DryingTime(i) = NaN;
    end
end


t = templateTree('Surrogate','on');
ens = fitensemble(parameters,DryingTime,'LSBoost',50,t);
[imp,ma] = predictorImportance(ens);
imp2 = imp/sum(imp);

% Create plot figure
figure('PaperOrientation','landscape','Color',[1 1 1]);

name = {'{c_{p}}';'{T_{w}}';'{h_{vap,d}}';'{\mu}';'{k}';'{Q_{T}}';'{\rho}';'{\rho_{d}}';'{c_{p,d}}'};
%axis([0 7 0 1])
bar(imp2, 0.5)
set(gca,'xticklabel',name,'FontSize',27,'XGrid','on','YGrid','on')
% Create xlabel
xlabel('Parameter')
% Create ylabel
ylabel('Relative importance')

print('Atomiser_drying_time_LHS_variable_importance','-dpdf','-fillpage')
