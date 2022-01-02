clc
clear
clf

%% Atomiser (0 m)

x0m_t1 = [1.16592 1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865];
y0m_t1 = [0 0.00162465	0.00630999	0.0139505	0.0246324	0.0378605	0.05268	0.0679156	0.0820712	0.093267	0.0998946	0.10089	0.0960041	0.0858303	0.0718629	0.0559761	0.0402178	0.0263162	0.0153551	0.00769492	0.00306199	0.000767871];

VectorSize_t1 = size(x0m_t1);
final_i_t1 = VectorSize_t1(2);
ErrorFraction_t1 = zeros(1,final_i_t1);
for i = 1:final_i_t1
    ErrorFraction_t1(i) = .0011*x0m_t1(i)^2 - .0044*x0m_t1(i) + .0472;
    if i > final_i_t1-3
        ErrorFraction_t1(i)=ErrorFraction_t1(17);
    end
end

x0m_t1_xpos = ErrorFraction_t1.*x0m_t1;
x0m_t1_xneg = ErrorFraction_t1.*x0m_t1;
y0m_t1_ypos = ErrorFraction_t1.*y0m_t1;
y0m_t1_yneg = ErrorFraction_t1.*y0m_t1;


% Create plot figure
figure1 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');
% Create plot
errorbar(x0m_t1,y0m_t1,y0m_t1_yneg,y0m_t1_ypos,x0m_t1_xneg,x0m_t1_xpos,'.','MarkerSize',35,'LineWidth',5)
% Create title
%title('Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
% set(gca,'FontSize',16)
% set(axes1,'FontSize',16,'XGrid','on','YGrid','on');
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
xlim([0 50.1])

hold on


%_________________________________________%

x0m_t2 = [1	1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108];
y0m_t2 = [0.00144209	0.00160115	0.00245789	0.00430279	0.00739085	0.011877	0.0177849	0.0250457	0.0335413	0.0430455	0.0531292	0.0631884	0.072502	0.080175	0.0852727	0.0869224	0.0845278	0.0779368	0.0675966	0.0545624	0.040329	0.0265492	0.0146923	0.00573451	1.93E-05];

VectorSize_t2 = size(x0m_t2);
final_i_t2 = VectorSize_t2(2);
ErrorFraction_t2 = zeros(1,final_i_t2);
for i = 1:final_i_t2
    ErrorFraction_t2(i) = .0013*x0m_t2(i)^2 - .0364*x0m_t2(i) + .3499;
    if i > final_i_t2-3
        ErrorFraction_t2(i)=ErrorFraction_t2(17);
    end
end

x0m_t2_xpos = ErrorFraction_t2.*x0m_t2;
x0m_t2_xneg = ErrorFraction_t2.*x0m_t2;
y0m_t2_ypos = ErrorFraction_t2.*y0m_t2;
y0m_t2_yneg = ErrorFraction_t2.*y0m_t2;

errorbar(x0m_t2,y0m_t2,y0m_t2_yneg,y0m_t2_ypos,x0m_t2_xneg,x0m_t2_xpos,'.','MarkerSize',35,'LineWidth',5)

%_________________________________________%

x0m_t3 = [0.857698	1	1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416	54.1171	63.0959	73.5644	85.7698	100	116.592	135.936	158.49	184.785	215.444];
y0m_t3 = [0	0.00121504	0.00476908	0.00953218	0.015674	0.0232222	0.0319788	0.0415085	0.0512456	0.0605958	0.0688734	0.0752645	0.0790573	0.0797384	0.0770953	0.0712927	0.0629403	0.0529373	0.0424212	0.0325249	0.0241352	0.0177465	0.0134106	0.0107969	0.00935605	0.0085102	0.00779558	0.00693953	0.0058679	0.00466532	0.00347222	0.00241174	0.00155048	0.000898218	0.000433323	0.000123743	0];

VectorSize_t3 = size(x0m_t3);
final_i_t3 = VectorSize_t3(2);
ErrorFraction_t3 = zeros(1,final_i_t3);
for i = 1:final_i_t3
    ErrorFraction_t3(i) = .001*x0m_t3(i)^2 - .008*x0m_t3(i) + .0455;
    if i > final_i_t3-15
        ErrorFraction_t3(i)=ErrorFraction_t3(17);
    end
end

x0m_t3_xpos = ErrorFraction_t3.*x0m_t3;
x0m_t3_xneg = ErrorFraction_t3.*x0m_t3;
y0m_t3_ypos = ErrorFraction_t3.*y0m_t3;
y0m_t3_yneg = ErrorFraction_t3.*y0m_t3;

errorbar(x0m_t3,y0m_t3,y0m_t3_yneg,y0m_t3_ypos,x0m_t3_xneg,x0m_t3_xpos,'.','MarkerSize',35,'LineWidth',5)



%_________________________________________%

x0m_t4 = [1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444	25.1189	29.2865	34.1456	39.8108	46.416];
y0m_t4 = [0.00153574	0.00188518	0.00349491	0.00666539	0.011514	0.0179446	0.0257375	0.0346377	0.0442759	0.0540886	0.0634356	0.0716302	0.0779284	0.0816001	0.0820273	0.0788344	0.0720217	0.0620668	0.0499244	0.0368897	0.0243722	0.0136194	0.00546275	0.000200072	0];
VectorSize_t4 = size(x0m_t4);
final_i_t4 = VectorSize_t4(2);
ErrorFraction_t4 = zeros(1,final_i_t4);
for i = 1:final_i_t4
    ErrorFraction_t4(i) = .0028*x0m_t4(i)^2 - .0752*x0m_t4(i) + .5648;
    if i > final_i_t4-5
        ErrorFraction_t4(i)=ErrorFraction_t4(17);
    end
end

x0m_t4_xpos = ErrorFraction_t4.*x0m_t4;
x0m_t4_xneg = ErrorFraction_t4.*x0m_t4;
y0m_t4_ypos = ErrorFraction_t4.*y0m_t4;
y0m_t4_yneg = ErrorFraction_t4.*y0m_t4;

errorbar(x0m_t4,y0m_t4,y0m_t4_yneg,y0m_t4_ypos,x0m_t4_xneg,x0m_t4_xpos,'.','MarkerSize',35,'LineWidth',5)

legend('Run #1','Run #2','Run #3','Run #4')

% print('Exp_LaserDiff_DropDistr_0m','-dpdf','-fillpage')


%_________________________________________%


% figure
% plot(x0m_t1, y0m_t1, '*')
% hold on
% plot(x0m_t2, y0m_t2, '.')
% plot(x0m_t3, y0m_t3, 'x')
% plot(x0m_t4, y0m_t4, '^')
% xlim([0 30])
% ylim([0 .17])

%% Pipe outlet (2 m)

x2m_t1 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444];
y2m_t1 = [0	0.00118501	0.00633839	0.016766	0.0329483	0.0540143	0.0779664	0.101528	0.120074	0.129435	0.127099	0.113193	0.0904932	0.0639763	0.0387762	0.018999	0.00647729	0.000730408	0];

