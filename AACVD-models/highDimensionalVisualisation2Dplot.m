function highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y)

LB = [LB_x LB_y];
UB = [UB_x UB_y];
optima = [optima_x optima_y];
categoricalVariablesArray = [categoricalVariablesArray_x categoricalVariablesArray_y];

xAxis = categorical(categoricalVariablesArray, categoricalVariablesArray);

matrixSize = size(optima);
NumberOfoptima = matrixSize(1);

% Create plot figure
figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

for i = 1:NumberOfoptima
    %All variables will be in the interval [0,1], representing a linear map to their relative position in relation to the bounds (if 0, the variable is equal the lower bound).
    normalisedOptimum = (optima(i,:)-LB)./(UB-LB);
    plot (xAxis, normalisedOptimum, 'LineWidth',2);
    hold on;
end

%legend('','')
xlabel('Design variables and objective')
ylabel('Variable values (normalised)')
set(gca,'FontSize',16)
set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
hold off
