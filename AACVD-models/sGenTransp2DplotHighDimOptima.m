clc
clear
%Last column is the objective variable
%{'Q_T', 'N_p', 'd_d', 'd', 'P'};
% LB = [2e-5, 1, 5e-6  0.01 0];
% UB = [5e-3, 10,10e-6 0.1 1];
% optima = [0.004999999	1	5E-06	0.064552362	0.394268056
% 0.004999999	2	5E-06	0.04710817	0.306071169
% 0.004999999	3	5E-06	0.039203302	0.25792029
% 0.004999999	4	5E-06	0.034422581	0.22590515];


%LB = [2e-5, 1, 0.001e-6  0.01 0];
%UB = [5e-3, 10,10e-6 0.05 1];
%Ten local optima
% optima = [0.003341573	1	1.52E-07	0.049978525	0.982549188
% 0.004992965	2	1.72E-07	0.049970796	0.982076643
% 0.00499875	3	1.86E-07	0.048552341	0.978991958
% 0.004997143	4	1.88E-07	0.044148533	0.975544418
% 0.004657651	5	1.84E-07	0.036791775	0.971493902
% 0.004998828	6	1.86E-07	0.035709336	0.969802255
% 0.004925636	7	1.86E-07	0.032827565	0.967027643
% 0.004997243	8	1.81E-07	0.030940763	0.964863663
% 0.004767122	9	1.84E-07	0.028793208	0.961759984
% 0.004800703	10	1.84E-07	0.027488124	0.959765158
% ];
%Six local optima
% optima = [0.003341573	1	1.52E-07	0.049978525	0.982549188
% 0.004997143	4	1.88E-07	0.044148533	0.975544418
% 0.004657651	5	1.84E-07	0.036791775	0.971493902
% 0.004997243	8	1.81E-07	0.030940763	0.964863663
% 0.004767122	9	1.84E-07	0.028793208	0.961759984
% 0.004800703	10	1.84E-07	0.027488124	0.959765158
% ];


% LB = [2e-5, 1, 5e-6  0.01 0];
% UB = [5e-3, 10,10e-6 0.05 1];
% optima = [0.004281146	1	5.00E-06	0.049999982	0.351120045
% 0.004999536	4	5.00E-06	0.034420722	0.225885172
% 0.004999999	5	5.00E-06	0.031124944	0.202488044
% 0.004972217	6	5.01E-06	0.028692434	0.183247054
% 0.004999995	7	5.00E-06	0.026747729	0.16973943
% ];


LB_x = [2e-5, 1, 0.1e-6 0.01];
LB_y = [0];

UB_x = [5e-3, 10,0.3e-6 0.05];
UB_y = [1];

optima_x = [
0.003370405	1	1.47E-07	0.049999354
0.004173717	2	1.77E-07	0.046675173
0.004929546	4	1.81E-07	0.040742516
0.004707109	5	1.73E-07	0.035318939
0.002596613	5	2.75E-07	0.04394838
];

optima_y = [
0.982537218
0.980495814
0.975289729
0.971361941
0.946196888
];

categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};

%highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);

%% Comparing the results from genetic algorithm (Strawberry) and from fmincon

% %COMPARISON #1
%
% %Strawberry
% LB_x = [2e-5, 1, 0.1e-6 0.01];
% LB_y = [0];
%
% UB_x = [5e-3, 10,0.3e-6 0.05];
% UB_y = [1];
%
% optima_x = [
% 0.003257303	1	1.56E-07	0.05
% 0.004874759	3	1.79E-07	0.041823905
% 0.002820944	4	2.13E-07	0.029546533
% 0.004955716	8	2.06E-07	0.047161445
% 0.000262662	1	1.79E-07	0.014361076
% ];
%
% optima_y = [
% 0.982563035
% 0.977840885
% 0.965438103
% 0.957321307
% 0.926391508
% ];
%
% categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
% categoricalVariablesArray_y = {'P'};
%
% highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
% %highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
%
% %fmincon
% LB_x = [2e-5, 1, 0.1e-6 0.01];
% LB_y = [0];
%
% UB_x = [5e-3, 10,0.3e-6 0.05];
% UB_y = [1];
%
% optima_x = [
% 0.003255426	1	1.52E-07	0.049974084
% 0.004995425	3	1.80E-07	0.048466311
% 0.004999965	5	1.80E-07	0.038400341
% 0.002437765	7	1.37E-07	0.020287478
% 0.002163243	10	1.45E-07	0.028175066
% ];
%
% optima_y = [
% 0.98254432
% 0.978945768
% 0.972502542
% 0.947404291
% 0.919249906
% ];
%
% categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
% categoricalVariablesArray_y = {'P'};
%
% highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
% %highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);

%COMPARISON #2

%Strawberry
LB_x = [2e-5, 1, 4e-6 0.01];
LB_y = [0];

UB_x = [5e-3, 10,10e-6 0.05];
UB_y = [1];

optima_x = [
0.004219503	1	4.00E-06	0.05
0.002384655	1	4.00E-06	0.05
0.00486875	2	4.28E-06	0.041220268
0.001002497	2	4.00E-06	0.027479116
];