VectorSize_t1 = size(x2m_t1);
final_i_t1 = VectorSize_t1(2);
ErrorFraction_t1 = zeros(1,final_i_t1);
for i = 1:final_i_t1
    ErrorFraction_t1(i) = .0005*x2m_t1(i)^2 - .0039*x2m_t1(i)+.0295;
    if i > final_i_t1 -2
        ErrorFraction_t1(i)=ErrorFraction_t1(17);
    end
end

x2m_t1_xpos = ErrorFraction_t1.*x2m_t1;
x2m_t1_xneg = ErrorFraction_t1.*x2m_t1;
y2m_t1_ypos = ErrorFraction_t1.*y2m_t1;
y2m_t1_yneg = ErrorFraction_t1.*y2m_t1;

% Create plot figure
figure2 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create axes
% axes2 = axes('Parent',figure2);
% hold(axes2,'on');
% Create plot
errorbar(x2m_t1,y2m_t1,y2m_t1_yneg,y2m_t1_ypos,x2m_t1_xneg,x2m_t1_xpos,'.','MarkerSize',35,'LineWidth',5)
% Create title
% title(''Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')
% set(gca,'FontSize',16)
% set(axes2,'FontSize',16,'XGrid','on','YGrid','on');

hold on





%_________________________________________%

x2m_t2 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444];
y2m_t2 = [0	0.00161572	0.00739954	0.0187156	0.0359017	0.0578258	0.0822045	0.105492	0.122934	0.130516	0.126057	0.110213	0.0862224	0.0593301	0.0346444	0.01598	0.00475656	0.000192326	0];

VectorSize_t2 = size(x2m_t2);
final_i_t2 = VectorSize_t2(2);
ErrorFraction_t2 = zeros(1,final_i_t2);
for i = 1:final_i_t2
    ErrorFraction_t2(i) = .0015*x2m_t2(i)^2 - .0171*x2m_t2(i) + .0544;
    if i > final_i_t2 -2
        ErrorFraction_t2(i)=ErrorFraction_t2(17);
    end
end

x2m_t2_xpos = ErrorFraction_t2.*x2m_t2;
x2m_t2_xneg = ErrorFraction_t2.*x2m_t2;
y2m_t2_ypos = ErrorFraction_t2.*y2m_t2;
y2m_t2_yneg = ErrorFraction_t2.*y2m_t2;

errorbar(x2m_t2,y2m_t2,y2m_t2_yneg,y2m_t2_ypos,x2m_t2_xneg,x2m_t2_xpos,'.','MarkerSize',35,'LineWidth',5)


%_________________________________________%

x2m_t3 = [1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444];
y2m_t3 = [0	0.000306505	0.00349208	0.0109619	0.0237232	0.0416026	0.0631349	0.0859689	0.106796	0.121447	0.126633	0.120758	0.104733	0.0816251	0.0561707	0.0329034	0.0152235	0.00445574	6.44E-05	0];

VectorSize_t3 = size(x2m_t3);
final_i_t3 = VectorSize_t3(2);
ErrorFraction_t3 = zeros(1,final_i_t3);
for i = 1:final_i_t3
    ErrorFraction_t3(i) = .0006*x2m_t3(i)^2 - .0077*x2m_t3(i) + .0368;
    if i > final_i_t3 -2
        ErrorFraction_t3(i)=ErrorFraction_t3(17);
    end
end

x2m_t3_xpos = ErrorFraction_t3.*x2m_t3;
x2m_t3_xneg = ErrorFraction_t3.*x2m_t3;
y2m_t3_ypos = ErrorFraction_t3.*y2m_t3;
y2m_t3_yneg = ErrorFraction_t3.*y2m_t3;

