function x = SBrandom()

% xLB = [2e-5; 1;  0.1e-6; 0.01];
% xUB = [5e-3; 10; 0.3e-6; 0.05];

xLB = [2e-5; 1; 4e-6;  0.01];
xUB = [5e-3; 10;10e-6; 0.05];

  % I can easily generalise the following using one line and for any
  % number of 'x' entries...
  x = [ (xUB(1)-xLB(1)).*rand() + xLB(1);
        (xUB(2)-xLB(2)).*rand() + xLB(2);
        (xUB(3)-xLB(3)).*rand() + xLB(3);
        (xUB(4)-xLB(4)).*rand() + xLB(4);
      ];
  x(2) = round(x(2));
end
