function generateSamples(p, numberOfSamples)

    samples = zeros(numberOfSamples, length(p))
    for i = 1:numberOfSamples
        ind = 1
        for j in p
            samples[i,ind] = drawSample(j)
            ind += 1
        end
    end
    return samples

end

function drawSample(a::ProbabilityDistribution)

    return rand(a.category)

end

function drawSample(a::Distributions.Distribution)

    return rand(a)

end

function drawSample(a::Interval)

    return (a.min + rand()*(a.max - a.min))

end


function generateSamples(p::Array{Interval,1}, numberOfSamples)

    numberOfParameters = length(p)
    leftBound = zeros(numberOfParameters)
    rightBound = zeros(numberOfParameters)

    count = 1
    for i in p
        leftBound[count] = i.min
        rightBound[count] = i.max
        count = count+1
    end

    samples = latinHypercubeSampling(leftBound, rightBound, numberOfSamples)

end
