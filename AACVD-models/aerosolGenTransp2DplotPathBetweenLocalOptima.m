function aerosolGenTransp2DplotPathBetweenLocalOptima(x1,x2)

%There will be NumberOfPoints+1 point (including 0).
NumberOfPoints = 100;

P = zeros(1,101);
lambda = 0:(1/NumberOfPoints):1;

for i=1:(NumberOfPoints+1)
    x = x1 + lambda(i)*(x2-x1);
    x(2) = round(x(2));
    P(i) = -penetrationMINLP(x);
%     %Step by step
%     scatter(lambda(i),P(i));
%     hold on
end

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter(lambda, P, 'LineWidth',1.5);
%plot(lambda, P, 'LineWidth',2);
%legend('','')
xlabel('Fractional distance between two local optima')
ylabel('Objective function value')
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');

end
