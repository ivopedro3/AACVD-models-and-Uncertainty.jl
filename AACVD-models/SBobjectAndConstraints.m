function [f, g] = SBobjectAndConstraints(x)

  f = penetrationMINLP(x);
  g = -1;

%Constraints
%   g = max([
%            ]);

%   g = max([ x(1) + xLB(1);
%             x(1) - xUB(1);
%             x(2) + xLB(2);
%             x(2) - xUB(2);
%             x(3) + xLB(3);
%             x(3) - xUB(3);
%             x(4) + xLB(4);
%             x(4) - xUB(4);
%            ]);
end
