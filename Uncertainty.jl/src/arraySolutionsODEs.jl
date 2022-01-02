function arraySolutionsODEs(x)

    a = size(x)
    println("$a")
    sol = zeros(a[2],a[1])
    for i=1:a[2]
        sol[i, :] = x.u[i]
    end
    return sol

end
