%% Penetration as a function of bend radius

bendRadiusRange = (.01:.02:1);
DomainSizeX = size(bendRadiusRange);
final_i=DomainSizeX(2);
P = zeros(1,final_i);

parameters = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.1,1.5, .0254];

for i=1:final_i
    parameters(6) = bendRadiusRange(i);
    P(i) = bendTubePenetrationB(parameters,1);
end


figure
plot(bendRadiusRange,P)
%xlim([0 90])
title('Penetration')
xlabel('Bend radius (m)')
ylabel('Penetration (fraction)')


%% Penetration as a function of bend angle


bendAngleRange = (0:pi/20:1.5);
DomainSizeX = size(bendAngleRange);
final_i=DomainSizeX(2);
P = zeros(1,final_i);

parameters = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.1,pi/2, .0254];

for i=1:final_i
    parameters(7) = bendAngleRange(i);
    P(i) = bendTubePenetrationB(parameters,1);
end


figure
plot(bendAngleRange,P)
%xlim([0 90])
title('Penetration')
xlabel('Bend angle (rad)')
ylabel('Penetration (fraction)')
