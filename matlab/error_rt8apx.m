function error = error_rt8apx(x,x_r)

e1 = x(1) & x(2) & x(3) & x(4);
e2 = x(5) & x(6) & x(7) & x(8);

s1 = xor( xor(x(1),x(2)), xor(x(3),x(4)) ) | e1;
s2 = xor( xor(x(5),x(6)), xor(x(7),x(8)) ) | e2;

c1_r=(sum(x_r(1:4))>=2);
c2_r=(sum(x_r(5:8))>=2);

e1_f = e1 & c1_r;
e2_f = e2 & c2_r;

c1_f = c1_r | e1;
c2_f = c2_r | e2;

e3 = s1 & s2 & c1_f & c2_f;

error = e1_f + e2_f + e3;

%e1 = x(1) & x(2) & x(3) & x(4)
%e2 = x(5) & x(6) & x(7) & x(8)
%
%s1 = xor( xor(x(1),x(2)), xor(x(3),x(4)) ) | e1
%s2 = xor( xor(x(5),x(6)), xor(x(7),x(8)) ) | e2
%
%c1_r=(sum(x_r(1:4))>=2)
%c2_r=(sum(x_r(5:8))>=2)
%
%e1_f = e1 & c1_r
%e2_f = e2 & c2_r
%
%c1_f = c1_r | e1
%c2_f = c2_r | e2
%
%e3 = s1 & s2 & c1_f & c2_f
%
%error = e1_f + e2_f + e3

end
