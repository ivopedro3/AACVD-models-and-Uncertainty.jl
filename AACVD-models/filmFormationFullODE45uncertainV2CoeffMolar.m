function diff = filmFormationFullODE45uncertainV2CoeffMolar(t, y)
%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)


%parameters = [V, A, ro_f, F_in, F_out, C_Ain, C_Bin, C_Cin, C_Din, k1, k2, k3, h_mA, h_mB, h_mC, h_mD]

parameters = filmFormationFullODE45uncertainCoeffParMolar(t);


V = parameters(1);
A = parameters(2);
ro_f = parameters(3);
F_in = parameters(4);
F_out = parameters(5);
C_Ain = parameters(6);
C_Bin = parameters(7);
C_Cin = parameters(8);
C_Din = parameters(9);
k1 = parameters(10);
k2 = parameters(11);
k3 = parameters(12);
h_mA = parameters(13);
h_mB = parameters(14);
h_mC = parameters(15);
h_mD = parameters(16);

diff = zeros(9,1);

% for i=1:9
%     if y(i) < 0
%         y(i) = 0;
%     end
% end

% y(9) = (y(2) + y(4) + y(6) + y(8)) / ro_f;

%Differential equations
if y(9) == 0
    diff(1) = F_in*C_Ain - F_out*(y(1)/V) - h_mA*A*(y(1)/V - 0) - k1*y(1);
    diff(2) = h_mA*A*(y(1)/V - 0) - k3*y(2);
    diff(3) = F_in*C_Bin - F_out*(y(3)/V) - h_mB*A*(y(3)/V - 0) + k1*y(1);
    diff(4) = h_mB*A*(y(3)/V - 0) - k2*y(4);
    diff(5) = F_in*C_Cin - F_out*(y(5)/V) - h_mC*A*(y(5)/V - 0) + k1*y(1);
    diff(6) = h_mC*A*(y(5)/V - 0) + k2*y(4) + 2*k3*y(2);
    diff(7) = F_in*C_Din - F_out*(y(7)/V) - h_mD*A*(y(7)/V - 0);
    diff(8) = h_mD*A*(y(7)/V - 0) + k2*y(4) + k3*y(2);
    diff(9) = (diff(2) + diff(4) + diff(6) + diff(8)) / ro_f;
else
    diff(1) = F_in*C_Ain - F_out*(y(1)/V) - h_mA*A*(y(1)/V - y(2)/y(9)) - k1*y(1);
    diff(2) = h_mA*A*(y(1)/V - y(2)/y(9)) - k3*y(2);
    diff(3) = F_in*C_Bin - F_out*(y(3)/V) - h_mB*A*(y(3)/V - y(4)/y(9)) + k1*y(1);
    diff(4) = h_mB*A*(y(3)/V - y(4)/y(9)) - k2*y(4);
    diff(5) = F_in*C_Cin - F_out*(y(5)/V) - h_mC*A*(y(5)/V - y(6)/y(9)) + k1*y(1);
    diff(6) = h_mC*A*(y(5)/V - y(6)/y(9)) + k2*y(4) + 2*k3*y(2);
    diff(7) = F_in*C_Din - F_out*(y(7)/V) - h_mD*A*(y(7)/V - y(8)/y(9));
    diff(8) = h_mD*A*(y(7)/V - y(8)/y(9)) + k2*y(4) + k3*y(2);
    diff(9) = (diff(2) + diff(4) + diff(6) + diff(8)) / ro_f;
end


end
