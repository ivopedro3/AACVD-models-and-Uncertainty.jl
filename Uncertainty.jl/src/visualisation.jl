import Gadfly:plot

function plot(x::UncertainParameter)

    ## UnicodePlots
    # scat = scatterplot(x.x, x.P, title = "PDF")
    plot(x = x.x, y = x.P, Geom.point, Guide.xlabel("Parameter value"), Guide.ylabel("PDF"))

end
