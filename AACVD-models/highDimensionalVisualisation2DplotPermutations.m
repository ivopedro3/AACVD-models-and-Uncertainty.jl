function highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y)
%This function permutes the independent variables so that we can have different insights regarding the results (for example, �X� shapes for some configurations)

matrixDim = size(LB_x);
numRows = matrixDim(2);

%This will generate a random combination of integer numbers from 1 to numRows, where numRows is the number of independent variables of the model
rand = randperm(numRows);

LB_x = LB_x(:, rand);
UB_x = UB_x(:, rand);
optima_x = optima_x(:, rand);
categoricalVariablesArray_x = categoricalVariablesArray_x(:, rand);

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
