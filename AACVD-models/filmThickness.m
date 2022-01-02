function filmThickness = filmThickness(t, C, v, w, x_beam, volumeReactor, filmDensity)

    %Molar concentration (C) of a chemical species as a function of time. SI units: (mol/(m3*t))

    %Time (t) SI units: s

    %Glass flow velocity (v) SI units: m/s

    %Glass width (w) SI units: m

    %Distance travelled by glass during chemical deposition (x_beam) SI units: m

    t_deposition = x_beam/v;

    i=1;
    while (2*t_deposition > t(i))
        if t_deposition < t(i)
            %t_deposition determines the i to look up the concentration at time t_deposition
            finalConcentration = C(i,7);
            finalAmount = finalConcentration * volumeReactor; %finalAmount [=] mol
            finalFilmVolume = finalAmount / filmDensity; %filmDensity [=] mol/m3
            filmThickness = finalFilmVolume / (w*v*t_deposition);
            break
        end
        i = i+1;
    end


end
