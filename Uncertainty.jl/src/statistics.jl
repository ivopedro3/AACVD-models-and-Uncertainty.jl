 function quantiles(x)

     vectorSize = length(x)
     xCopy = copy(x)

     mean = sum(xCopy) / vectorSize

     sort!(xCopy)

     minimum = xCopy[1]

     if iseven(vectorSize)
          half = convert(Int, vectorSize / 2)
          median = (xCopy[half] + xCopy[half+1]) / 2
     else
          half = convert((vectorSize+1) / 2)
          median = xCopy[half]
     end

     maximum = xCopy[vectorSize]

     #for large vector sizes
     entry25 = vectorSize/4
     entry25 = convert(Int, entry25)
     entry75 = entry25*3

     percentile25 = xCopy[entry25]

     percentile75 = xCopy[entry75]

     return mean, minimum, percentile25, median, percentile75, maximum

 end


 function quantiles(x, P, q)

      A = 0;
      i=1
      vectorSize = length(x)

      while A < q/100 && i < (vectorSize-1)
           A += ((P[i] + P[i+1])/2) * (x[i+1]-x[i])
           i+=1
      end
      #The total area (A for q=100) under the pdf must be 1


      #Mean for general pdf
      prod = x.*P
      A2 = 0
      for j=1:vectorSize-1
           A2 += ((prod[j] + prod[j+1])/2) * (x[j+1]-x[j])
      end
      mean = A2

      #=
      println("min: $(x[1])")
      println("$q: $(x[i])")
      println("mean: $mean")
      println("max: $(x[vectorSize])")
      =#

      #The q-th percentile is x[i]
      return q, x[i], mean

  end


  function quantiles(x, P)

       A = 0;
       i=1
       vectorSize = length(x)

       while A < .25
            A += ((P[i] + P[i+1])/2) * (x[i+1]-x[i])
            i+=1
       end

       percentile25 = x[i]

       while A < .5
            A += ((P[i] + P[i+1])/2) * (x[i+1]-x[i])
            i+=1
       end

       percentile50 = x[i]

       while A < .75
            A += ((P[i] + P[i+1])/2) * (x[i+1]-x[i])
            i+=1
       end

       percentile75 = x[i]

       return percentile25, percentile50, percentile75

   end

#=

function mean(x)

    mean = sum(x)/length(x)

end
=#
