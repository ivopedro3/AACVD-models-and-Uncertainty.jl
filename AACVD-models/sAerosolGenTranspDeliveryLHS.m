clear
clc


%% Aerosol generation

sampleSize = 1000;
numberOfVariables = 7;

sample = lhsdesign(sampleSize,numberOfVariables);

%Methanol at 25�C
%parameters = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 2000];

Q = [1 10].*1e-12;
%Q = [1 14].*1e-8;
ro = [700 1200];
mu = [3 11].*1e-4;
sigma = [2 5].*1e-2;
d = [0 0];
I = [1000 3000];
%I = [16000 915000];
%f =[.5 3].*1e6;
f =[1 3].*1e6;


parameters = sample.*[Q(2) ro(2) mu(2) sigma(2) d(2) I(2) f(2)] - (sample-1).*[Q(1) ro(1) mu(1) sigma(1) d(1) I(1) f(1)];

dd = zeros(1,sampleSize);

for i = 1:sampleSize
    dd(i) = dropletDiameterB(parameters(i,:));
end

% Create plot figure
%figure1 = figure('PaperOrientation','portrait','Color',[1 1 1]);
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
%ylim([5e-6 10e-6])

FontSize = 11.5;

subplot(3,2,1)
scatter(parameters(:,1),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Precursor solution flow rate (m�/s)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
xlim([.1e-11 1e-11])
ylim([5e-6 10e-6])

subplot(3,2,2)
scatter(parameters(:,2),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Droplet density (kg/m�)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
ylim([5e-6 10e-6])

subplot(3,2,3)
scatter(parameters(:,3),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Droplet dynamic viscosity (N�s/m�)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
xlim([3e-4 11e-4])
ylim([5e-6 10e-6])

subplot(3,2,4)
scatter(parameters(:,4),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Droplet surface tension (N/m)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
ylim([5e-6 10e-6])

subplot(3,2,5)
scatter(parameters(:,6),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Power surface intensity (W/m�)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
ylim([5e-6 10e-6])

subplot(3,2,6)
scatter(parameters(:,7),dd, 'MarkerEdgeColor',[0.24 0.15 0.66],'LineWidth',1);
xlabel('Ultrasonic frequency (Hz)')
ylabel('Droplet diameter (m)')
set(gca,'FontSize',FontSize,'XGrid','on','YGrid','on')
ylim([5e-6 10e-6])


%print('Atomiser_droplet_diameter_LHS','-dpdf','-fillpage')






% Machine Learning

dd=dd';

t = templateTree('Surrogate','on');
ens = fitensemble(parameters,dd,'LSBoost',100,t);
[imp,ma] = predictorImportance(ens);
imp2 = imp/sum(imp);

% Create plot figure
figure('PaperOrientation','landscape','Color',[1 1 1]);

name = {'{Q_{p}}';'{\rho_{d}}';'{\mu_{d}}';'{\sigma_{d}}';'I'; 'f'};
axis([0 7 0 1])
bar(imp2([1:4,6:7]), 0.5)
set(gca,'xticklabel',name,'FontSize',27,'XGrid','on','YGrid','on')
% Create xlabel
xlabel('Parameter')
% Create ylabel
ylabel('Relative importance')

%print('Atomiser_droplet_diameter_LHS_variable_importance','-dpdf','-fillpage')

% %METHOD 2
% [ranked,weights] = relieff(parameters,dd,100);
%
% % Create plot figure
% figureBar2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% % Create axes
% axesBar2 = axes('Parent',figureBar2);
% hold(axesBar2,'on');
% % Create xlabel
% %xlabel('Transducer frequency (kHz)')
% % Create ylabel
% %ylabel('Droplet median diameter ({\mu}m)')
% set(gca,'FontSize',20)
% %Saving plot as a pdf
% %print('Atomiser_droplet_diameter_vs_frequency','-dpdf','-fillpage')
%
% bar(weights);

% % METHOD 3
% %Somehow it complains that the function oobPer... doesn't exist
% Imp = oobPermutedPredictorImportance(ens);
% bar(Imp)


%% Aerosol transport

numberOfVariables = 10;
sample = lhsdesign(sampleSize,numberOfVariables);

%parameters = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, X];
%Methanol at 25�C
parameters = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 7e-6, .01, 0*pi/2, 2];

T = [298.15 298.15]; %not used
ro = [0.4 1.2];
Q = [1 10].*1e-5;
mu = [1.8 3.7].*1e-5;
ro_d = [700 1200];
mu_d = 0*[5 5].*1e-4; %not used
dd = [5 9].*1e-6;
d = [.005 .02];
phi = [0 0.5];
X =[0.5 5];

parameters = sample.*[T(2) ro(2) Q(2) mu(2) ro_d(2) mu_d(2) dd(2) d(2) phi(2) X(2)] - (sample-1).*[T(1) ro(1) Q(1) mu(1) ro_d(1) mu_d(1) dd(1) d(1) phi(1) X(1)];

P = zeros(1,sampleSize);

for i = 1:sampleSize
    P(i) = -straightTubePenetrationA(parameters(i,:));
end


% Create plot figure
figure2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');
set(gca,'FontSize',20)

subplot(4,2,1)
scatter(parameters(:,2),P,10);
xlabel('Carrier fluid density (kg/m�)')

subplot(4,2,2)
scatter(parameters(:,3),P,10);
xlabel('Carrier fluid flow rate (m�/s)')

subplot(4,2,3)
scatter(parameters(:,4),P,10);
xlabel('Carrier fluid dynamic viscosity (N�s/m�)')

subplot(4,2,4)
scatter(parameters(:,5),P,10);
xlabel('Droplet density (kg/m�)')

subplot(4,2,5)
scatter(parameters(:,7),P,10);
xlabel('Droplet diameter (m)')

subplot(4,2,6)
scatter(parameters(:,8),P,10);
xlabel('Pipe inner diameter (m)')

subplot(4,2,7)
scatter(parameters(:,9),P,10);
xlabel('Pipe inclination angle (rad)')

subplot(4,2,8)
scatter(parameters(:,10),P,10);
xlabel('Pipe length (m)')


% Machine Learning MACHINE LEARNING
P=P';
t = templateTree('Surrogate','on');
ens = fitensemble(parameters,P,'LSBoost',100,t);
[imp,ma] = predictorImportance(ens);
imp2 = imp/sum(imp);

% Create plot figure
figure('PaperOrientation','landscape','Color',[1 1 1]);

name = {'{\rho}';'Q';'{\mu}';'{\rho_{d}}';'{d_{d}}';'d';'{\phi}';'L'};
bar(imp2([2:5,7:10]), 0.5)
axis([0 9 0 0.4])
set(gca,'xticklabel',name,'FontSize',27,'XGrid','on','YGrid','on')
% Create xlabel
xlabel('Parameter')
% Create ylabel
ylabel('Relative importance')
print('Atomiser_aerosol_penetration_LHS_variable_importance','-dpdf','-fillpage')



% [ranked,weights] = relieff(parameters,P,100);
%
% % Create plot figure
% figureBar2 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% % Create axes
% axesBar2 = axes('Parent',figureBar2);
% hold(axesBar2,'on');
% % Create xlabel
% %xlabel('Transducer frequency (kHz)')
% % Create ylabel
% %ylabel('Droplet median diameter ({\mu}m)')
% set(gca,'FontSize',20)
% %Saving plot as a pdf
% %print('Atomiser_droplet_diameter_vs_frequency','-dpdf','-fillpage')
%
% bar(weights);




%% Aerosol delivery 1/2 (temperature profile) THINK ABOUT WHICH NU TO USE!!!

numberOfVariables = 6;
sample = lhsdesign(sampleSize,numberOfVariables);

%Parameters = [Q, mu, ro, Cp, Pr, k]
%fluidFlow([2.5e-3 52.69e-6 0.5804 1051 0.685 .0469])

Q = [.1 1].*1e-2;
mu = [1.8 3.7].*1e-5;
ro = [.4 1.2].*1e-0;
Cp = [1000 1100].*1e-0;
Pr = [.68 .72];
k = [.025 .058];


parameters = sample.*[Q(2) mu(2) ro(2) Cp(2) Pr(2) k(2)] - (sample-1).*[Q(1) mu(1) ro(1) Cp(1) Pr(1) k(1)];

T = zeros(1,sampleSize);

for i = 1:sampleSize
    T(i) = fluidFlow(parameters(i,:));
end


% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
set(gca,'FontSize',20)

subplot(3,2,1)
scatter(parameters(:,1),T);
xlabel('Flow rate (m�/s)')
ylabel('Temperature (K)')

subplot(3,2,2)
scatter(parameters(:,2),T);
xlabel('Dynamic viscosity (N�s/m�)')
ylabel('Temperature (K)')

subplot(3,2,3)
scatter(parameters(:,3),T);
xlabel('Density (kg/m�)')
ylabel('Temperature (K)')

subplot(3,2,4)
scatter(parameters(:,4),T);
xlabel('Cp (N/m)')
ylabel('Temperature (K)')

subplot(3,2,5)
scatter(parameters(:,5),T);
xlabel('Pr (W/m�)')
ylabel('Temperature (K)')

subplot(3,2,6)
scatter(parameters(:,6),T);
xlabel('k (Hz)')
ylabel('Temperature (K)')
%ylim([0 1e-6])

print('Atomiser_droplet_diameter_LHS','-dpdf','-fillpage')

% Machine Learning MACHINE LEARNING
t = templateTree('Surrogate','on');
ens = fitensemble(parameters,T,'LSBoost',100,t);
[imp,ma] = predictorImportance(ens);
imp2 = imp/sum(imp);

% Create plot figure
figure('PaperOrientation','landscape','Color',[1 1 1]);

name = {'Q_{T}';'{\mu}';'{\rho}';'{c_{p}}';'{Pr}';'{k}'};
%axis([0 7 0 1])
bar(imp2, 0.5)
set(gca,'xticklabel',name,'FontSize',27,'XGrid','on','YGrid','on')
% Create xlabel
xlabel('Parameter')
% Create ylabel
ylabel('Relative importance')

print('Atomiser_temperature_LHS_variable_importance','-dpdf','-fillpage')


%% Aerosol delivery 2/2 (droplet evaporation)

%This section has its own script.