errorbar(x2m_t3,y2m_t3,y2m_t3_yneg,y2m_t3_ypos,x2m_t3_xneg,x2m_t3_xpos,'.','MarkerSize',35,'LineWidth',5)
xlim([0 20.1])
legend('Run #1','Run #2','Run #3')

print('Exp_LaserDiff_DropDistr_2m','-dpdf','-fillpage')


%_________________________________________%


% figure
% plot(x2m_t1, y2m_t1, 'b*')
% hold on
% plot(x2m_t1*1.1, y2m_t1*1.1, 'b*')
% plot(x2m_t1*.8, y2m_t1*1.8, 'b*')
% plot(x2m_t2, y2m_t2, 'b*')
% plot(x2m_t3, y2m_t3, 'b*')
% xlim([0 30])
% ylim([0 .17])

%% Pipe outlet (4 m)

x4m_t1 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
y4m_t1 = [0	0.000654907	0.00438776	0.014305	0.032826	0.0599987	0.0929041	0.125199	0.147619	0.152597	0.137511	0.106845	0.0698941	0.0370644	0.0146205	0.00343451	0.000138004	0];

VectorSize_t1 = size(x4m_t1);
final_i_t1 = VectorSize_t1(2);
ErrorFraction_t1 = zeros(1,final_i_t1);
for i = 1:final_i_t1
    ErrorFraction_t1(i) = .0012*x4m_t1(i)^2 - .0173*x4m_t1(i) + .0766;
    if i > final_i_t1 -2
        ErrorFraction_t1(i)=ErrorFraction_t1(17);
    end
end

x4m_t1_xpos = ErrorFraction_t1.*x4m_t1;
x4m_t1_xneg = ErrorFraction_t1.*x4m_t1;
y4m_t1_ypos = ErrorFraction_t1.*y4m_t1;
y4m_t1_yneg = ErrorFraction_t1.*y4m_t1;


% Create plot figure
figure3 =  figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create axes
% axes3 = axes('Parent',figure3);
% hold(axes3,'on');
% Create plot
errorbar(x4m_t1,y4m_t1,y4m_t1_yneg,y4m_t1_ypos,x4m_t1_xneg,x4m_t1_xpos,'.','MarkerSize',35,'LineWidth',5)
% Create title
% title(''Droplet size distribution: 4 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
% set(gca,'FontSize',16)
% set(axes3,'FontSize',16,'XGrid','on','YGrid','on');
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

hold on



%_________________________________________%


x4m_t2 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785	21.5444];
y4m_t2 = [0	0.000469473	0.00442391	0.013733	0.0293797	0.0508769	0.0763393	0.102248	0.123294	0.134426	0.132479	0.117422	0.0925165	0.063672	0.0368963	0.0167396	0.00486236	0.000222075	0];


VectorSize_t2 = size(x4m_t2);
final_i_t2 = VectorSize_t2(2);
ErrorFraction_t2 = zeros(1,final_i_t2);
for i = 1:final_i_t2
    ErrorFraction_t2(i) = .0004*x4m_t2(i)^2 - .0011*x4m_t2(i) + .0148;
    if i > final_i_t2 -2
        ErrorFraction_t2(i)=ErrorFraction_t2(17);
    end
end

x4m_t2_xpos = ErrorFraction_t2.*x4m_t2;
x4m_t2_xneg = ErrorFraction_t2.*x4m_t2;
y4m_t2_ypos = ErrorFraction_t2.*y4m_t2;
y4m_t2_yneg = ErrorFraction_t2.*y4m_t2;

errorbar(x4m_t2,y4m_t2,y4m_t2_yneg,y4m_t2_ypos,x4m_t2_xneg,x4m_t2_xpos,'.','MarkerSize',35,'LineWidth',5)

%_________________________________________%

x4m_t3 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
y4m_t3 = [0	0.000151206	0.00178518	0.00729947	0.0195332	0.0404725	0.070031	0.10464	0.13605	0.154358	0.152433	0.129826	0.0935727	0.0554642	0.0254242	0.00789262	0.00106653	0];

VectorSize_t3 = size(x4m_t3);
final_i_t3 = VectorSize_t3(2);
ErrorFraction_t3 = zeros(1,final_i_t3);
for i = 1:final_i_t3
    ErrorFraction_t3(i) = .0008*x4m_t3(i)^2 - .0126*x4m_t3(i) + .0716;
    if i > final_i_t3 -2
        ErrorFraction_t3(i)=ErrorFraction_t3(17);
    end
end

x4m_t3_xpos = ErrorFraction_t3.*x4m_t3;
x4m_t3_xneg = ErrorFraction_t3.*x4m_t3;
y4m_t3_ypos = ErrorFraction_t3.*y4m_t3;
y4m_t3_yneg = ErrorFraction_t3.*y4m_t3;

errorbar(x4m_t3,y4m_t3,y4m_t3_yneg,y4m_t3_ypos,x4m_t3_xneg,x4m_t3_xpos,'.','MarkerSize',35,'LineWidth',5)
xlim([0 18.1])
%ylim ([0 .14])
legend('Run #1','Run #2','Run #3')

print('Exp_LaserDiff_DropDistr_4m','-dpdf','-fillpage')


%_________________________________________%



