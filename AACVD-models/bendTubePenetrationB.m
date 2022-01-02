%particle penetration through tubing

function P = bendTubePenetrationB(x,option)

%Goal: P = penetration = C/C0 = ratio between the aerosol content at distance x and initial one

% T is the temperature
% Q is the fluid flow rate
% mu is the carrier fluid dynamic viscosity
% ro_d is the droplet density
% dd is the droplet diameter
% Rb is the bend radius (see figure above)
% theta is the bend angle (see figure above)
% d is the pipe diameter

%parameters = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parameters = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.5,pi/2, .0254]

%% Constants
%Boltzmann constant (k) SI units: m2 kg s-2 K-1
k = 1.38064852e-23;

%% Parameters
%Carrier fluid
%Carrier fluid temperature (T) SI units: K
T = x(1);

%Carrier fluid flow rate (Q) SI units: m3 s-1
Q = x(2);

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
mu = x(3);

%Droplets
%Droplet density (ro_d) SI units: kg m-3
ro_d = x(4);

%Droplet diameter (dd) SI units: m
dd = x(5);

%Tube
%Radius of the bend (Rb) SI units: m
Rb = x(6);

%Bend angle (theta) SI units: radians
theta = x(7);

%Tube inner diameter (d) SI units: m
d = x(8);


%% Aerosol penetration (P)

%Tube inner radius (d) SI units: m
%Tube inner diameter (d) SI units: m
Rt = d/2;

%Curvature ratio (Ro) SI units: dimensionless
%Radius of the bend (Rb) SI units: m
%Tube inner radius (Rt) SI units: m
Ro = Rb/Rt;

%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m
U = 4*Q/(pi*d^2);

%Cunningham slip correction (C)
%Mean free path of the carrier fluid (lambda)
%For air at std T and P: lambda = .067e-6;
%Avarege internal pressure (p) SI units: Pa
p=101325;
MM=28.97/(1000*6.02214179e23); %average molar mass air
%Model for the mean free path of the carrier fluid (lambda)
lambda = (mu/p)*sqrt((pi*k*T)/(2*MM));
%Droplet diameter (dd) SI units: m
C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*dd/lambda));

%Droplet relaxation time (td) SI units: s
%Cunningham slip correction (C) SI units: dimensionless
%Droplet density (ro_d) SI units: kg m-3
%Droplet diameter (dd) SI units: m
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
td = (C*ro_d*dd^2)/(18*mu);

%Stokes number (Stk) SI units: dimensionless
%Droplet relaxation time (t)
%Fluid flow mean velocity (U) SI units: m s-1
%Tube inner diameter (d) SI units: m
Stk = (2*td*U)/(d);

if (option == 1)
    %Model parameters (K, A and B). No clear physical meaning.
    K = 4*Stk/Ro;
    A = sqrt((1+sqrt(1+K^2))/2);
    B = K/(2*A);


    %Dimensionless coordinates (xi, eta) as a function of dimensionless time (tau)
    xi = @(tau)(cos(B*tau)*(cosh(A*tau)+(A^3/(A^2+B^2))*sinh(A*tau))-(B^3*sin(B*tau)*cosh(A*tau))/(A^2+B^2));
    eta = @(tau)(sin(B*tau)*(sinh(A*tau)+(A^3/(A^2+B^2))*cosh(A*tau))+(B^3*cos(B*tau)*sinh(A*tau))/(A^2+B^2));


    %The equations for xi and eta and the equations below are numerically unstable. Therefore, the next calculations will be performed symbolically. The last step will be the conversion from symbolic variable to double.
    syms tauTheta;
    syms etaTheta;
    syms zTheta;
    syms P;

syms a;
syms b;

    %Equation to find the dimensionless time at impact (tauTheta)
    %fun = @(tau)(tan(theta)-eta(tau)/xi(tau));
    %options = optimoptions('fsolve','MaxFunctionEvaluations',1000, 'PlotFcn', @optimplotx);
    %tauTheta= sym(fsolve(fun,10,options));
    tauTheta = vpasolve(tan(theta) == eta(b)/xi(b), b, [0,pi/2*1/B]);

    etaTheta = eta(tauTheta);

    zTheta = sqrt(1-(Ro^2*(etaTheta-exp(tauTheta)*sin(theta))^2)/(etaTheta+exp(tauTheta)*sin(theta))^2);

    P = 1/(pi*Ro)*((exp(2*tauTheta)*(sin(theta))^2/etaTheta^2-1)*((Ro^2+1)*zTheta-zTheta^3/3)+Ro*(exp(2*tauTheta)*(sin(theta))^2/etaTheta^2+1)*(zTheta*sqrt(1-zTheta^2)+asin(zTheta)));

    P = double(P);


%     tauTheta=a;
%     etaTheta = eta(tauTheta);
%
%     zTheta = sqrt(1-(Ro^2*(etaTheta-exp(tauTheta)*sin(theta))^2)/(etaTheta+exp(tauTheta)*sin(theta))^2);
%
%     P = 1/(pi*Ro)*((exp(2*tauTheta)*(sin(theta))^2/etaTheta^2-1)*((Ro^2+1)*zTheta-zTheta^3/3)+Ro*(exp(2*tauTheta)*(sin(theta))^2/etaTheta^2+1)*(zTheta*sqrt(1-zTheta^2)+asin(zTheta)));
%
%     P = double(P);


