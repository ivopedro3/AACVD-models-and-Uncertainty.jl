%Droplets diameter as a function of temperature

function P = dropletsDiameterVariationTemperature()

%P = penetration = C/C0 = ratio between concentration at point x and initial concentration
    Ve=Vd*TETAc/pi + Vd/2 + Vg*cos(TETAc)/pi;
    P = exp(-(pi*d*Ve*X)/(Q));


end
