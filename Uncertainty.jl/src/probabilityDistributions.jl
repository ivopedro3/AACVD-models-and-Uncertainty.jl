# 𝓤
# Mathematical Alphanumeric Symbols: https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols

function 𝓝(μ, σ²)

    return Normal(μ, sqrt(σ²))

end

function Log𝓝(μ, σ²)

    return LogNormal(μ, sqrt(σ²))

end

function 𝓤(R)

    min = R[1]
    max = R[2]
    return Uniform(min, max)

end

function 𝓧²(k)

    return Chisq(k)

end