% figure
% plot(x4m_t1, y4m_t1, '*')
% hold on
% plot(x4m_t2, y4m_t2, '.')
% plot(x4m_t3, y4m_t3, 'x')
% xlim([0 30])
% ylim([0 .17])


%% Pipe outlet (8 m)

x8m_t1 = [1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849];
y8m_t1 = [0	2.93E-06	0.000164198	0.00147153	0.00683134	0.0216273	0.0519311	0.0995173	0.155015	0.194743	0.193997	0.148926	0.0844189	0.0328373	0.0077186	0.000790093	9.13E-06	0];

VectorSize_t1 = size(x8m_t1);
final_i_t1 = VectorSize_t1(2);
ErrorFraction_t1 = zeros(1,final_i_t1);
for i = 1:final_i_t1
    ErrorFraction_t1(i) = .0019*x8m_t1(i)^2 - .0138*x8m_t1(i) + .0304;
    if i > final_i_t1 -2
        ErrorFraction_t1(i)=ErrorFraction_t1(17);
    end
end

x8m_t1_xpos = ErrorFraction_t1.*x8m_t1;
x8m_t1_xneg = ErrorFraction_t1.*x8m_t1;
y8m_t1_ypos = ErrorFraction_t1.*y8m_t1;
y8m_t1_yneg = ErrorFraction_t1.*y8m_t1;


