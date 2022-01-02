using Distributed

numWorkers = 6
addprocs(numWorkers)

@everywhere function parallelFilmFormation()

    @distributed for i=1:N
        parameters = [parameters; samples[i,:]]
        prob = ODEProblem(filmFormation,y0,tspan, parameters)
        sol = solve(prob)
        conc[i] = sol.u[end][1]
        parameters = [0.023; 0.083; 0.1; 0.1; 1e3; 0; 0]
    end

end



############## parallel arrays
#=
CPU_CORES = 6
addprocs(CPU_CORES - 1)
x = @DArray [@show x^2 for x = 1:10]
=#
