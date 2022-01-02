function densityOfVectors(A, xNumberOfIntervals, yNumberOfIntervals)

    dualA = zeros(size(A))

    length(A)

    numberOfDimensions = 2

    minValue = zeros(numberOfDimensions)

    minValue[1] = minimum(A[:,1])
    minValue[2] = minimum(A[:,2])

    maxValue = zeros(2)

    maxValue[1] = maximum(A[:,1])
    maxValue[2] = maximum(A[:,2])

    numberOfIntervals = zeros(numberOfDimensions)
    numberOfIntervals[1] = xNumberOfIntervals
    numberOfIntervals[2] = yNumberOfIntervals

    stepSize = zeros(numberOfDimensions)
    stepSize[1] = (maxValue[1] - minValue[1]) / numberOfIntervals[1]
    stepSize[2] = (maxValue[2] - minValue[2]) / numberOfIntervals[2]

    minValueDual = zeros(numberOfDimensions)

    dualA[:,1] = A[:,1] / stepSize[1]
    minValueDual[1] = minimum(dualA[:,1])
    dualA[:,1] = dualA[:,1] .- (minValueDual[1] - 1)

    dualA[:,2] = A[:,2] / stepSize[2]
    minValueDual[2] = minimum(dualA[:,2])
    dualA[:,2] = dualA[:,2] .- (minValueDual[2] - 1)

    dualMaxValueTrunc = zeros(Int, numberOfDimensions)
    dualMaxValueTrunc[1] = convert(Int, trunc(maximum(dualA[:,1])))
    dualMaxValueTrunc[2] = convert(Int, trunc(maximum(dualA[:,2])))

    dualATrunc = zeros(Int, size(A))
    for i=1:length(dualA)
        dualATrunc[i] = convert(Int, trunc(dualA[i]))
    end

    weights = zeros(dualMaxValueTrunc[1], dualMaxValueTrunc[2])

    for i = 1:size(dualATrunc)[1]
        weights[dualATrunc[i,1],dualATrunc[i,2]] += 1
    end

    output = zeros(length(weights), numberOfDimensions+1)

    l = [1] #why isn't an integer known inside for???
    for i = 1:size(weights)[1]
        for j = 1:size(weights)[2]
            output[l[1],1] = ((i + 0.5) + (minValueDual[1] - 1)) * stepSize[1]
            output[l[1],2] = ((j + 0.5) + (minValueDual[2] - 1)) * stepSize[2]
            output[l[1],3] = weights[i,j]
            l[1] += 1
        end
    end

    return output

end

#collect(Base.product([1,1],[10,10]))