optima_y = [
0.450333461
0.39625129
0.361051675
0.200190493
];

categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};

highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
%highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);

%fmincon
LB_x = [2e-5, 1, 4e-6 0.01];
LB_y = [0];

UB_x = [5e-3, 10,10e-6 0.05];
UB_y = [1];

optima_x = [
0.004218217	1	4.00E-06	0.049999931
0.004999985	2	4.00E-06	0.047533653
0.004999599	4	4.00E-06	0.034730972
0.004999599	4	4.00E-06	0.034730942
0.004974497	10	4.01E-06	0.023184627
];

optima_y = [
0.450332682
0.404901156
0.31548382
0.31548382
0.208558626
];

categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};

highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
%highDimensionalVisualisation2DplotPermutations(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);



%% Path between two optima

% %LB = [2e-5, 1, 0.001e-6  0.01];
% %UB = [5e-3, 10,10e-6 0.05];
% a = [0.003341573	1	1.52E-07	0.049978525];
% b = [0.004800703	10	1.84E-07	0.027488124];
% aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

% % LB = [2e-5, 1, 5e-6  0.01];
% % UB = [5e-3, 10,10e-6 0.05];
% a = [0.004281146	1	5.00E-06	0.049999982];
% b = [0.004999995	7	5.00E-06	0.026747729];
% aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

% % LB = [2e-5, 1, 0.1e-6 0.01];
% % UB = [5e-3, 10,0.3e-6 0.05];
% a = [0.003370405	1	1.47E-07	0.049999354];
% b = [0.002596613	5	2.75E-07	0.04394838];
% aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);


%Strawberry 1
% LB = [2e-5, 1, 0.1e-6 0.01];
% UB = [5e-3, 10,0.3e-6 0.05];
a = [0.003257303	1	1.56E-07	0.05];
b = [0.004955716	8	2.06E-07	0.047161445];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

%Strawberry 2
% LB = [2e-5, 1, 4e-6 0.01];
% UB = [5e-3, 10,10e-6 0.05];
a = [0.004219503	1	4.00E-06	0.05];
b = [0.002828814	8	4.00E-06	0.034619203];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

%% Comparing results for constrained MINLP (constrained by film thickness)
%Boundaries
LB_x = [2e-5, 1, 0.1e-6, 0.01];
LB_y = [0];

UB_x = [5e-3, 10, 0.3e-6, 0.05];
UB_y = [1];

%Film thickness: (10 to 100)*1e-9 m
a = [0.000609526	1	1.94E-07	0.029839607];
b = [0.000645137	10	2.41E-07	0.029038357];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

optima_x = [
0.000609526	1	1.94E-07	0.029839607
0.000607308	2	2.04E-07	0.019143508
0.000515863	3	2.14E-07	0.023002773
0.000680238	5	1.97E-07	0.016689382
0.000785481	7	1.73E-07	0.030442297
0.000645137	10	2.41E-07	0.029038357
];
optima_y = [
0.964359494
0.945922871
0.923961107
0.922486865
0.861646671
0.786356337
];
categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};
highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);


%Film thickness: (100 to 200)*1e-9 m
a = [0.001178857	2	1.89E-07	0.030421947];
b = [0.001073673	10	2.00E-07	0.03658103];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

optima_x = [
0.001178857	2	1.89E-07	0.030421947
0.001178954	4	1.99E-07	0.023766185
0.001154096	6	1.27E-07	0.023818086
0.001145897	6	2.99E-07	0.037740606
0.001073673	10	2.00E-07	0.03658103
];
optima_y = [
0.963848366
0.947734436
0.912097302
0.879121061
0.836755926
];
categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};
highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);


%Film thickness: (300 to 400)*1e-9 m
a = [0.001762025	1	1.00E-07	0.046579842];
b = [0.001950111	9	2.81E-07	0.043968967];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

optima_x = [
0.001762025	1	1.00E-07	0.046579842
0.001745405	4	2.08E-07	0.026572718
0.0019737	6	1.29E-07	0.030995087
0.002020828	8	1.45E-07	0.037924555
0.001950111	9	2.81E-07	0.043968967
];
optima_y = [
0.971008678
0.957297246
0.93321317
0.910103531
0.88285779
];
categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};
highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);

%Film thickness: (400 to 500)*1e-9 m
a = [0.00221758	1	2.04E-07	0.042726163];
b = [0.002210821	9	2.27E-07	0.049808415];
aerosolGenTransp2DplotPathBetweenLocalOptima(a,b);

optima_x = [
0.00221758	1	2.04E-07	0.042726163
0.002241682	2	1.98E-07	0.030134416
0.002207566	7	2.13E-07	0.026825215
0.002039964	6	1.16E-07	0.035904783
0.002210821	9	2.27E-07	0.049808415
];
optima_y = [
0.978068516
0.967540048
0.947596047
0.918936267
0.895824142
];
categoricalVariablesArray_x = {'Q_T', 'N_p', 'd_d', 'd'};
categoricalVariablesArray_y = {'P'};
highDimensionalVisualisation2Dplot(LB_x, UB_x, optima_x, categoricalVariablesArray_x, LB_y, UB_y, optima_y, categoricalVariablesArray_y);
