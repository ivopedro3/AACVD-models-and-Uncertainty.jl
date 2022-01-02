clc
clear


T_t0 = 25+273;
TimeDomain = [0.01 .10];

%air 350 K
ro = 0.995;
Cp = 1.009;

d = 0.01;
Q = 2.5e-6;
%Q = 2.5e-9;
U = 4*Q/(pi*d^2);

Tinf = 273+500;

%r=0.01;


input = [d Q 20.92e-6 .01 .003 30e-3];
h = impingementHeatTransferCoeff(input);
%h = 0.0051;

%A = pi*(r)^2; where r = U*t
%Q*t=V
[t,T] = ode45(@(t,T) -(h*(pi*(U*t)^2)/ro/(Q*t)/Cp*(T-Tinf)), TimeDomain , T_t0);
%[t,T] = ode45(@(t,T) -(h*(pi*(1)^2)/ro/(Q*t)/Cp*(T-Tinf)), TimeDomain , T_t0);



% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create plot
plot(t, T,'LineWidth',2)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Time (s)') %({\mu}m)
% Create ylabel
ylabel('Temperature (K)')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
%xlim([0 .7e-3])
