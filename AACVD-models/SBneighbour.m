function x = SBneighbour(x0,f)

% xLB = [2e-5; 1;  0.1e-6; 0.01];
% xUB = [5e-3; 10; 0.3e-6; 0.05];

xLB = [2e-5; 1; 4e-6;  0.01];
xUB = [5e-3; 10;10e-6; 0.05];

  x = x0 + (1-f)*2*(rand(length(x0),1)-0.5).*(xUB-xLB);
  x(2) = round(x(2));


  for i=1:4
    if(x(i) < xLB(i))
      x(i) = xLB(i);
    end

    if(x(i) > xUB(i))
      x(i) = xUB(i);
    end
  end


end
