function C = C_gen(q,dq)
%C_GEN
%    C = C_GEN(Q,DQ)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    29-Apr-2019 15:51:51

t2 = q.*1.0e4;
t3 = t2+1.0;
t4 = q+1.0e-4;
t5 = q./2.0;
t6 = t5+5.0e-5;
t7 = cos(t4);
t8 = 1.0./t3;
t9 = sin(t4);
t10 = 1.0./t3.^2;
t11 = t7./2.0;
t12 = t11-1.0./2.0;
t13 = sin(t6);
t14 = cos(t6);
t15 = t8.*t9.*4.2e2;
t16 = 1.0./t3.^3;
C = -dq.*(((t14.*(2.1e1./1.0e3)+t15+t10.*t12.*8.4e6).*(t13.*1.05e-2-t7.*t8.*4.2e2+t9.*t10.*8.4e6+t12.*t16.*1.68e11))./2.0e1-((t13.*(2.1e1./1.0e3)-t7.*t8.*4.2e2+t9.*t10.*4.2e6).*(t14.*1.05e-2+t15+t7.*t10.*8.4e6-t9.*t16.*8.4e10))./2.0e1);
