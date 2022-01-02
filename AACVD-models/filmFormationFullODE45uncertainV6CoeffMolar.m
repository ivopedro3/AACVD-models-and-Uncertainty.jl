function diff = filmFormationFullODE45uncertainV6CoeffMolar(t, y)
%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)


%parameters = [V, A, ro_f, F_in, F_out, C_Ain, C_Bin, C_Cin, C_Din, k1, k2, k3, h_mA, h_mB, h_mC, h_mD]

parameters = filmFormationFullODE45uncertainV6CoeffParMolar(t,y);


V = parameters(1);
V_interface = parameters(2);
A = parameters(3);
ro_f = parameters(4);
F_in = parameters(5);
F_out = parameters(6);
C_Ain = parameters(7);
C_Bin = parameters(8);
C_Cin = parameters(9);
C_Din = parameters(10);
k1 = parameters(11);
k2 = parameters(12);
k3 = parameters(13);
h_mA = parameters(14);
h_mB = parameters(15);
h_mC = parameters(16);
h_mD = parameters(17);

diff = zeros(9,1);

% for i=1:9
%     if y(i) < 0
%         y(i) = 0;
%     end
% end

%y(9) = (y(2) + y(4) + y(6) + y(8)) / ro_f;

%Differential equations

diff(1) = - h_mA*A*(y(1)/V - y(2)/V_interface) - k1*y(1);
diff(2) = h_mA*A*(y(1)/V - y(2)/V_interface) - k3*y(2)/V_interface*A;
diff(3) = - h_mB*A*(y(3)/V - y(4)/V_interface) + k1*y(1);
diff(4) = h_mB*A*(y(3)/V - y(4)/V_interface) - k2*y(4)/V_interface*A;
diff(5) = - h_mC*A*(y(5)/V - y(6)/V_interface) + k1*y(1);
diff(6) = h_mC*A*(y(5)/V - y(6)/V_interface) + k2*y(4)/V_interface*A + 2*k3*y(2)/V_interface*A;
diff(7) = - h_mD*A*(y(7)/V - y(8)/V_interface);
diff(8) = h_mD*A*(y(7)/V - y(8)/V_interface) + k2*y(4)/V_interface*A + k3*y(2)/V_interface*A;
diff(9) = (diff(8)) / ro_f;


end
