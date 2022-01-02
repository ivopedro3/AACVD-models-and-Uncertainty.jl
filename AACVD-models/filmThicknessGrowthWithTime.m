function filmThickness = filmThicknessGrowthWithTime(t, C, v, w, x_beam, volumeReactor, filmDensity)

    %Molar concentration (C) of a chemical species as a function of time. SI units: (mol/(m3*t))

    %Time (t) SI units: s

    %Glass flow velocity (v) SI units: m/s

    %Glass width (w) SI units: m

    %Distance travelled by glass during chemical deposition (x_beam) SI units: m

    sizeOfVectort = size(t);
    t_deposition = x_beam/v;

    filmThickness = zeros(sizeOfVectort(1),1);

    for i = 1:sizeOfVectort(1)
        finalConcentration = C(i,7);
        finalAmount = finalConcentration * volumeReactor; %finalAmount [=] mol
        finalFilmVolume = finalAmount / filmDensity; %filmDensity [=] mol/m3
%         filmThickness(i) = finalFilmVolume / (w*v*t_deposition);
        filmThickness(i) = finalFilmVolume / (w*v*t(i));
    end

    filmThickness = filmThickness*1e6; %conversion from m (SI) to um
    figure1 = figure('PaperOrientation','landscape','Color',[1 1 1]);
    plot(t,filmThickness, 'LineWidth',5)
    xlabel('Time (s)')
    ylabel('Film thickness ({\mu}m)')
    set(gca,'FontSize', 20,'XGrid','on','YGrid','on')

end
