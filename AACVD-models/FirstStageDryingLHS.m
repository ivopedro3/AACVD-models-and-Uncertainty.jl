function time = FirstStageDryingLHS(x)

    T_d0 = 25+273;


    %[1.71875e+03 305.15  1.1961875e+06 2.9475e-5 0.0454 0.21 0.616 792 2.484375e+03]
    c_pv = x(1);
    T_g = x(2);
    h_fg = x(3);
    mu_g = x(4);
    k_g = x(5);
    u_g = x(6);
    ro_g = x(7);
    ro_dw = x(8);
    c_pd = x(9);


    for R_d0 = 2:1:7
        R_d0 = R_d0*1e-6;

        TimeDomain = [0 .5];
        IC1 = R_d0;
        IC2 = T_d0;
        IC = [IC1 IC2];
        [IVsol, DVsol(:,1)] = ode23('firstStageDryingDifferentials', TimeDomain, IC);
    end


    plot(IVsol, DVsol,'LineWidth',2)

end
