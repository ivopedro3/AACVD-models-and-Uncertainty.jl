function diff = filmFormationFullODE45uncertainADECoeffMolar(t, y)
%% Reactions
% A(g) -vap-> B(g) + C(g)
% B(g) -surf-> D(s) + C(g)
% A(g) -surf-> D(s) + 2C(g)


%parameters = [V, A, ro_f, F_in, F_out, C_Ain, C_Bin, C_Cin, C_Din, k1, k2, k3, h_mA, h_mB, h_mC, h_mD]

parameters = filmFormationFullODE45uncertainADECoeffParMolar(t);


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


diff = zeros(8,1);

% for i=1:9
%     if y(i) < 0
%         y(i) = 0;
%     end
% end

Vo = 10e-8;
Vf = Vo + (y(2) + y(4) + y(6) + y(8)) / ro_f;


%Differential equations
diff(1) = F_in*C_Ain - F_out*(y(1)/V) - h_mA*A*(y(1)/V - y(2)/Vf) - k1*y(1);
diff(2) = h_mA*A*(y(1)/V - y(2)/Vf) - k3*y(2)/Vf*A;
diff(3) = F_in*C_Bin - F_out*(y(3)/V) - h_mB*A*(y(3)/V - y(4)/Vf) + k1*y(1);
diff(4) = h_mB*A*(y(3)/V - y(4)/Vf) - k2*y(4)/Vf*A;
diff(5) = F_in*C_Cin - F_out*(y(5)/V) - h_mC*A*(y(5)/V - y(6)/Vf) + k1*y(1);
diff(6) = h_mC*A*(y(5)/V - y(6)/Vf) + k2*y(4)/Vf*A + 2*k3*y(2)/Vf*A;
diff(7) = F_in*C_Din - F_out*(y(7)/V) - h_mD*A*(y(7)/V - y(8)/Vf);
diff(8) = h_mD*A*(y(7)/V - y(8)/Vf) + k2*y(4)/Vf*A + k3*y(2)/Vf*A;

Vf = Vf*1e7;
fileID = fopen('volume.txt','a');
fprintf(fileID,'\n%e',Vf);
fclose(fileID);

end
