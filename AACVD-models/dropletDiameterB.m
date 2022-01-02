%Droplet size ultrasonic atomization (droplets are produced by the flow of
%the liquid on a vibrating surface).

function dp = dropletDiameterB(x)

%Parameters = [Q, ro, mu, sigma, d, I, f]

%Test: alginate
%x = [7e-8,1004,0.088,0.07,1.016e-3,7.25e3,25000]

%% Constants
%Speed of sound in the medium (C) in m/s
%For water
C = 1485;

%% Parameters
%Fluid
%Fluid flow rate (Q)
Q = x(1);

%Fluid density (ro)
ro = x(2);

%Fluid dynamic viscosity (mu)
mu = x(3);

%Fluid surface tension (sigma)
sigma = x(4);

%Atomizer
%Jet diameter [primary atomization] (d), could be used to calculate canonical forms of dimensionless numbers;
d = x(5);

%Power surface intensity [defined as the ratio between the power (P) delivered at the surface and the area of vibrating surface (A)] (I)
I = x(6);

%Ultrasonic frequency (f)
f = x(7);

%% Model

%Fluid velocity (u)
%Fluid flow rate (Q)
%Jet diameter (d)
%u = (4*Q)/(pi*d^2); %This can be used to calculate the canonical form of the Ohnesorge number

%Reynolds number (Re)
%Fluid velocity (u)
%Jet diameter [primary atomization] or drop diameter [secondary atomization](d)
%Fluid density (ro)
%Fluid dynamic viscosity (mu)
%Re = (u*d*ro)/mu; %This can be used to calculate the canonical form of the Ohnesorge number

%Weber number (We)
%Fluid density (ro)
%Fluid velocity (u)
%Jet diameter [primary atomization] or drop diameter [secondary atomization](d)
%Fluid dynamic viscosity (mu)
%We = (ro*u^2*d)/mu; %this is the canonical form

%Weber number (We)
%Ultrasonic frequency (f)
%Fluid flow rate (Q)
%Fluid density (ro)
%Fluid surface tension (sigma)
We = (f*Q*ro)/sigma; %modified form

%Amplitude (Am)
%Power surface intensity [defined as the ratio between the power delivered at the surface (P) and the area of vibrating surface (A)] (I)
%Fluid density (ro)
%Speed of sound (C)
%Ultrasonic frequency (f)
Am = sqrt((2*I)/(ro*C))/(2*pi*f);

%Ohnesorge number (Oh)
%Weber number (We)
%Reynolds number (Re)
%Oh = sqrt(We)/Re; %this is the canonical form

%Ohnesorge number (Oh)
%Fluid dynamic viscosity (mu)
%Ultrasonic frequency (f)
%Amplitude (Am)
%Fluid density (ro)
Oh = mu/(f*Am^2*ro); %modified form

%Intensity number (In)
%Ultrasonic frequency (f)
%Amplitude (Am)
%Speed of sound (C)
%Flow rate (Q) CALCULATE THIS (given d and u)
In = (f^2*Am^4)/(C*Q);

%Droplet diameter (dp)
%Fluid surface tension (sigma)
%Fluid density (ro)
%Ultrasonic frequency (f)
%Weber number (We)
%Ohnesorge number (Oh)
%Intensity number (In)
dp = 0.00154*((pi*sigma)/(ro*f^2))^(.33)*(1 + ((pi*sigma)/(ro*f^2))^(-0.2)*We^0.154*Oh^(-0.111)*In^(-0.033));

end
