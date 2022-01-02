%Droplet size ultrasonic atomization (droplets are produced by the flow of
%the liquid on a vibrating surface).

function dp = dropletDiameterA(x)

%Test: alginate
%x = [0.07,1004,25000]

%% Parameters
%Fluid
%Fluid surface tension (sigma)
sigma = x(1);

%Fluid density (ro)
ro = x(2);

%Atomizer
%Ultrasonic frequency (f)
f = x(3);

%% Model
%Droplet diameter (dp)
%Fluid surface tension (sigma)
%Fluid density (ro)
%Ultrasonic frequency (f)
dp = 0.34*((8*pi*sigma)/(ro*f^2))^(1/3);


end
