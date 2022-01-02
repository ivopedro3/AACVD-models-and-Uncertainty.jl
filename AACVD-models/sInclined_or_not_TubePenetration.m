clear
clc

l=0.1;
h=0.1;
lengthRange = (.01:0.01:5);
heightRange = (.01:0.01:5);

[X,Y] = meshgrid(lengthRange,heightRange);

DomainSize = size(X);
final_i=DomainSize(1);
final_j=DomainSize(2);

Inclined = zeros(DomainSize(1));
Straight = zeros(DomainSize(2));
x=0;
for i=1:final_i
    for j=1:final_j
        [Inclined(i,j), Straight(i,j)] = inclined_or_not_TubePenetration(X(i,j),Y(i,j));
        if (Inclined(i,j)<Straight(i,j))
            x=x+1;
        end
    end
end




% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create surface
surface('Parent',axes1,'ZData',Inclined,'YData',Y,'XData',X,'LineStyle','none','CData',Inclined);
surface('Parent',axes1,'ZData',Straight,'YData',Y,'XData',X,'LineStyle','none','CData',Straight);
view(3) %sets the default three-dimensional view
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16,'XAxisLocation','origin','YAxisLocation','origin');
%xlim([0 90])
%title('Aerosol penetration fraction as a function of horizontal and vertical distances')
xlabel('Length (m)','Rotation',-22)
ylabel('Height (m)','Rotation',22)
zlabel('Penetration (fraction)')
