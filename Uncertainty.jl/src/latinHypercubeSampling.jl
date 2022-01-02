"""
    latin-hypercube-sampling(lowerLimit, upperLimit, numSamples)

    Randomly generates `numSamples` values from a parallelogram defined
    by the vectors `lowerLimit` and `upperLimit` using the Latin Hypercube algorithm.
"""

using Random

function latinHypercubeSampling(lowerLimit::AbstractVector{Float64}, upperLimit::AbstractVector{Float64}, numSamples::Integer)
    dim = length(lowerLimit)
    #@show(dim)
    samples = zeros(Float64, numSamples, dim)
    #@show(samples)
    for i in 1:dim
        intervalLength = (upperLimit[i] - lowerLimit[i]) / numSamples
        #@show(intervalLength)
        samples[:,i] = shuffle!(LinRange(lowerLimit[i], upperLimit[i] - intervalLength, numSamples) + intervalLength*rand(numSamples))
        #@show(samples)
    end
    return samples
end

function latinHypercubeSampling(lowerLimit::AbstractVector{Int64}, upperLimit::AbstractVector{Int64}, numSamples::Integer)
    dim = length(lowerLimit)
    #@show(dim)
    samples = zeros(Float64, numSamples, dim)
    #@show(samples)
    for i in 1:dim
        intervalLength = (upperLimit[i] - lowerLimit[i]) / numSamples
        #@show(intervalLength)
        samples[:,i] = shuffle!(LinRange(lowerLimit[i], upperLimit[i] - intervalLength, numSamples) + intervalLength*rand(numSamples))
        #@show(samples)
    end
    return samples
end

function latinHypercubeSampling(lowerLimit::AbstractVector{<:Number}, upperLimit::AbstractVector{<:Number}, numSamples::Integer)
    dim = length(lowerLimit)
    #@show(dim)
    samples = zeros(Float64, numSamples, dim)
    #@show(samples)
    for i in 1:dim
        intervalLength = (upperLimit[i] - lowerLimit[i]) / numSamples
        #@show(intervalLength)
        samples[:,i] = shuffle!(LinRange(lowerLimit[i], upperLimit[i] - intervalLength, numSamples) + intervalLength*rand(numSamples))
        #@show(samples)
    end
    return samples
end
