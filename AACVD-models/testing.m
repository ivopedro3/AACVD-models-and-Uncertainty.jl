clc
clear

% parameters = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5, .0254];
% parameters2 = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.50 , pi/6,.0254];
%
% %P=bendTubePenetrationA(90,parameters);
%
% P2=bendTubePenetrationB(parameters2);
%
%
%
% % syms oi(x);
% % oi(x)=22*x+3;
% % %fsolve (oi(x), 5);
% % a=vpasolve(oi(x)==0,x);
%
%
%  b=5;


% x = 1:10:100;
% y = [20 30 45 40 60 65 80 75 95 90];
% err = [1 3 5 3 5 3 6 4 3 3];
% errorbar(x,y,err,'horizontal')

% X1 = [1 2];
%
% Y1 = [1 2];


% % Create figure
% figure1 = figure('PaperOrientation','landscape',...
%     'PaperSize',[29.69999902 20.99999864],...
%     'Color',[1 1 1]);
%
% % Create axes
% axes1 = axes('Parent',figure1,...
%     'Position',[0.135620052770448 0.163838484546361 0.763047493403692 0.737457627118644]);
% hold(axes1,'on');
%
% % Create plot
% plot(X1,X1,'LineWidth',2);
%
% % Create xlabel
% xlabel('Transducer frequency (kHz)');
%
% % Create title
% title('Droplet median diameter as a function of transducer frequency');
%
% % Create ylabel
% ylabel('Droplet median diameter ({\mu}m)');
%
% box(axes1,'on');
% % Set the remaining axes properties
% set(axes1,'FontSize',16);
%
% %Saving plot as a pdf
% print('test3','-dpdf','-fillpage')
%

% x = [1e-12, 786.6, 5.47e-4, 2.2e-2, 0, 2e3, 1.6e6];
% x2=1e-12;
% x1=1.00001e-12;
%
%
%
%
% y2=x;
% y1=x;
%
% y2(1)=x2;
% y1(1)=x1;
%
% a=(dropletDiameterB(y2)-dropletDiameterB(y1))/(x2-x1);


%% MINLP using Strawberry
%function [x z nf ninf bestgen] = strawberry(x0, a, b, f, ngen, npop, nrmax, ns, population_strategy, output)
mitestrandom = @() [1+5*rand() 1+round(6*rand()-0.5)];
  x(x>6) = 6;
