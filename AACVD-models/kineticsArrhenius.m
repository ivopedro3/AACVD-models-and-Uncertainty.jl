function k = kineticsArrhenius(parameters)

    %Frequency of collisions in the correct orientation (A) units vary for each chemical reaction
    A = parameters(1);

    %Activation energy for the reaction (E) SI units: J mol?1
    E = parameters(2);

    %Absolute temperature (T) SI units: K
    T = parameters(3);

    %Universal gas constant (R) SI units: J ?K?1? mol?1
    R = 8.314459;

    %Rate constant (k) units vary for each chemical reaction
    k = A*exp(-E/(R*T));

end