% Create plot figure
figure4 = figure('PaperOrientation','landscape','WindowState','maximized','Color',[1 1 1]);
set(axes,'Position',[0.13 0.226799515091938 0.514791666666667 0.67677484787018]);
% Create axes
% axes4 = axes('Parent',figure4);
% hold(axes4,'on');
% Create plot
errorbar(x8m_t1,y8m_t1,y8m_t1_yneg,y8m_t1_ypos,x8m_t1_xneg,x8m_t1_xpos,'.','MarkerSize',35,'LineWidth',5)
% Create title
% title(''Droplet size distribution: 8 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
% set(gca,'FontSize',16)
% set(axes4,'FontSize',16,'XGrid','on','YGrid','on');
set(gca,'FontSize', 27,'FontName','Times New Roman','XGrid','on','YGrid','on')

hold on


%_________________________________________%

x8m_t2 = [1.16592	1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
y8m_t2 = [0	2.13E-07	0.000109745	0.00112946	0.00531871	0.0167339	0.0400275	0.0775343	0.124924	0.167166	0.18458	0.166074	0.119005	0.0651588	0.0255258	0.00613122	0.000581558	3.12E-07	0];

VectorSize_t2 = size(x8m_t2);
final_i_t2 = VectorSize_t2(2);
ErrorFraction_t2 = zeros(1,final_i_t2);
for i = 1:final_i_t2
    ErrorFraction_t2(i) = .0007*x8m_t2(i)^2 - .0064*x8m_t2(i) + .0295;
    if i > final_i_t2 -2
        ErrorFraction_t2(i)=ErrorFraction_t2(17);
    end
end

x8m_t2_xpos = ErrorFraction_t2.*x8m_t2;
x8m_t2_xneg = ErrorFraction_t2.*x8m_t2;
y8m_t2_ypos = ErrorFraction_t2.*y8m_t2;
y8m_t2_yneg = ErrorFraction_t2.*y8m_t2;

errorbar(x8m_t2,y8m_t2,y8m_t2_yneg,y8m_t2_ypos,x8m_t2_xneg,x8m_t2_xpos,'.','MarkerSize',35,'LineWidth',5)

%_________________________________________%



x8m_t3 = [1.35936	1.5849	1.84785	2.15444	2.51189	2.92865	3.41456	3.98108	4.6416	5.41171	6.30959	7.35644	8.57698	10	11.6592	13.5936	15.849	18.4785];
y8m_t3 = [0	1.82E-05	0.000412955	0.00280376	0.0110827	0.0310555	0.067549	0.118592	0.168712	0.193866	0.17793	0.12751	0.0684206	0.0257194	0.00580759	0.000519143	1.02E-06	0];

VectorSize_t3 = size(x8m_t3);
final_i_t3 = VectorSize_t3(2);
ErrorFraction_t3 = zeros(1,final_i_t3);
for i = 1:final_i_t3
    ErrorFraction_t3(i) = .0006*x8m_t3(i)^2 - .0053*x8m_t3(i) + .0252;
    if i > final_i_t3 -2
        ErrorFraction_t3(i)=ErrorFraction_t3(17);
    end
end

x8m_t3_xpos = ErrorFraction_t3.*x8m_t3;
x8m_t3_xneg = ErrorFraction_t3.*x8m_t3;
y8m_t3_ypos = ErrorFraction_t3.*y8m_t3;
y8m_t3_yneg = ErrorFraction_t3.*y8m_t3;

errorbar(x8m_t3,y8m_t3,y8m_t3_yneg,y8m_t3_ypos,x8m_t3_xneg,x8m_t3_xpos,'.','MarkerSize',35,'LineWidth',5)
xlim([0 15])
xticks([0 3 6 9 12 15])
legend('Run #1','Run #2','Run #3')

print('Exp_LaserDiff_DropDistr_8m','-dpdf','-fillpage')


%_________________________________________%


% figure
% plot(x8m_t1, y8m_t1, '*')
% hold on
% plot(x8m_t2, y8m_t2, '.')
% plot(x8m_t3, y8m_t3, 'x')
% xlim([0 30])
% ylim([0 .17])



%% Parameters

%The pipe diameter is 1 cm diameter of the bulk of the coil is approx. 20 cm
d = 0.01;
coilDiameter = 0.2;
phi = atan(d/coilDiameter);

%parametersInclined = [T, ro, Q, mu, ro_d, mu_d, dd, d, phi, L];
%Methanol at 25�C
parametersInclined = [298.15, 1.17, 3.3333e-5, 1.85e-5, 786.6, 5.47e-4, 0, d, phi, 0];

%parametersBend = [T, Q, mu, ro_d, dd, Rb, theta, d];
%Methanol at 25�C
parametersBend = [298.15, 3.3333e-5, 1.85e-5, 786.6, 0, coilDiameter/2, pi/2, d];

%Experimental lengths were 2, 8 and 50 meters
%CHANGE HERE ACCORDING TO SECTION BELOW BEING RUN
length = 2;
numberOfTurns = length/(pi*coilDiameter);
parametersInclined(10) = length;


%% Model testing: atomiser experimental input (0 m) vs 2 m coil experimental  output

% Unifying data from all four trials for 0 m (atomiser outlet)
x0m_all_data = [x0m_t1 x0m_t2 x0m_t3 x0m_t4];
y0m_all_data = [y0m_t1 y0m_t2 y0m_t3 y0m_t4];

% Create plot figure for scatter atomiser outlet data
figure5 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes5 = axes('Parent',figure5);
hold(axes5,'on');
% Create plot
scatter(x0m_all_data,y0m_all_data, 100, 'LineWidth', 3)
% Create title
% title(''Droplet size distribution: atomiser output')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
xlim([0 50])
set(gca,'FontSize',16)
set(axes5,'FontSize',16,'XGrid','on','YGrid','on')



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x0m_all_data*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y0m_all_data.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2.5;



% Create plot figure to plot the model 2 m output and the experimental 2 m output
figure6 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes6 = axes('Parent',figure6);
hold(axes6,'on');
% Create plot
% Model 2 m output
scatter(x0m_all_data,ddDistr_um,15,'filled','blue')
% Create title
% title(''Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes6,'FontSize',16,'XGrid','on','YGrid','on');
hold on

% Experimental 2 m output
x2m_all_data = [x2m_t1 x2m_t2 x2m_t3];
y2m_all_data = [y2m_t1 y2m_t2 y2m_t3];
scatter(x2m_all_data,y2m_all_data,15,'filled','black')
xlim([0 20])
legend('Model','Experiment')


%% Model testing: 2 m coil experimental input vs 4 m coil experimental output


% Unifying data from all four trials for 0 m (atomiser outlet)
x2m_all_data = [x2m_t1 x2m_t2 x2m_t3];
y2m_all_data = [y2m_t1 y2m_t2 y2m_t3];

% Create plot figure for scatter atomiser outlet data
figure7 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes7 = axes('Parent',figure7);
hold(axes7,'on');
% Create plot
scatter(x2m_all_data,y2m_all_data, 33,[0.850980401039124 0.325490206480026 0.0980392172932625], 'filled')
% Create title
%title('Droplet size distribution: 2 m coiled tubing inlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
set(gca,'FontSize',16)
set(axes7,'FontSize',16,'XGrid','on','YGrid','on');
%legend('Experiment')
xlim([0 20])
ylim([0 .18])

print('Exp_LaserDiff_DropDistr_2m_model_inlet','-dpdf','-fillpage')



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_all_data*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_all_data.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*1.5;


fracExpIN1 = trapz(x2m_t1,y2m_t1);
fracExpIN2 = trapz(x2m_t2,y2m_t2);
fracExpIN3 = trapz(x2m_t3,y2m_t3);

%1:19, 20:38,38:58
fracModelOUT1 = trapz(x2m_all_data(1:19),ddDistr_um(1:19));
fracModelOUT1median = trapz(x2m_all_data(1:10),ddDistr_um(1:10)); %about 5.4 um
fracModelOUT2 = trapz(x2m_all_data(20:38),ddDistr_um(20:38));
fracModelOUT3 = trapz(x2m_all_data(38:58),ddDistr_um(38:58));

fracExpOUT1 = trapz(x4m_t1,y4m_t1);
fracExpOUT1median = trapz(x4m_t1(1:11),y4m_t1(1:11)); %about 6 um
fracExpOUT2 = trapz(x4m_t2,y4m_t2);
fracExpOUT3 = trapz(x4m_t3,y4m_t3);


% Create plot figure to plot the model 2 m output and the experimental 2 m output
figure8 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes8 = axes('Parent',figure8);
hold(axes8,'on');
% Create plot
% Model 2 m output
scatter(x2m_all_data,ddDistr_um,33,'filled','^')
% Create title
%title('Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes8,'FontSize',16,'XGrid','on','YGrid','on');
hold on

% Experimental 4 m output
x4m_all_data = [x4m_t1 x4m_t2 x4m_t3];
y4m_all_data = [y4m_t1 y4m_t2 y4m_t3];
scatter(x4m_all_data,y4m_all_data,33,'filled')
xlim([0 20])
ylim([0 .20])

legend('Model output','Experimental output')

print('Exp_LaserDiff_DropDistr_4m_model&exp_outlet','-dpdf','-fillpage')


%% Model testing: atomiser experimental input (0 m) vs 8 m coil experimental output


% Unifying data from all four trials for 0 m (atomiser outlet)
x0m_all_data = [x0m_t1 x0m_t2 x0m_t3 x0m_t4];
y0m_all_data = [y0m_t1 y0m_t2 y0m_t3 y0m_t4];


% Create plot figure for scatter atomiser outlet data
figure7 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes7 = axes('Parent',figure7);
hold(axes7,'on');
% Create plot
scatter(x0m_all_data,y0m_all_data, 33,[0.850980401039124 0.325490206480026 0.0980392172932625], 'filled')
% Create title
%title('Droplet size distribution: 2 m coiled tubing inlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
set(gca,'FontSize',16)
set(axes7,'FontSize',16,'XGrid','on','YGrid','on');
%legend('Experiment')
%xlim([0 20])
%ylim([0 .18])

xlim([0 50])
ylim([0 .12])

print('Exp_LaserDiff_DropDistr_2m_model_inlet','-dpdf','-fillpage')



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x0m_all_data*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y0m_all_data.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*3;


fracExpIN1 = trapz(x2m_t1,y2m_t1);
fracExpIN2 = trapz(x2m_t2,y2m_t2);
fracExpIN3 = trapz(x2m_t3,y2m_t3);

%1:19, 20:38,38:58
fracModelOUT1 = trapz(x0m_all_data(1:19),ddDistr_um(1:19));
fracModelOUT1median = trapz(x0m_all_data(1:10),ddDistr_um(1:10)); %about 5.4 um
fracModelOUT2 = trapz(x0m_all_data(20:38),ddDistr_um(20:38));
fracModelOUT3 = trapz(x0m_all_data(38:58),ddDistr_um(38:58));

fracExpOUT1 = trapz(x4m_t1,y4m_t1);
fracExpOUT1median = trapz(x4m_t1(1:11),y4m_t1(1:11)); %about 6 um
fracExpOUT2 = trapz(x4m_t2,y4m_t2);
fracExpOUT3 = trapz(x4m_t3,y4m_t3);


% Create plot figure to plot the model 0 m input and the experimental 8 m output
figure8 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes8 = axes('Parent',figure8);
hold(axes8,'on');
% Create plot
% Model 2 m output
scatter(x0m_all_data,ddDistr_um,33,'filled','^')
% Create title
%title('Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes8,'FontSize',16,'XGrid','on','YGrid','on');
hold on

% Experimental 8 m output
x4m_all_data = [x8m_t1 x8m_t2 x8m_t3];
y4m_all_data = [y8m_t1 y8m_t2 y8m_t3];
scatter(x4m_all_data,y4m_all_data,33,'filled')
xlim([0 20])
ylim([0 .20])

legend('Model output','Experimental output')

print('Exp_LaserDiff_DropDistr_8m_model&exp_outlet','-dpdf','-fillpage')


%% Model testing: 2 m input vs 8 m coil experimental output


% Unifying data from all four trials for 0 m (atomiser outlet)
x0m_all_data = [x0m_t1 x0m_t2 x0m_t3 x0m_t4];
y0m_all_data = [y0m_t1 y0m_t2 y0m_t3 y0m_t4];

x2m_all_data = [x2m_t1 x2m_t2 x2m_t3];
y2m_all_data = [y2m_t1 y2m_t2 y2m_t3];


% Create plot figure for scatter atomiser outlet data
figure7 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes7 = axes('Parent',figure7);
hold(axes7,'on');
% Create plot
scatter(x2m_all_data,y2m_all_data, 33,[0.850980401039124 0.325490206480026 0.0980392172932625], 'filled')
% Create title
%title('Droplet size distribution: 2 m coiled tubing inlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
set(gca,'FontSize',16)
set(axes7,'FontSize',16,'XGrid','on','YGrid','on');
%legend('Experiment')
%xlim([0 20])
%ylim([0 .18])

xlim([0 50])
ylim([0 .12])

print('Exp_LaserDiff_DropDistr_2m_model_inlet','-dpdf','-fillpage')



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_all_data*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_all_data.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2.5;


fracExpIN1 = trapz(x2m_t1,y2m_t1);
fracExpIN2 = trapz(x2m_t2,y2m_t2);
fracExpIN3 = trapz(x2m_t3,y2m_t3);

%1:19, 20:38,38:58
fracModelOUT1 = trapz(x2m_all_data(1:19),ddDistr_um(1:19));
fracModelOUT1median = trapz(x2m_all_data(1:10),ddDistr_um(1:10)); %about 5.4 um
fracModelOUT2 = trapz(x2m_all_data(20:38),ddDistr_um(20:38));
fracModelOUT3 = trapz(x2m_all_data(38:58),ddDistr_um(38:58));

fracExpOUT1 = trapz(x4m_t1,y4m_t1);
fracExpOUT1median = trapz(x4m_t1(1:11),y4m_t1(1:11)); %about 6 um
fracExpOUT2 = trapz(x4m_t2,y4m_t2);
fracExpOUT3 = trapz(x4m_t3,y4m_t3);


% Create plot figure to plot the model 0 m input and the experimental 8 m output
figure8 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes8 = axes('Parent',figure8);
hold(axes8,'on');
% Create plot
% Model 2 m output
scatter(x2m_all_data,ddDistr_um,33,'filled','^')
% Create title
%title('Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes8,'FontSize',16,'XGrid','on','YGrid','on');
hold on

% Experimental 8 m output
x4m_all_data = [x8m_t1 x8m_t2 x8m_t3];
y4m_all_data = [y8m_t1 y8m_t2 y8m_t3];
scatter(x4m_all_data,y4m_all_data,33,'filled')
xlim([0 20])
ylim([0 .20])

legend('Model output','Experimental output')

print('Exp_LaserDiff_DropDistr_4m_model&exp_outlet','-dpdf','-fillpage')




%% Cloud plot for experimental results (x4m_t1,y4m_t1)


% Create plot figure to plot the cloud
figure9 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes9 = axes('Parent',figure9);
hold(axes9,'on');

p = polyfit(x4m_t1,y4m_t1,9);
number_of_points = 1000;
x1 = linspace(1.4,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (700*y1).^2;

colour = [0.45 0.55 0.95];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')

% Create title
% title(''Droplet size cloud distribution: 2 m coiled tubing outlet experiment')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes9,'FontSize',16,'XGrid','on','YGrid','on');
xlim([0 13.1])
ylim([0 .19])

print('Exp_LaserDiff_DropDistr_4m_exp_cloud','-dpdf','-fillpage')

%% Cloud plot for model results obtained inputting (x2m_t1, y2m_t1)


% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_t1*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_t1.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2;

% Create plot figure to plot the cloud
figure10 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes10 = axes('Parent',figure10);
hold(axes10,'on');

p = polyfit(x2m_t1,ddDistr_um,9);
number_of_points = 1000;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (500*y1).^2;

colour = [.95 .95 .95];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')

% Create title
% title(''Droplet size cloud distribution: 2 m coiled tubing outlet model')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes10,'FontSize',16,'XGrid','on','YGrid','on');
xlim([0 13.1])
ylim([0 .19])

print('Exp_LaserDiff_DropDistr_4m_model_cloud','-dpdf','-fillpage')




%% Clouds superposition (model and experiment) for a 2 m equivalent coiled pipe (x2m_t1 to x4m_t1). Model front
% Create plot figure to plot the cloud
figure11 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes11 = axes('Parent',figure11);
hold(axes11,'on');

p = polyfit(x4m_t1,y4m_t1,9);
number_of_points = 1000;
x1 = linspace(1.4,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (700*y1).^2;

colour = [0.45 0.55 0.95];
%colour = [0.2 0.3 0.4];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')

% Create title
% title('Droplet size cloud distribution: 2 m coiled tubing outlet model and experiment')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes11,'FontSize',16,'XGrid','on','YGrid','on');
xlim([0 13.1])
ylim([0 .19])



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_t1*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_t1.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2;

p = polyfit(x2m_t1,ddDistr_um,9);
number_of_points = 1000;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (500*y1).^2;

colour = [.95 .95 .95];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')

print('Exp_LaserDiff_DropDistr_4m_exp&model_clouds_modFront','-dpdf','-fillpage')


%% Clouds superposition (model and experiment) for a 2 m equivalent coiled pipe (x2m_t1 to x4m_t1) Experiment front
% Create plot figure to plot the cloud
figure12 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes12 = axes('Parent',figure12);
hold(axes12,'on');


% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_t1*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_t1.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2;

p = polyfit(x2m_t1,ddDistr_um,9);
number_of_points = 1000;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (500*y1).^2;

colour = [.95 .95 .95];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')



% Create title
% title(''Droplet size cloud distribution: 2 m coiled tubing outlet experiment and model')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes12,'FontSize',16,'XGrid','on','YGrid','on');
xlim([0 13.1])
ylim([0 .19])




p = polyfit(x4m_t1,y4m_t1,9);
number_of_points = 1000;
x1 = linspace(1.4,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (700*y1).^2;

colour = [0.45 0.55 0.95];
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled')

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled')

print('Exp_LaserDiff_DropDistr_4m_exp&model_clouds_expFront','-dpdf','-fillpage')



%% Clouds superposition (model and experiment) for a 2 m equivalent coiled pipe (x2m_t1 to x4m_t1). Model front. Transparency added
% Create plot figure to plot the cloud
figure13 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes13 = axes('Parent',figure13);
hold(axes13,'on');

p = polyfit(x4m_t1,y4m_t1,9);
number_of_points = 300;
x1 = linspace(1.4,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (700*y1).^2;

colour = [0.45 0.55 0.95];
%colour = [0.2 0.3 0.4];
alpha = .1;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)

% Create title
% title('Droplet size cloud distribution: 2 m coiled tubing outlet model and experiment')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes13,'FontSize',16,'XGrid','on','YGrid','on');
xlim([0 13.1])
ylim([0 .19])



% Experimental data for the droplet distribution after atomisation will be inputted into the model
dd = x2m_t1*1e-6;

%Checking the number of entries in the vector holding droplet diameter values
DomainSizeX = size(dd);
final_i=DomainSizeX(2);
P = zeros(1,final_i); %memory allocation

%For each droplet diameter, the penetration is calculated
for i=1:final_i
    parametersInclined(7) = dd(i);
    parametersBend(5) = dd(i);
    P(i) = bendTubePenetrationB(parametersBend,2)^(4*numberOfTurns)*(-straightTubePenetrationA(parametersInclined));
end

%Using the penetration for each droplet diameter, the distribution is updated
ddDistr = y2m_t1.*P;
ddDistr_um = ddDistr;
% Normalising the results (area under probability density plot must be unitary)
ddDistr_um=ddDistr_um*2;

p = polyfit(x2m_t1,ddDistr_um,9);
%number_of_points = 500;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

ScatterSize = (500*y1).^2;

colour = [.95 .95 .95];
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)

colour = colour*.9;
ScatterSize=ScatterSize/2;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)

colour = colour*.9;
ScatterSize=ScatterSize/5;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)

colour = colour*.9;
ScatterSize=ScatterSize/10;
scatter(x1,y1,ScatterSize,colour, 'filled', 'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)

print('Exp_LaserDiff_DropDistr_4m_exp&model_clouds_modFront_transp','-dpdf','-fillpage')



%% Tests!


% Create plot figure to plot the model 2 m output and the experimental 2 m output
figure9 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% Create axes
axes9 = axes('Parent',figure9);
hold(axes9,'on');
% Create plot
% Model 2 m output
%scatter(x2m_all_data,ddDistr_um,'LineWidth',2)
%plot(x2m_all_data(1:19),ddDistr_um(1:19))
xFirstSet = x2m_all_data(1:19);
yFirstSet = ddDistr_um(1:19);

p = polyfit(xFirstSet,yFirstSet,9);
number_of_points = 1000;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1)

% kk = [1.5	1.7	2	3	4.73	6	8	10	12	14];
% kkk = [20	20	500	5000	8000	5000	500	20	20	20];
% p2 = polyfit(kk,kkk,8);
% 11 = linspace(1.7,12,number_of_points);
% y11 = polyval(p2,x11);
% for i=1:number_of_points
%     if y11(i) < 20
%         y11(i) = 20;
%     end
% end

%FANTASTIC!!!NOW I JUST CHECK THE AREA=1 and bingo!
y11 = 300*y1;
y11 = y11.^2;

colour = [.95 .95 .95];
scatter(x1,y1,y11,colour, 'filled')

colour = [.9 .9 .9];
y11=y11/5;
scatter(x1,y1,y11,colour, 'filled')

colour = [.87 .87 .87];
y11=y11/10;
scatter(x1,y1,y11,colour, 'filled')

colour = [.84 .84 .84];
y11=y11/20;
scatter(x1,y1,y11,colour, 'filled')

% colour = [.8 .8 .8];
% for i = 1:number_of_points
%     if i < (number_of_points/2)
%         scatter(x1(i),y1(i),30+i, colour, 'filled')
%     else
%         scatter(x1(i),y1(i),number_of_points-i, colour, 'filled')
%     end
% end


% for i = 1:number_of_points
%     if i < (number_of_points/2)
%         scatter(x1(i),y1(i),30+i)
%     else
%         scatter(x1(i),y1(i),number_of_points-i)
%     end
% end




%plot(x2m_all_data, ddDistr_um)


% Create title
% title(''Droplet size distribution: 2 m coiled tubing outlet')
% Create xlabel
xlabel('Droplet diameter [{\mu}m]')
% Create ylabel
ylabel('Frequency')
%axis([0 7 -.01 .01])
set(gca,'FontSize',16)
set(axes9,'FontSize',16,'XGrid','on','YGrid','on');
hold on

% % Experimental 4 m output
% x4m_all_data = [x4m_t1 x4m_t2 x4m_t3];
% y4m_all_data = [y4m_t1 y4m_t2 y4m_t3];
% scatter(x4m_all_data,y4m_all_data,'LineWidth',2)
% xlim([0 15])
% ylim([0 .2])
%
% legend('Model','Experiment')
%
% print('tesssssssstttt','-dpdf','-fillpage')



%x4m_all_data = [x4m_t1 x4m_t2 x4m_t3];
%y4m_all_data = [y4m_t1 y4m_t2 y4m_t3];

p = polyfit(x4m_t1,y4m_t1,9);
number_of_points = 1000;
x1 = linspace(1.6,14,number_of_points);
y1 = polyval(p,x1);
%plot(x1,y1);

y11 = 700*y1;
y11 = y11.^2;

colour = [0.45 0.55 0.95];
scatter(x1,y1,y11,colour, 'filled')

colour = colour*.9;
y11=y11/5;
scatter(x1,y1,y11,colour, 'filled')

colour = colour*.9;
y11=y11/10;
scatter(x1,y1,y11,colour, 'filled')

colour = colour*.9;
y11=y11/20;
scatter(x1,y1,y11,colour, 'filled')








%% stuff

%errorbar(x2m_t1,y2m_t1,y2m_t1_yneg,y2m_t1_ypos,x2m_t1_xneg,x2m_t1_xpos,'.','MarkerSize',35,'LineWidth',5)

% %figure5 = figure('PaperOrientation','landscape','Color',[1 1 1]);
% figure(figure2)
% %Plotting the outlet distribution
% plot(dd_um,ddDistr_um)
% hold on
% plot(dd_um, y0m_t1)
% % title('Droplet distribution before and after 2 m coiled tubing')
% % xlabel('Droplet diameter [{\mu}m]')
% % ylabel('Frequency')
% % xlim([0 30])


%Integral in the outlet distribution (less than one, given the loss)
%fracOUT = trapz(dd_um,ddDistr);
