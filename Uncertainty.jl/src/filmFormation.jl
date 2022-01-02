function filmFormation(dydt,y,parameters,t)

     V = parameters[1];
     A = parameters[2];
     F_in = parameters[3];
     F_out = parameters[4];
     C_Ain = parameters[5];
     C_Bin = parameters[6];
     C_Cin = parameters[7];
     k1 = parameters[8];
     k2 = parameters[9];
     k3 = parameters[10];
     h_mA = parameters[11];
     h_mB = parameters[12];
     h_mC = parameters[13];


     dydt[1] = (F_in/V)*C_Ain - (F_out/V)*y[1] - h_mA*(A/V)*(y[1]-y[2]) - k1*y[1];
     dydt[2] = h_mA*(A/V)*(y[1]-y[2]) - k3*y[2]*(A/V);
     dydt[3] = (F_in/V)*C_Bin - (F_out/V)*y[3] - h_mB*(A/V)*(y[3]-y[4]) + k1*y[1];
     dydt[4] = h_mB*(A/V)*(y[3]-y[4]) - k2*y[4]*(A/V);
     dydt[5] =  (F_in/V)*C_Cin - (F_out/V)*y[5] - h_mC*(A/V)*(y[5]-y[6]) + k1*y[1];
     dydt[6] =  h_mC*(A/V)*(y[5]-y[6]) + k2*y[4]*(A/V) + 2*k3*y[2]*(A/V);
     dydt[7] = k2*y[4]*(A/V) + k3*y[2]*(A/V);

end

#function filmFormation(k::Array{UncertainParameter,1}, h::Array{UncertainParameter,1}, numberOfSamples)
function filmFormation(k, h, numberOfSamples)

    uncertParameters = [k h]
    samples = generateSamples(uncertParameters, numberOfSamples)
    parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0; 1; 1; 1; 1; 1; 1]
    y0 = [1e3; 0; 0;  0; 0;  0; 0]
    #tspan = (0.000, 0.1)
    tspan = (0.000, 0.01)

    concA = zeros(numberOfSamples);
    concD = zeros(numberOfSamples);

    for i=1:numberOfSamples
        parameters[8:13] = samples[i,:]
        prob = ODEProblem(filmFormation,y0,tspan, parameters)
        sol = solve(prob)
        concA[i] = sol.u[end][1]
        concD[i] = sol.u[end][7]
    end

    C_A = ProbabilityDistribution(concA)
    C_D = ProbabilityDistribution(concD)

    return C_A, C_D

end


########## Version 2

function filmFormation2(dydt,y,parameters,t)

    V = parameters[1];
    V_interface = parameters[2];
    A = parameters[3];
    ro_f = parameters[4];
    F_in = parameters[5];
    F_out = parameters[6];
    C_Ain = parameters[7];
    C_Bin = parameters[8];
    C_Cin = parameters[9];
    C_Din = parameters[10];
    k1 = parameters[11];
    k2 = parameters[12];
    k3 = parameters[13];
    h_mA = parameters[14];
    h_mB = parameters[15];
    h_mC = parameters[16];
    h_mD = parameters[17];

    #display(k3)

    dydt[1] = F_in*C_Ain - F_out*y[1]/V - h_mA*A*(y[1]/V - y[2]/V_interface) - k1*y[1];
    dydt[2] = h_mA*A*(y[1]/V - y[2]/V_interface) - k3*y[2]/V_interface*A;
    dydt[3] = F_in*C_Bin - F_out*y[3]/V - h_mB*A*(y[3]/V - y[4]/V_interface) + k1*y[1];
    dydt[4] = h_mB*A*(y[3]/V - y[4]/V_interface) - k2*y[4]/V_interface*A;
    dydt[5] = F_in*C_Cin - F_out*y[5]/V - h_mC*A*(y[5]/V - y[6]/V_interface) + k1*y[1];
    dydt[6] = h_mC*A*(y[5]/V - y[6]/V_interface) + k2*y[4]/V_interface*A + 2*k3*y[2]/V_interface*A;
    dydt[7] = F_in*C_Din - F_out*y[7]/V - h_mD*A*(y[7]/V - y[8]/V_interface);
    dydt[8] = h_mD*A*(y[7]/V - y[8]/V_interface) + k2*y[4]/V_interface*A + k3*y[2]/V_interface*A;

end

function filmFormation2(k, h, numberOfSamples)

    uncertParameters = [k; h]
    samples = generateSamples(uncertParameters, numberOfSamples)
    #   parameters = [V; V_interface; A; ro_f; F_in; F_out; C_Ain; C_Bin; C_Cin; C_Din; k1; k2; k3; h_mA; h_mB; h_mC; h_mD]
    parameters = [0.000135; 1e-5; 0.0045; 70000; 1.67e-5; 1.67e-5; 0.152; 0; 0; 0; 1; 1; 1; 1; 1; 1; 1]
    y0 = [0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0]
    #tspan = (0.000, 0.1)
    #tspan = (0.0, 300.0)
    tspan = (0.0, 120)

    concA = zeros(numberOfSamples);
    concD = zeros(numberOfSamples);

    for i=1:numberOfSamples
        parameters[11:17] = samples[i,:]
        prob = ODEProblem(filmFormation2,y0,tspan, parameters)
        # display(parameters[1:4])
        # display(parameters[5:8])
        # display(parameters[9:12])
        # display(parameters[13:16])
        # display(parameters[17])
        sol = solve(prob)
        concA[i] = sol.u[end][1]
        concD[i] = sol.u[end][8]
    end

    C_A = ProbabilityDistribution(concA)
    C_D = ProbabilityDistribution(concD)

    return C_A, C_D

end