end

if (option == 2)
    %For (Stk << 1), the penetration can be approximated by:
    P = 1-(2/pi + 1/Ro + 4/(3*pi*Ro^2))*Stk*theta;
end
%Deviation between the approximation and the full model
%Deviation = abs(P-P2);
%RelativeDeviation = Deviation/P;



%% Plotting the ratio between the dimensionless coordinates (xi, eta) as a function of dimensionless time (tau)

% syms xi(tauTheta);
% syms eta(tauTheta);
%
% xi(tauTheta) = cos(B*tauTheta)*(cosh(A*tauTheta)+(A^3/(A^2+B^2))*sinh(A*tauTheta))-(B^3*sin(B*tauTheta)*cosh(A*tauTheta))/(A^2+B^2);
% eta(tauTheta) = sin(B*tauTheta)*(sinh(A*tauTheta)+(A^3/(A^2+B^2))*cosh(A*tauTheta))+(B^3*cos(B*tauTheta)*sinh(A*tauTheta))/(A^2+B^2);
%
% tauThetaRange = (1:2:1000);
% DomainSizeX = size(tauThetaRange);
% final_i=DomainSizeX(2);
% y = zeros(1,final_i);
%
% for i=1:final_i
%     a=eta(tauThetaRange(i));
%     b=xi(tauThetaRange(i));
%     y(i) = (eta(tauThetaRange(i))/xi(tauThetaRange(i)));
% end
%
% figure
% plot(tauThetaRange,y)
% %xlim([0 90])
% title('Penetration')
% xlabel('Dimensionless time')
% ylabel('Penetration (fraction)')



%% Previous tests
% syms tauTheta;
% kk=(cos(B*tauTheta)*(cosh(A*tauTheta)+(A^3/(A^2+B^2))*sinh(A*tauTheta))-(B^3*sin(B*tauTheta)*cosh(A*tauTheta))/(A^2+B^2));
% kkk=(sin(B*tauTheta)*(sinh(A*tauTheta)+(A^3/(A^2+B^2))*cosh(A*tauTheta))+(B^3*cos(B*tauTheta)*sinh(A*tauTheta))/(A^2+B^2));
% kkkk=kkk/kk;
% xxx = fplot(kkkk, [10,600]);


% %syms xx;
% %tauTheta = vpasolve(tan(theta) == (sin(B*xx)*(sinh(A*xx)+(A^3/(A^2+B^2))*cosh(A*xx))+(B^3*cos(B*xx)*sinh(A*xx))/(A^2+B^2))/(cos(B*xx)*(cosh(A*xx)+(A^3/(A^2+B^2))*sinh(A*xx))-(B^3*sin(B*xx)*cosh(A*xx))/(A^2+B^2)), xx, [0 Inf]);
% %tauTheta = double (tauTheta);
%
% %etaTheta = sin(B*tauTheta)*(sinh(A*tauTheta)+(A^3/(A^2+B^2))*cosh(A*tauTheta))+(B^3*cos(B*tauTheta)*sinh(A*tauTheta))/(A^2+B^2);
%
% %etaTheta = eta(tauTheta);
%
% syms x;
% tttt = solve (x==eta(tauTheta),x);
% etaTheta = double(tttt);
%
% %zTheta = sqrt(1-(Ro^2*(etaTheta-exp(tauTheta)*sin(theta))^2)/(etaTheta+exp(tauTheta)*sin(theta))^2);
% %syms x;
% partial = solve (x==sqrt(1-(Ro^2*(etaTheta-exp(tauTheta)*sin(theta))^2)/(etaTheta+exp(tauTheta)*sin(theta))^2),x);
% zTheta = double(partial);
% %The model was tested for 100<Re<10000 and 0.03<Stk<1.46
% syms P;
% aa=solve(P == 1/(pi*Ro)*((exp(2*tauTheta)*(sin(theta))^2/etaTheta^2-1)*((Ro^2+1)*zTheta-zTheta^3/3)+Ro*(exp(2*tauTheta)*(sin(theta))^2/etaTheta^2+1)*(zTheta*sqrt(1-zTheta^2)+asin(zTheta))),P);
% Result = double (aa);


% syms xi(tauTheta);
% syms eta(tauTheta);
% xi(tauTheta) = (cos(B*tauTheta)*(cosh(A*tauTheta)+(A^3/(A^2+B^2))*sinh(A*tauTheta))-(B^3*sin(B*tauTheta)*cosh(A*tauTheta))/(A^2+B^2));
% eta(tauTheta) = (sin(B*tauTheta)*(sinh(A*tauTheta)+(A^3/(A^2+B^2))*cosh(A*tauTheta))+(B^3*cos(B*tauTheta)*sinh(A*tauTheta))/(A^2+B^2));
% a = vpasolve(tan(theta) == eta(tauTheta)/xi(tauTheta), tauTheta, [5,500]);


%syms fun(xxx);
%fun(xxx) = 1-(2/pi + 1/Ro + 4/(3*pi*xxx^2))*Stk*theta;
%fplot(fun(xxx), [50,90]);


end
