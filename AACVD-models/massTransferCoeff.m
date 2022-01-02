function h_m = massTransferCoeff(parameters)

    Pr = parameters(1);
    %horizontal distance from stagnation point
    x = parameters(2);
    d = parameters(3);
    Q = parameters(4);
    nu = parameters(5);
    %diffusivity
    D = parameters(6);

    U = 4*Q/(pi()*d^2);
    Re = U*d/nu;
    Nu = Pr^0.42 * (Re^3+10*Re^2)^.25 * (1-exp(-0.052*x/d))/(1.24*x/d);
    Sc = nu/D;
    Sh = Nu*(Sc/Pr)^0.42;

    h_m = Sh * D / d;

end
