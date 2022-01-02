#include("overloadTilde.jl")


macro distributions(args...)

  for ex in args

      if isa(ex, Symbol)
          println("Symb $ex")

      elseif isa(ex, Integer)
          println("Int $ex")

      elseif isa(ex, Bool)
          println("bool $ex")
      else
          for x in ex
              println("ELSE $x")
          end
      end
  end



  # show(args)
  # println("$(args[1])")
  # model = esc(args[1])

  #show(model)

  #println("$(length(args)) arguments")
  #println("$(args[1])")
  #x= eval(args[1]);
  #println("This is X: $x")
  #x.mean = 777;

  #println("Mean: $(x.mean)")



  #c = ProbabilityDistribution(10)
  #d = ProbabilityDistribution(20)

  return args

end
